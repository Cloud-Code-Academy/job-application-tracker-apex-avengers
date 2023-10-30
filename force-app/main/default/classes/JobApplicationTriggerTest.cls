@isTest
public class JobApplicationTriggerTest {
    @isTest
    static void testJobAppTrigger() {

        // Test data
        Job_Applications__c jobApp = new Job_Applications__c();
        jobApp.Name = 'Test Application';
        insert jobApp;

        System.assertEquals('Test Application', jobApp.Name);
    }
}