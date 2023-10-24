@isTest
public class EmailReminderScheduledJobTest {

    @isTest
    public static void testEmailReminderScheduledJob() {
        // Create a test user and an interview record
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testemail@test123456.com',
            Username = 'testemail@test123456.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LanguageLocaleKey = 'en_US'

        );
        insert testUser;

        Date today = Date.today();
        Datetime interviewDateTime = Datetime.newInstance(today, Time.newInstance(9, 0, 0, 0));
        Interview__c testInterview = new Interview__c(
            Name = 'Test Interview',
            User_Email__c = testUser.Email,
            Interview_Date_Time__c = interviewDateTime
        );        
        insert testInterview;

        // Schedule the job
        EmailReminderScheduledJob.scheduleJob();
      
        // Query CronTrigger records to check if the job is scheduled
        Integer countCronTriggers = [SELECT COUNT() FROM CronTrigger WHERE CronJobDetail.Name = 'InterviewReminderJob' AND State = 'WAITING' LIMIT 1];
        System.assertEquals(1, countCronTriggers, 'Scheduled job not found in CronTrigger');

    }
}