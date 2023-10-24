@isTest
public class InterviewToEventHelperTest {

    @isTest
    public static void testCreateEventsFromInterviews() {

        // Create test Interview record
        Interview__c interviewTest = new Interview__c(
        Name = 'Test Interview',
        Interview_Date_Time__c = DateTime.now(),
        Interview_Type__c = 'Technical',
        Interviewer__c = 'Warren Walters',
        Interview_Format__c = 'In-Person',
        Notes__c = 'Test Notes'
        );

        insert interviewTest;

        List<Interview__c> interviews = [SELECT Id, Name, Interview_Date_Time__c, Interview_Type__c, Interviewer__c, Interview_Format__c, Notes__c FROM Interview__c];
        List<Event> events = InterviewToEventHelper.createEventsFromInterviews(interviews);

        // Verify the method returned the expected number of events
        System.assertEquals(1, events.size());

        // Verify event details for the interview
        Event eventTest = events[0];
        System.assertEquals('Interview for ' + interviewTest.Name, eventTest.Subject);
        System.assertEquals(interviewTest.Interview_Date_Time__c, eventTest.StartDateTime);
        System.assertEquals(interviewTest.Interview_Date_Time__c.addHours(1), eventTest.EndDateTime);
        System.assertEquals(60, eventTest.DurationInMinutes);
        System.assertEquals(interviewTest.Interview_Date_Time__c, eventTest.ActivityDateTime);
        System.assertEquals(
            'Interview Type: ' + interviewTest.Interview_Type__c + 
            '\nInterviewer: ' + interviewTest.Interviewer__c + 
            '\nInterview Format: ' + interviewTest.Interview_Format__c + 
            '\nNotes: ' + interviewTest.Notes__c,
            eventTest.Description
        );
    }
}