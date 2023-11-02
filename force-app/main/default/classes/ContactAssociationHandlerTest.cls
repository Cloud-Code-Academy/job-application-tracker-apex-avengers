@isTest
public class ContactAssociationHandlerTest {
    @isTest
    static void testHandleContactsAfterUpdate() {
        
        // Create test data
        Contact contact = new Contact();
        contact.LastName = 'TestLastName';
        insert contact;
        
        Job_Applications__c jobApplication = new Job_Applications__c();
        insert jobApplication;
        
        // Associate the contact with the job application
        contact.Job_Application_Contacts__c = jobApplication.Id;
        update contact;
        
        // Perform the assertion
        Contact updatedContact = [SELECT Id, Job_Application_Contacts__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(jobApplication.Id, updatedContact.Job_Application_Contacts__c);
    }
}