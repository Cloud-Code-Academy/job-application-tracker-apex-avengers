@isTest
private with sharing class PreventDuplicateMeetingsTriggerTest {
    
@isTest
     static void doubleBookingChecker()
    {

        Event event1 = new Event();
        event1.StartDateTime = System.now();
        event1.DurationInMinutes = 50;
        insert event1;


        Event duplicateEvent = new Event();
        duplicateEvent.StartDateTime = System.now();
        duplicateEvent.DurationInMinutes = 50;

        Test.startTest();
        try{
            insert duplicateEvent;
        }
        catch(DmlException de)
        {
            System.assert(de.getDmlMessage(0).contains('Unavailable. Please choose a different time slot.'));
        }

        Test.stopTest();
    }

    @isTest
    static void preventSundayBookingTest()
    {
        Event weekendMeeting = new Event();
        weekendMeeting.StartDateTime = DateTime.newInstanceGMT(2023, 10, 5, 0, 0, 0);
        weekendMeeting.DurationInMinutes = 60;

        Test.startTest();
        try{

            insert weekendMeeting;
        }
        catch(DmlException de)
        {
            System.assert(de.getDmlMessage(0).contains('Please choose a weekday. Weekends are unavailable.'));
        }
        Test.stopTest();
    }

    @isTest
    static void preventSaturdayBookingTest()
    {
        Event weekendMeeting = new Event();
        weekendMeeting.StartDateTime = DateTime.newInstanceGMT(2023, 10, 4, 0, 0, 0);
        weekendMeeting.DurationInMinutes = 60;

        Test.startTest();
        try{

            insert weekendMeeting;
        }
        catch(DmlException de)
        {
            System.assert(de.getDmlMessage(0).contains('Please choose a weekday. Weekends are unavailable.'));
        }
        Test.stopTest();
    }
}