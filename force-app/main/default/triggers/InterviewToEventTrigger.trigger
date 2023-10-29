trigger InterviewToEventTrigger on Interview__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
    try {
        List<Event> events = InterviewToEventHelper.createEventsFromInterviews(Trigger.new);

        if (!events.isEmpty()) {
            insert events;
        }
    } catch (Exception e) {
        System.debug('Error Message: ' + e.getMessage());
    }
    
    }
}