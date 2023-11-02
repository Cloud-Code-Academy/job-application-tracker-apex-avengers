public class ContactAssociationHandler {

    // Associate contacts with job applications after Contact records are updated
    public static void handleContactsAfterUpdate(Map<Id, Contact> newContacts, Map<Id, Contact> oldContacts) {

        // Create a set to store the IDs of related Job Applications that need to be updated
        Set<Id> jobApplicationIds = new Set<Id>();

        // Loop through the updated Contact records and check for changes in the Job Application lookup field
        for (Id contactId : newContacts.keySet()) {
            Contact newContact = newContacts.get(contactId);
            Contact oldContact = oldContacts.get(contactId);

            // Compare the Job_Application_Contacts__c field in the new and old Contact records
            if (newContact.Job_Application_Contacts__c != oldContact.Job_Application_Contacts__c) {
                // Add the Job Application's ID to the set for further processing
                jobApplicationIds.add(newContact.Job_Application_Contacts__c);
            }
        }

        // Check if there are Job Applications that need to be updated
        if (!jobApplicationIds.isEmpty()) {
            // Call the helper method in the ContactAssociationHandler class to perform the association
            associateContactsWithJobApplications(jobApplicationIds, newContacts);
        }
    }

    public static void associateContactsWithJobApplications(Set<Id> jobApplicationIds, Map<Id, Contact> newContacts) {
        List<Job_Applications__c> jobApplicationsToUpdate = new List<Job_Applications__c>();

        // Retrieve the Job Application record
        Job_Applications__c jobApplication = [SELECT Id, Associated_Contacts__c FROM Job_Applications__c WHERE Id = :jobApplicationIds];

        for (Id jobApplicationId : jobApplicationIds) {

            // Verify the record was found
            if (jobApplication != null) {
                // Add the new Contact IDs to the set of associated contacts
                jobApplication.Associated_Contacts__c = '';

                for (Id contactId : newContacts.keySet()) {
                    if (newContacts.get(contactId).Job_Application_Contacts__c == jobApplicationId) {
                        if (String.isNotBlank(jobApplication.Associated_Contacts__c)) {
                            jobApplication.Associated_Contacts__c += ';';
                        }
                        jobApplication.Associated_Contacts__c += contactId;
                    }
                }

                jobApplicationsToUpdate.add(jobApplication);
            }
        }

        // Update the Job Application records
        if (!jobApplicationsToUpdate.isEmpty()) {
            update jobApplicationsToUpdate;
        }
    }
}
