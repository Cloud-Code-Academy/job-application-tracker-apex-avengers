trigger InterviewToEventTrigger on Interview__c (after insert) {
    List<Event> events = InterviewToEventHelper.createEventsFromInterviews(Trigger.new);
    
    if (!events.isEmpty()) {
        insert events;
    }
}