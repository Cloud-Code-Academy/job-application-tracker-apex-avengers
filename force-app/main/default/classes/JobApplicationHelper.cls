public with sharing class JobApplicationHelper {
    
    public static List<Task> tasksWhenApplying(List<Task> tasks, Job_Applications__c jobApp)
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
         
         return tasks;
    }

    public static List<Task> tasksWhenApplied(List<Task> tasks, Job_Applications__c jobApp)
    {
         //Task for setting up an interview.
         Task tsk = new Task();
         tsk.Subject = 'Set up weekly networking calls to explore similar companies/roles.';
         tsk.Priority = 'Normal';
         tsk.Status = 'Not Started';
         tsk.WhatId = jobApp.Id;
         tsk.WhoId = jobApp.Primary_Contact__c;
         tsk.OwnerId = jobApp.OwnerId;
         tsk.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk);

         //Task to find a referral
         Task reftsk = new Task();
         reftsk.Subject = 'Follow up on your application via email weekly.';
         reftsk.Priority = 'Normal';
         reftsk.Status = 'Not Started';
         reftsk.WhatId = jobApp.Id;
         reftsk.WhoId = jobApp.Primary_Contact__c;
         reftsk.OwnerId = jobApp.OwnerId;
         reftsk.ActivityDate = Date.today().addDays(15);

         tasks.add(reftsk);
         
         return tasks;
    }
    public static List<Task> tasksWhenClosed(List<Task> tasks, Job_Applications__c jobApp)
    {
         //Task for send the follow-up.
         Task tsk = new Task();
         tsk.Subject = 'Send a follow-up email thanking the interviewer and asking for feedback.';
         tsk.Priority = 'Normal';
         tsk.Status = 'Not Started';
         tsk.WhatId = jobApp.Id;
         tsk.WhoId = jobApp.Primary_Contact__c;
         tsk.OwnerId = jobApp.OwnerId;
         tsk.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk);

         //Task to Review your notes and reflect on areas of improvement.
         Task revtsk = new Task();
         revtsk.Subject = 'Review your notes and reflect on areas of improvement.';
         revtsk.Priority = 'Normal';
         revtsk.Status = 'Not Started';
         revtsk.WhatId = jobApp.Id;
         revtsk.WhoId = jobApp.Primary_Contact__c;
         revtsk.OwnerId = jobApp.OwnerId;
         revtsk.ActivityDate = Date.today().addDays(15);

         tasks.add(revtsk);
         
         return tasks;
    }

    public static List<Task> tasksWhenAccepted(List<Task> tasks, Job_Applications__c jobApp)
    {
         //Task for Plan your resignation if applicable.
         Task tsk = new Task();
         tsk.Subject = 'Plan your resignation if applicable.';
         tsk.Priority = 'Normal';
         tsk.Status = 'Not Started';
         tsk.WhatId = jobApp.Id;
         tsk.WhoId = jobApp.Primary_Contact__c;
         tsk.OwnerId = jobApp.OwnerId;
         tsk.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk);

         //Task to take some time to relax and recharge
         Task reftsk = new Task();
         reftsk.Subject = 'Prepare for your first day of onboarding.';
         reftsk.Priority = 'Normal';
         reftsk.Status = 'Not Started';
         reftsk.WhatId = jobApp.Id;
         reftsk.WhoId = jobApp.Primary_Contact__c;
         reftsk.OwnerId = jobApp.OwnerId;
         reftsk.ActivityDate = Date.today().addDays(15);

         tasks.add(reftsk);
         
          //Task to take some time to relax and recharge
          Task offtsk = new Task();
          offtsk.Subject = 'Take some time to relax and recharge.';
          offtsk.Priority = 'Normal';
          offtsk.Status = 'Not Started';
          offtsk.WhatId = jobApp.Id;
          offtsk.WhoId = jobApp.Primary_Contact__c;
          offtsk.OwnerId = jobApp.OwnerId;
          offtsk.ActivityDate = Date.today().addDays(15);
 
          tasks.add(offtsk);

        

         return tasks;
    }
}