trigger PreventDuplicateMeetingsTrigger on Event (before insert) {
    List<Event> newEvents = trigger.new;

    PreventDuplicateMeetings.checkforDuplicateMeetings(newEvents);
}