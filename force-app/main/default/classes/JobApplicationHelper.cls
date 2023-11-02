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

         // Task to Find and research someone
         Task tsk2 = new Task();
         tsk2.Subject = 'Find and research someone who works at the company and add them as a contact.';
         tsk2.Priority = 'Normal';
         tsk2.Status = 'Not Started';
         tsk2.WhatId = jobApp.Id;
         tsk2.WhoId = jobApp.Primary_Contact__c;
         tsk2.OwnerId = jobApp.OwnerId;
         tsk2.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk2);

         // Task to Customize your work achievements using the job description keywords
         Task tsk3 = new Task();
         tsk3.Subject = 'Customize your work achievements using the job description keywords.';
         tsk3.Priority = 'Normal';
         tsk3.Status = 'Not Started';
         tsk3.WhatId = jobApp.Id;
         tsk3.WhoId = jobApp.Primary_Contact__c;
         tsk3.OwnerId = jobApp.OwnerId;
         tsk3.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk3);

     //Task to Submit your application on the company website if possible
         Task tsk4 = new Task();
         tsk4.Subject = 'Submit your application on the company website if possible.';
         tsk4.Priority = 'Normal';
         tsk4.Status = 'Not Started';
         tsk4.WhatId = jobApp.Id;
         tsk4.WhoId = jobApp.Primary_Contact__c;
         tsk4.OwnerId = jobApp.OwnerId;
         tsk4.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk4);

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

          //Task for Reach out to the hiring manager or recruiter.
         Task tsk1 = new Task();
         tsk1.Subject = 'Reach out to the hiring manager or recruiter.';
         tsk1.Priority = 'Normal';
         tsk1.Status = 'Not Started';
         tsk1.WhatId = jobApp.Id;
         tsk1.WhoId = jobApp.Primary_Contact__c;
         tsk1.OwnerId = jobApp.OwnerId;
         tsk1.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk1);

   //Task for Continue identifying and saving similar job opportunities

         Task tsk2 = new Task();
         tsk2.Subject = 'Continue identifying and saving similar job opportunities.';
         tsk2.Priority = 'Normal';
         tsk2.Status = 'Not Started';
         tsk2.WhatId = jobApp.Id;
         tsk2.WhoId = jobApp.Primary_Contact__c;
         tsk2.OwnerId = jobApp.OwnerId;
         tsk2.ActivityDate = Date.today().addDays(15);
         tasks.add(tsk2);


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