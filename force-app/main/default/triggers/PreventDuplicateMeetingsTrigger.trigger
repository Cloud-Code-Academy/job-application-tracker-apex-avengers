trigger PreventDuplicateMeetingsTrigger on Event (before insert) {

    Set<DateTime> meetingDateTime = new Set<DateTime>();
    for (Event newEvent : trigger.new){

        meetingDateTime.add(newEvent.StartDateTime);
    }

    List<Event> events = [SELECT Id FROM Event WHERE StartDateTime IN :meetingDateTime];

    for (Event newEvent : trigger.new){
       if(newEvent.StartDateTime.format('EEEE') == 'Sunday' || newEvent.StartDateTime.format('EEEE') == 'Saturday')
       {
            newEvent.addError('Choose other than weekends to book the meeting.');
       }
       else if(!events.isEmpty()) { 
            newEvent.addError('Please choose a different time slot..');
        }
       
        
    }

}