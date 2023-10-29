trigger InterviewToEventTrigger on Interview__c (before insert) {

    // Check if the trigger is executing before insert operations on Interview
    if (Trigger.isBefore && Trigger.isInsert) {
    try {

        // Create a list of events based on the interview records being inserted
        List<Event> events = InterviewToEventHelper.createEventsFromInterviews(Trigger.new);

        // Check if there are events to insert
        if (!events.isEmpty()) {
            insert events;
        }
    } catch (Exception e) {
        
        // Handle and log any exceptions that occur during event creation
        System.debug('Error Message: ' + e.getMessage());
    }
    
    }
}