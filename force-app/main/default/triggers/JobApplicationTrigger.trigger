trigger JobApplicationTrigger on Job_Applications__c (before update, after update, after insert, before insert, after delete, before delete, after undelete) {

    new JobApplicationTriggerHandler().run();
}