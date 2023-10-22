trigger InterviewToEventTrigger on Interview__c (after insert, before insert, before update) {
    List<Event> events = InterviewToEventHelper.createEventsFromInterviews(Trigger.new);
    
    if(Trigger.isAfter && Trigger.isInsert)
    {
        if (!events.isEmpty()) {
            insert events;
        }
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