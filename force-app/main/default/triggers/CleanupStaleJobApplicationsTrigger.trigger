trigger CleanupStaleJobApplicationsTrigger on Job_Applications__c (after insert, after update) {
    if (Trigger.isAfter) {
        if ((Trigger.isInsert || Trigger.isUpdate)) {
            CleanupStaleJobApplications.cleanupStaleJobApps();
        }
    }
}