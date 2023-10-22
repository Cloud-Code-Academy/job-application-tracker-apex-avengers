public with sharing class JoobleIntegration {

    @future(callout = true)
    public static void retrieveJobs() {
        String endpoint = 'https://jooble.org/api/e6844abd-f8f3-4df7-9f49-d7685208f3ed';

        // Set default search criteria
        String keywords = 'salesforce developer';
        String location = 'remote';

        // Make a callout to Jooble API
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');

        // Set query parameters
        Map<String, String> params = new Map<String, String>();
        params.put('keywords', keywords);
        params.put('location', location);

        String queryString = 'keywords=' + keywords + '&location=' + location;

        request.setEndpoint(endpoint + '?' + queryString);

        HttpResponse response = new Http().send(request);

        System.debug('Response Status Code: ' + response.getStatusCode());
        System.debug('Response Body: ' + response.getBody());

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

        System.debug('JSON Response: ' + jsonResponse);

        if (jsonResponse.containsKey('jobs')) {
            List<Object> jobs = (List<Object>) jsonResponse.get('jobs');
            for (Object job : jobs) {
                if (job instanceof Map<String, Object>) {
                    Map<String, Object> jobMap = (Map<String, Object>) job;
                    String jobTitle = (String) jobMap.get('title');
                    String company = (String) jobMap.get('company');

                    System.debug('Job Title: ' + jobTitle);
                    System.debug('Company: ' + company);

                    // Create a new Job Application record
                    Job_Applications__c jobApp = new Job_Applications__c();
                    jobApp.Position_Title__c = jobTitle;
                    jobApp.Company_Name__c = company;
                    jobApp.Status__c = 'Saved';

                    jobApplications.add(jobApp);
                }
            }
        }

        return jobApplications;
    }

    @future
    public static void cleanupStaleJobApplications() {
        // Calculate the date 30 days ago
        Date thirtyDaysAgo = System.today().addDays(-30);

        // Query the Job Apps
        List<Job_Applications__c> staleJobApplications = [SELECT Id FROM Job_Applications__c
                                                         WHERE Status__c NOT IN ('Closed', 'Accepted')
                                                         AND LastModifiedDate < :thirtyDaysAgo];

        System.debug('Stale Job Applications: ' + staleJobApplications);

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