trigger PreventDuplicateMeetingsTrigger on Event (before insert) {

    if(Trigger.isBefore && Trigger.isInsert)
    {
        List<Event> newEvents = trigger.new;

        PreventDuplicateMeetings.checkforDuplicateMeetings(newEvents);

    }
   
   }