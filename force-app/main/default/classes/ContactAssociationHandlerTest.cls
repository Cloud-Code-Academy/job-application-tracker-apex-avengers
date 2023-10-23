@isTest
public class ContactAssociationHandlerTest {
    @isTest
    static void testHandleContactsAfterUpdate() {

        // Create test data
        Job_Applications__c jobApp = new Job_Applications__c();
        jobApp.Name = 'Test Job Application';
        insert jobApp;

        Contact contact = new Contact();
        contact.LastName = 'Test Contact';
        insert contact;

        // Set up the expected Contact record
        Contact expectedContact = new Contact();
        expectedContact.Id = contact.Id;
        expectedContact.FirstName = 'Test';
        expectedContact.LastName = 'Contact';

        // Update the Contact's Job_Application_Contacts__c field
        contact.Job_Application_Contacts__c = jobApp.Id;
        update contact;

        // Retrieve the updated Contact record
        Contact updatedContact = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :contact.Id];

        // Assert that the updated Contact record matches the expected record
        System.assertEquals(expectedContact, updatedContact);
    }
}