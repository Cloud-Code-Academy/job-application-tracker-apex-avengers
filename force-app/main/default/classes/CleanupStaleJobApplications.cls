public with sharing class CleanupStaleJobApplications {

    public static void cleanupStaleJobApps(){
    // Calculate the date 30 days ago
    Date thirtyDaysAgo = System.today().addDays(-30);

    // Query the Job Apps
    List<Job_Applications__c> staleJobApplications = [SELECT Id FROM Job_Applications__c
                                                     WHERE Status__c NOT IN ('Closed', 'Accepted')
                                                     AND LastModifiedDate > :thirtyDaysAgo];

    System.debug('Stale Job Applications: ' + staleJobApplications);

    if (!staleJobApplications.isEmpty()) {
        List<Job_Applications__c> applicationsToUpdate = new List<Job_Applications__c>();

        for (Job_Applications__c jobApp : staleJobApplications) {
            // Update status to Closed and add a note
            jobApp.Status__c = 'Closed';
            jobApp.Notes__c = 'Closed by automated process.';
            applicationsToUpdate.add(jobApp);
        }

        try{
            if (!applicationsToUpdate.isEmpty()) {
                update applicationsToUpdate;
            }
        }
       catch(DmlException de){
            System.debug(de.getMessage());
       }
     }
    }
}