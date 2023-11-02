trigger PreventDuplicateMeetingsTrigger on Event (before insert) {

    if(Trigger.isBefore && Trigger.isInsert)
    {
         Set<DateTime> meetingDateTime = PreventDuplicateMeetingsHelper.getEventIds(Trigger.new);
       
        List<Event> alreadyBooked = [SELECT Id FROM Event WHERE StartDateTime IN :meetingDateTime];
    
        PreventDuplicateMeetingsHelper.checkDuplicateAndWeekends(alreadyBooked, Trigger.new);
    }
   
   }