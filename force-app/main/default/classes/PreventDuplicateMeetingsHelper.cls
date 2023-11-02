public with sharing class PreventDuplicateMeetingsHelper {

    public static Set<DateTime> getEventIds(List<Event> events)
    {
        Set<DateTime> meetingDateTime = new Set<DateTime>();
            for (Event newEvent : events){

                meetingDateTime.add(newEvent.StartDateTime);
            }

            return meetingDateTime;
    }

    public static void checkDuplicateAndWeekends(List<Event> alreadyBooked, List<Event> newEvents)
    {
        for (Event newEvent : newEvents){
        if(newEvent.StartDateTime.format('EEEE') == 'Sunday' || newEvent.StartDateTime.format('EEEE') == 'Saturday')
        {
                newEvent.addError('Please choose a weekday. Weekends are unavailable.');
        }
        else if(!alreadyBooked.isEmpty()) { 
                newEvent.addError('Unavailable. Please choose a different time slot.');
        }
        
      }

    }
}


