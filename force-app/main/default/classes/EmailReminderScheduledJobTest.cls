@isTest
public class EmailReminderScheduledJobTest {

    @isTest
    static void testEmailReminderScheduledJob() {

        // Create test data
        Date reminderDate = Date.today().addDays(1);
        Interview__c testInterview = new Interview__c(
            Name = 'Test Interview',
            InterviewDate__c = reminderDate,
            User_Email__c = 'test@test.com'
        );
        insert testInterview;

        // Schedule the job
        String cronExpression = '0 0 13 * * ?';
        String jobId = System.schedule('Email Reminder Scheduled Job', cronExpression, new EmailReminderScheduledJob());

        // Assert that the job has been scheduled as expected
        CronTrigger[] cronTriggers = [SELECT Id FROM CronTrigger where CronExpression = :cronExpression];
        System.assertEquals(1, cronTriggers.size(), 'Expected Email Reminder Scheduled Job to be scheduled');
    }
}