public class InterviewToEventHelper {

    // Method to create events from interview records
    public static List<Event> createEventsFromInterviews(List<Interview__c> interviews) {
        List<Event> eventList = new List<Event>();
        
        for (Interview__c interview : interviews) {
            Event newEvent = new Event();
            
            // Set the event subject based on the interview name
            newEvent.Subject = 'Interview for ' + interview.Name;

            if (interview.Interview_Date_Time__c != null) {
                newEvent.StartDateTime = interview.Interview_Date_Time__c;
                newEvent.EndDateTime = interview.Interview_Date_Time__c.addHours(1);
                newEvent.DurationInMinutes = 60;
                newEvent.ActivityDateTime = interview.Interview_Date_Time__c;
            }
            
            // Fill out the event description with details from the interview
            newEvent.Description = 'Interview Type: ' + 
                                  (interview.Interview_Type__c != null ? interview.Interview_Type__c : 'N/A') +
                                  '\nInterviewer: ' + 
                                  (interview.Interviewer__c != null ? interview.Interviewer__c : 'N/A') +
                                  '\nInterview Format: ' + 
                                  (interview.Interview_Format__c != null ? interview.Interview_Format__c : 'N/A') +
                                  '\nNotes: ' + 
                                  (interview.Notes__c != null ? interview.Notes__c : 'N/A');

            // Add the new event to the list
            eventList.add(newEvent);
        }
        
        // Return the list of events
        return eventList;
    }

}