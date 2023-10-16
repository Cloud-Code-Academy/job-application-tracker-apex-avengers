trigger ContactAssociationTrigger on Contact (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        ContactAssociationHandler.handleContactsAfterUpdate(Trigger.newMap, Trigger.oldMap);
    }
}