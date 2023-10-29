public with sharing class JoobleIntegration {

    @future(callout=true) 
    public static void retrieveJobs(String keywords, String location) {
        String endpoint = 'callout:JoobleJobAPI'; //named credentials added.
        //'https://jooble.org/api/e6844abd-f8f3-4df7-9f49-d7685208f3ed';

        // Set default search criteria
        Map<String, String> params = new Map<String, String>();
        params.put('keywords', 'salesforce developer');
        params.put('location', 'remote');
       

        // Make a callout to Jooble API
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(params));

        HttpResponse response = new Http().send(request);

        System.debug('Response Status Code: ' + response.getStatusCode());
        System.debug('Response Body: ' + response.getBody());

        if (response.getStatusCode() == 200) {
            // Process the API response and create Job Applications
            List<Job_Applications__c> jobApplications = processApiResponse(response.getBody());

            // Upsert Job Applications based on External ID
            if (!jobApplications.isEmpty()) {
                upsert jobApplications Job_Applications__c.Fields.External_ID__c;
            }
        }
    }

    private static Decimal extractSalary(String salaryString) {
        // Remove non-numeric characters and split the string
        salaryString = salaryString.replaceAll('[^0-9\\.]+', '');
        if (String.isBlank(salaryString)) {
            return null;
        }
        return Decimal.valueOf(salaryString);
    }

    private static String generateExternalID(String jobTitle, String company) {

        // Generate a unique ID
        String uniqueID = jobTitle + '-' + company + '-' + Datetime.now().getTime();
        return uniqueID;
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
                    String jobName = (String) jobmap.get('title');
                    String jobTitle = (String) jobMap.get('title');
                    String company = (String) jobMap.get('company');
                    String jobUrl = ((String) jobMap.get('link')).substring(0,18);
                    String jobLocation = (String) jobMap.get('location');
                    String salaryString = (String) jobMap.get('salary');
                    String description = (String) jobMap.get('snippet');
                    String lastUpdatedString = (String) jobMap.get('updated');
    
                    // Convert salary to Decimal
                    Decimal jobSalary = extractSalary(salaryString);

                    // Convert lastUpdatedString to Datetime
                    Datetime lastUpdated;

                    if (lastUpdatedString != null) {
                    // Remove fractional seconds and timezone information
                    lastUpdatedString = lastUpdatedString.substringBefore('.');
                    lastUpdatedString = lastUpdatedString.substringBefore('+');
    
                    // Replace 'T' with space
                    lastUpdatedString = lastUpdatedString.replace('T', ' ');
    
                    lastUpdated = Datetime.valueOfGmt(lastUpdatedString);
            }                                    
                    // Generate a unique External ID
                    String externalID = generateExternalID(jobTitle, company);
    
                    // Create a new Job Application record
                    Job_Applications__c jobApp = new Job_Applications__c();
                    jobApp.External_ID__c = externalID;
                    jobApp.Name = jobTitle;
                    jobApp.Position_Title__c = jobTitle;
                    jobApp.Company_Name__c = company;
                    jobApp.Status__c = 'Saved';
                    jobApp.URL__c = jobUrl;
                    jobApp.Location__c = jobLocation;
                    jobApp.Salary__c = jobSalary;
                    jobApp.Description__c = description;
                    jobApp.Job_Last_Updated__c = lastUpdated;
    
                    jobApplications.add(jobApp);
                }
            }
        }
    
        // Upsert the Job Applications based on the External_ID__c field
        if (!jobApplications.isEmpty()) {
            try {
                upsert jobApplications Job_Applications__c.Fields.External_ID__c;
            } catch (DmlException e) {
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    System.debug('Error for record ' + e.getDmlId(i) + ': ' + e.getDmlMessage(i));
                }
            }
        }
    
        return jobApplications;
    }    
}