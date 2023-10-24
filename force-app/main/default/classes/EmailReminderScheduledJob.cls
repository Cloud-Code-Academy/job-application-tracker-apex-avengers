public class EmailReminderScheduledJob implements Schedulable {

    public void execute(SchedulableContext context) {

        // Calculate the date for one day before the scheduled interviews
        Date reminderDate = Date.today().addDays(1);

        // Query interviews scheduled for the reminder date
        List<Interview__c> interviews = [SELECT Id, User_Email__c, Name, InterviewDate__c
                                         FROM Interview__c
                                         WHERE InterviewDate__c = :reminderDate];

        // Compose and send email reminders
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();

        for (Interview__c interview : interviews) {
            String candidateEmail = interview.User_Email__c;
            String subject = 'Interview Reminder for ' + interview.Name;
            String body = 'Dear Candidate,\n\n'
                + 'This is a reminder for your scheduled interview tomorrow.\n'
                + 'Interview Date: ' + interview.Interview_Date_Time__c.format() + '\n'
                + 'Please be prepared and good luck!';

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{interview.User_Email__c});
            email.setSubject(subject);
            email.setPlainTextBody(body);

            emailMessages.add(email);
        }

        // Send email reminders
        if (!emailMessages.isEmpty()) {
            Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(emailMessages);
            for (Messaging.SendEmailResult result : sendResults) {
                if (result.isSuccess()) {
                    System.debug('Email reminder sent successfully.');
                } else {
                    System.debug('Failed to send the email reminder: ' + result.getErrors()[0].getMessage());
                }
            }
        }
    }

    @future(callout=true)
    public static void scheduleJob() {
        String jobName = 'InterviewReminderJob';
        String cronExpression = '0 0 8 * * ?';

        // Schedule the job
        System.schedule(jobName, cronExpression, new EmailReminderScheduledJob());
    }
}
