public with sharing class JobApplicationTriggerHandler extends TriggerHandler{

    private List<Job_Applications__c> jobAppList;
    private List<Job_Applications__c> oldjobAppList;
    private Map<Id, Job_Applications__c> jobAppOldMap;
    private Map<Id, Job_Applications__c> jobAppNewMap;

    public JobApplicationTriggerHandler() {

        this.jobAppList = (List<Job_Applications__c>)Trigger.new;
        this.jobAppNewMap = (Map<Id, Job_Applications__c>)Trigger.newMap;
        this.jobAppOldMap = (Map<Id, Job_Applications__c>)Trigger.oldMap;
        this.oldjobAppList = (List<Job_Applications__c>)Trigger.old;
    }

    
    
    public override void afterInsert()
    {
         // Create a new Task for newly inserted job application
         List<Task> tasks = new List<Task>();
        
         for (Job_Applications__c jobApp : this.jobAppList){

             Task tsk = new Task();
             tsk.Subject = 'Make a follow-up Call';
             tsk.WhatId = jobApp.Id;
             tsk.WhoId = jobApp.Primary_Contact__c;
             tsk.OwnerId = jobApp.OwnerId;
             tsk.ActivityDate = Date.today().addDays(7);
             tasks.add(tsk);
         }
             insert tasks;

    }

    
    //automation to set the primary contact on the job application if the primary contact is null
    public override void beforeUpdate()
    {

        Set<Id> jobAppIds = new Set<Id>();
        for(Job_Applications__c job : this.jobAppList){
            jobAppIds.add(job.Id);
        }
    
        Map<Id, Contact> contacts = new Map<Id, Contact>([SELECT Id, LastName, Job_Application_Contacts__r.Id  FROM Contact WHERE Job_Application_Contacts__r.Id IN :jobAppIds]);
        Map<Id, Contact> jobIdToContact = new Map<Id, Contact>();

        for (Contact cont : contacts.values()) {
            if (!jobIdToContact.containsKey(cont.Job_Application_Contacts__r.Id)) {
                jobIdToContact.put(cont.Job_Application_Contacts__r.Id, cont);
            }
        }

        for(Job_Applications__c jobApp : this.jobAppList){
            if(jobApp.Primary_Contact__c == null){
                if (jobIdToContact.containsKey(jobApp.Id)){
                    jobApp.Primary_Contact__c = jobIdToContact.get(jobApp.Id).Id;
                }
            }
        }
       
    }
   

    public override void afterUpdate()
    {

         // Create a new Task for a job application Status changes
        List<Task> tasks = new List<Task>();
            
        for (Job_Applications__c jobApp : this.jobAppList)
        { 
            if(jobApp.Status__c == 'Applying')
            {
                tasks =  JobApplicationHelper.tasksWhenApplying(tasks,jobApp);
            }
            else if(jobApp.Status__c == 'Applied')
            {
                tasks =  JobApplicationHelper.tasksWhenApplied(tasks,jobApp);
            }
            else if(jobApp.Status__c == 'Accepted')
            {
                tasks =  JobApplicationHelper.tasksWhenAccepted(tasks,jobApp);
            }
            else if(jobApp.Status__c == 'Closed')
            {
                tasks =  JobApplicationHelper.tasksWhenAccepted(tasks,jobApp);
            }
         }
             if(!tasks.isEmpty())
             {
                insert tasks;
             }
             
    }
   
    public override void afterDelete()
    {}
   
    public override void afterUndelete()
    {}
    public override void beforeDelete()
    {}
    public override void beforeInsert()
    {}
   
}