public class InterviewToEventHelper {

    public static List<Event> createEventsFromInterviews(List<Interview__c> interviews) {
        List<Event> eventList = new List<Event>();
        
        for (Interview__c interview : interviews) {
            Event newEvent = new Event();
            
            newEvent.Subject = 'Interview for ' + interview.Name;

            if (interview.Interview_Date_Time__c != null) {
                newEvent.StartDateTime = interview.Interview_Date_Time__c;
                newEvent.EndDateTime = interview.Interview_Date_Time__c.addHours(1);
                newEvent.DurationInMinutes = 60;
                newEvent.ActivityDateTime = interview.Interview_Date_Time__c;
            }
            
            newEvent.Description = 'Interview Type: ' + interview.Interview_Type__c +
                                  '\nInterviewer: ' + interview.Interviewer__c +
                                  '\nInterview Format: ' + interview.Interview_Format__c +
                                  '\nNotes: ' + interview.Notes__c;
            
            eventList.add(newEvent);
        }
        
        return eventList;
    }
}

