public class JoobleIntegration {

    public static void retrieveJobs() {
        String apiKey = 'e6844abd-f8f3-4df7-9f49-d7685208f3ed';
        String endpoint = 'https://jooble.org/api';

        // Make a callout to Jooble API
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('X-Api-Key', apiKey);

        // Set query parameters
        String keywords = 'Salesforce Developer, Apex, Visualforce, Lightning';
        String location = 'Remote';

        request.setEndpoint(endpoint + '?keywords=' + keywords + '&location=' + location);

        HttpResponse response = new Http().send(request);

        if (response.getStatusCode() == 200) {
            // Process the API response and create Job Applications
            List<Job_Applications__c> jobApplications = processApiResponse(response.getBody());

            // Insert the Job Applications
            if (!jobApplications.isEmpty()) {
                insert jobApplications;
            }
        }
    }

    private static List<Job_Applications__c> processApiResponse(String responseBody) {
        List<Job_Applications__c> jobApplications = new List<Job_Applications__c>();

        // Parse the JSON response
        Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);

        if (jsonResponse.containsKey('title')) {
            // Get relevant information
            String jobTitle = (String)jsonResponse.get('title');
            String company = (String)jsonResponse.get('company');

            // Create a new Job Application record
            Job_Applications__c jobApp = new Job_Applications__c();
            jobApp.Position_Title__c = jobTitle;
            jobApp.Company_Name__c = company;

            jobApplications.add(jobApp);
        }

        return jobApplications;
    }

    @future
    public static void cleanupStaleJobApplications() {

        // Calculate the date 30 days ago
        Date thirtyDaysAgo = System.today().addDays(-30);

        // Query the Jop Apps
        List<Job_Applications__c> staleJobApplications = [SELECT Id FROM Job_Applications__c
                                                         WHERE Status__c NOT IN ('Closed', 'Accepted')
                                                         AND LastModifiedDate < :thirtyDaysAgo];
                                                
        if (!staleJobApplications.isEmpty()) {
            List<Job_Applications__c> applicationsToUpdate = new List<Job_Applications__c>();

            for (Job_Applications__c jobApp : staleJobApplications) {
                // Update status to Closed and add a note
                jobApp.Status__c = 'Closed';
                jobApp.Notes__c = 'Closed by automated process.';
                applicationsToUpdate.add(jobApp);
            }

            if (!applicationsToUpdate.isEmpty()) {
                update applicationsToUpdate;
            }
        }
    }
}