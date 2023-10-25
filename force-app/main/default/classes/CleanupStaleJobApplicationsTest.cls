@isTest
public class CleanupStaleJobApplicationsTest {

    @isTest
    static void testCleanupStaleJobApps() {

        // Create test data for stale job applications
        List<Job_Applications__c> jobApps = new List<Job_Applications__c>();
        Date thirtyDaysAgo = System.today().addDays(-30);
        
        for (Integer i = 0; i < 5; i++) {
            Job_Applications__c jobApp = new Job_Applications__c(
                Status__c = 'Open',
                Custom_LastModifiedDate__c = thirtyDaysAgo
            );
            jobApps.add(jobApp);
        }
        insert jobApps;

        // Create test data for non-stale job applications
        List<Job_Applications__c> nonStaleJobApps = new List<Job_Applications__c>();
        for (Integer i = 0; i < 5; i++) {
            Job_Applications__c jobApp = new Job_Applications__c(
                Status__c = 'Open',
                Custom_LastModifiedDate__c = System.today().addDays(-15)
            );
            nonStaleJobApps.add(jobApp);
        }
        insert nonStaleJobApps;

        // Call the cleanupStaleJobApps method
        CleanupStaleJobApplications.cleanupStaleJobApps();

        // Verify that stale job applications have been updated
        List<Job_Applications__c> updatedStaleJobApps = [SELECT Id, Status__c, Notes__c FROM Job_Applications__c WHERE Id IN :jobApps];
        for (Job_Applications__c jobApp : updatedStaleJobApps) {
            System.assertEquals('Closed', jobApp.Status__c);
            System.assertEquals('Closed by automated process.', jobApp.Notes__c);
        }

        // Verify that non-stale job applications are unchanged
        List<Job_Applications__c> unchangedJobApps = [SELECT Id, Status__c, Notes__c FROM Job_Applications__c WHERE Id IN :nonStaleJobApps];
        for (Job_Applications__c jobApp : unchangedJobApps) {
            System.assertNotEquals('Closed', jobApp.Status__c);
            System.assertNotEquals('Closed by automated process.', jobApp.Notes__c);
        }
    }
}
