trigger EmailReminderScheduledJobTrigger on Interview__c (after insert, after update) {

    // Schedule the reminder job for interviews created or updated
    EmailReminderScheduledJob.scheduleJob();
}