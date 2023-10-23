trigger PreventDuplicateMeetingsTrigger on Event (before insert) {


    for (Event newEvent : trigger.new){
       String Id = newEvent.Id;
       String owner = newEvent.OwnerId;
       Datetime startDate = newEvent.StartDateTime;
       Datetime endDate = newEvent.EndDateTime;

        List<Event> events = [SELECT Id FROM Event WHERE EndDateTime > :startDate AND StartDateTime < :endDate AND OwnerId = :owner AND ID != :Id];
        if (!events.isEmpty()) { 
            newEvent.addError('Please choose a different time slot..');
        }
    }

}