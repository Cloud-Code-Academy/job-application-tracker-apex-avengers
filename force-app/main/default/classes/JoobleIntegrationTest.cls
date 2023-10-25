@isTest
public with sharing class JoobleIntegrationTest {
    @isTest
    static void testRetrieveJobs() {

    Test.setMock(HttpCalloutMock.class, new JoobleIntegrationMock(200, 'OK', getMockResponse()));
 
        // Define the keywords and location
        String keywords = 'Salesforce Developer';
        String location = 'Remote';

        // Call the retrieveJobs method
        JoobleIntegration.retrieveJobs(keywords, location);

        List<Job_Applications__c> jobApps = [SELECT Status__c, Name, Company_Name__c, Description__c FROM Job_Applications__c];
        System.assertEquals(1, jobApps.size());
        Job_Applications__c jobApp = jobApps[0];
        System.assertEquals('Saved', jobApp.Status__c);
        System.assertEquals('Job Title', jobApp.Name);
        System.assertEquals('Company Name', jobApp.Company_Name__c);
        System.assertEquals('Description', jobApp.Description__c);
    }

    // Return the mock response as a JSON string
    static String getMockResponse() {
        return '{"jobs": ['
            + '{}'
            + ']}';
    }
}