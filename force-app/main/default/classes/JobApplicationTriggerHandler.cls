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
         for (Job_Applications__c jobApp : this.jobAppList){

            if (jobApp.Status__c == 'Saved') {

                // Check if the job description aligns with your interests and values
                Task task1 = new Task();
                task1.Subject = 'Check if the job description aligns with your interests and values';
                task1.Priority = 'High';
                task1.Status = 'Not Started';
                task1.WhatId = jobApp.Id;
                task1.WhoId = jobApp.Primary_Contact__c;
                task1.OwnerId = jobApp.OwnerId;
                task1.ActivityDate = Date.today().addDays(1);
                tasks.add(task1);
    
                // Review the highlighted skills to see if the role is a good fit
                Task task2 = new Task();
                task2.Subject = 'Review the highlighted skills to see if the role is a good fit';
                task2.Priority = 'Normal';
                task2.Status = 'Not Started';
                task2.WhatId = jobApp.Id;
                task2.WhoId = jobApp.Primary_Contact__c;
                task2.OwnerId = jobApp.OwnerId;
                task2.ActivityDate = Date.today().addDays(1);
                tasks.add(task2);
    
                // Research the company or role and mark your excitement level
                Task task3 = new Task();
                task3.Subject = 'Research the company or role and mark your excitement level';
                task3.Priority = 'Normal';
                task3.Status = 'Not Started';
                task3.WhatId = jobApp.Id;
                task3.WhoId = jobApp.Primary_Contact__c;
                task3.OwnerId = jobApp.OwnerId;
                task3.ActivityDate = Date.today().addDays(1);
                tasks.add(task3);

            }

            else if (jobApp.Status__c == 'Applying')
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
                tasks =  JobApplicationHelper.tasksWhenClosed(tasks,jobApp);
            }

            else if (jobApp.Status__c == 'Interviewing') {

                // Prepare your blurb or “tell me about yourself” response
                Task taskinterviewing1 = new Task();
                taskinterviewing1.Subject = 'Prepare your blurb or "tell me about yourself" response';
                taskinterviewing1.Priority = 'High';
                taskinterviewing1.Status = 'Not Started';
                taskinterviewing1.WhatId = jobApp.Id;
                taskinterviewing1.WhoId = jobApp.Primary_Contact__c;
                taskinterviewing1.OwnerId = jobApp.OwnerId;
                taskinterviewing1.ActivityDate = Date.today().addDays(1);
                tasks.add(taskinterviewing1);

                // Practice answering behavioral interview questions
                Task taskinterviewing2 = new Task();
                taskinterviewing2.Subject = 'Practice answering behavioral interview questions';
                taskinterviewing2.Priority = 'Normal';
                taskinterviewing2.Status = 'Not Started';
                taskinterviewing2.WhatId = jobApp.Id;
                taskinterviewing2.WhoId = jobApp.Primary_Contact__c;
                taskinterviewing2.OwnerId = jobApp.OwnerId;
                taskinterviewing2.ActivityDate = Date.today().addDays(1);
                tasks.add(taskinterviewing2);
    
                // Research the company and your interviewers
                Task taskinterviewing3 = new Task();
                taskinterviewing3.Subject = 'Research the company and your interviewers';
                taskinterviewing3.Priority = 'Normal';
                taskinterviewing3.Status = 'Not Started';
                taskinterviewing3.WhatId = jobApp.Id;
                taskinterviewing3.WhoId = jobApp.Primary_Contact__c;
                taskinterviewing3.OwnerId = jobApp.OwnerId;
                taskinterviewing3.ActivityDate = Date.today().addDays(1);
                tasks.add(taskinterviewing3);
    
                // Set up your virtual interview space and test your tech
                Task taskinterviewing4 = new Task();
                taskinterviewing4.Subject = 'Set up your virtual interview space and test your tech';
                taskinterviewing4.Priority = 'Normal';
                taskinterviewing4.Status = 'Not Started';
                taskinterviewing4.WhatId = jobApp.Id;
                taskinterviewing4.WhoId = jobApp.Primary_Contact__c;
                taskinterviewing4.OwnerId = jobApp.OwnerId;
                taskinterviewing4.ActivityDate = Date.today().addDays(1);
                tasks.add(taskinterviewing4);
    
                // Send thank you emails within 24 hours
                Task taskinterviewing5 = new Task();
                taskinterviewing5.Subject = 'Send thank you emails within 24 hours';
                taskinterviewing5.Priority = 'Normal';
                taskinterviewing5.Status = 'Not Started';
                taskinterviewing5.WhatId = jobApp.Id;
                taskinterviewing5.WhoId = jobApp.Primary_Contact__c;
                taskinterviewing5.OwnerId = jobApp.OwnerId;
                taskinterviewing5.ActivityDate = Date.today().addDays(2);
                tasks.add(taskinterviewing5);
            }

            else if (jobApp.Status__c == 'Negotiating') {
                
                // Research your market value and know your numbers
                Task tasknegotiating1 = new Task();
                tasknegotiating1.Subject = 'Research your market value and know your numbers';
                tasknegotiating1.Priority = 'High';
                tasknegotiating1.Status = 'Not Started';
                tasknegotiating1.WhatId = jobApp.Id;
                tasknegotiating1.WhoId = jobApp.Primary_Contact__c;
                tasknegotiating1.OwnerId = jobApp.OwnerId;
                tasknegotiating1.ActivityDate = Date.today().addDays(1);
                tasks.add(tasknegotiating1);

                // Prepare your negotiation scripts
                Task tasknegotiating2 = new Task();
                tasknegotiating2.Subject = 'Prepare your negotiation scripts';
                tasknegotiating2.Priority = 'Normal';
                tasknegotiating2.Status = 'Not Started';
                tasknegotiating2.WhatId = jobApp.Id;
                tasknegotiating2.WhoId = jobApp.Primary_Contact__c;
                tasknegotiating2.OwnerId = jobApp.OwnerId;
                tasknegotiating2.ActivityDate = Date.today().addDays(1);
                tasks.add(tasknegotiating2);

                // Evaluate your offer and decline or accept
                Task tasknegotiating3 = new Task();
                tasknegotiating3.Subject = 'Evaluate your offer and decline or accept';
                tasknegotiating3.Priority = 'Normal';
                tasknegotiating3.Status = 'Not Started';
                tasknegotiating3.WhatId = jobApp.Id;
                tasknegotiating3.WhoId = jobApp.Primary_Contact__c;
                tasknegotiating3.OwnerId = jobApp.OwnerId;
                tasknegotiating3.ActivityDate = Date.today().addDays(3);
                tasks.add(tasknegotiating3);
             
        }
    }
    insert tasks;

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