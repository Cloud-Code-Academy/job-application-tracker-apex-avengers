public class InterviewToEventHelper {

    // Method to create Events from Interview records
    public static List<Event> createEventsFromInterviews(List<Interview__c> interviews) {
        List<Event> eventList = new List<Event>();
        
        // Loop through each Interview record
        for (Interview__c interview : interviews) {
            Event newEvent = new Event();
            // Set the Event subject followed by the Interview Name
            newEvent.Subject = 'Interview for ' + interview.Name;
            
            // If the Interview Date & Time is available, set the Start and End times
            if (interview.Interview_Date_Time__c != null) {
                newEvent.StartDateTime = interview.Interview_Date_Time__c;
                newEvent.EndDateTime = interview.Interview_Date_Time__c.addHours(1);
            }
            
            // Populate the Event Description with Interview details
            newEvent.Description = 'Interview Type: ' + interview.Interview_Type__c +
                                  '\nInterviewer: ' + interview.Interviewer__c +
                                  '\nInterview Format: ' + interview.Interview_Format__c +
                                  '\nNotes: ' + interview.Notes__c;
            
            // Add the newly created Event to the list
            eventList.add(newEvent);
        }
        // Return the list of created Events
        return eventList;
    }
}