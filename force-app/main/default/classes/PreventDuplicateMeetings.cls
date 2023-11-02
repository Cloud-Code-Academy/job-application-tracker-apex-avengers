public class PreventDuplicateMeetings {

    public static void checkforDuplicateMeetings(List<Event> newEvents) {

        Set<DateTime> meetingDateTime = new Set<DateTime>();

        for (Event newEvent : newEvents) {
            meetingDateTime.add(newEvent.StartDateTime);
        }

        List<Event> events = [SELECT Id FROM Event WHERE StartDateTime IN :meetingDateTime];

        for (Event newEvent : newEvents) {
            if (newEvent.StartDateTime.format('EEEE') == 'Sunday' || newEvent.StartDateTime.format('EEEE') == 'Saturday') {

                newEvent.addError('Please choose a weekday. Weekends are unavailable.');

            } else if (!events.isEmpty()) {

                newEvent.addError('Unavailable. Please choose a different time slot.');
            }
        }
    }
}