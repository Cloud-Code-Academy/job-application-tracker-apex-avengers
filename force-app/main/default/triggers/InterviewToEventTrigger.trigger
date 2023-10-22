trigger InterviewToEventTrigger on Interview__c (before insert) {
    try {
        List<Event> events = InterviewToEventHelper.createEventsFromInterviews(Trigger.new);

        if (!events.isEmpty()) {
            insert events;
        }
    } catch (Exception e) {
        System.debug('Error Message: ' + e.getMessage());
    }

    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
    {
        List<Event> bookedEvents = InterviewToEventHelper.getAllBookedSlots(Trigger.new);

        for(Interview__c interview : Trigger.new)
        {
            if(bookedEvents.size()>0)
            {
                interview.addError('Time slot is already booked');
            }
        }
        
    }
}