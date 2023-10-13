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

    public override void beforeInsert()
    {}
    public override void beforeUpdate()
    {}
    public override void beforeDelete()
    {}
    public override void afterUpdate()
    {

         // Create a new Task for a job application Status changes
         List<Task> tasks = new List<Task>();
         for (Job_Applications__c jobApp : this.jobAppList){

            if(jobApp.Status__c == 'Applying')
            {
                //Task for setting up an interview.
                Task tsk = new Task();
                tsk.Subject = 'Set up an informational interview.';
                tsk.Priority = 'Normal';
                tsk.Status = 'Not Started';
                tsk.WhatId = jobApp.Id;
                tsk.WhoId = jobApp.Primary_Contact__c;
                tsk.OwnerId = jobApp.OwnerId;
                tsk.ActivityDate = Date.today().addDays(15);
                tasks.add(tsk);

                //Task to find a referral
                Task reftsk = new Task();
                reftsk.Subject = 'Identify potential referrals.';
                reftsk.Priority = 'Normal';
                reftsk.Status = 'Not Started';
                reftsk.WhatId = jobApp.Id;
                reftsk.WhoId = jobApp.Primary_Contact__c;
                reftsk.OwnerId = jobApp.OwnerId;
                reftsk.ActivityDate = Date.today().addDays(15);

                tasks.add(reftsk);
            }
             
            else if (jobApp.Status__c == 'Saved') {

                // Check if the job description aligns with your interests and values
                Task task1 = new Task();
                task1.Subject = 'Check if the job description aligns with your interests and values';
                task1.Priority = 'High';
                task1.Status = 'Not Started';
                task1.WhatId = jobApp.Id;
                task1.WhoId = jobApp.Primary_Contact__c;
                task1.OwnerId = jobApp.OwnerId;
                task1.ActivityDate = Date.today().addDays(2);
                tasks.add(task1);
    
                // Review the highlighted skills to see if the role is a good fit
                Task task2 = new Task();
                task2.Subject = 'Review the highlighted skills to see if the role is a good fit';
                task2.Priority = 'Normal';
                task2.Status = 'Not Started';
                task2.WhatId = jobApp.Id;
                task2.WhoId = jobApp.Primary_Contact__c;
                task2.OwnerId = jobApp.OwnerId;
                task2.ActivityDate = Date.today().addDays(3);
                tasks.add(task2);
    
                //Research the company or role and mark your excitement level
                Task task3 = new Task();
                task3.Subject = 'Research the company or role and mark your excitement level';
                task3.Priority = 'Normal';
                task3.Status = 'Not Started';
                task3.WhatId = jobApp.Id;
                task3.WhoId = jobApp.Primary_Contact__c;
                task3.OwnerId = jobApp.OwnerId;
                task3.ActivityDate = Date.today().addDays(4);
                tasks.add(task3);
        }
    }
    insert tasks;

}
   
    public override void afterDelete()
    {}
   
    public override void afterUndelete()
    {}
   
}