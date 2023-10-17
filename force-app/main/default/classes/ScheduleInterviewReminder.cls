public class ScheduleInterviewReminder {
    @future(callout=true)

    public static void scheduleJob() {
        String jobName = 'InterviewReminderJob';
        String jobClass = 'EmailReminder';
        String cronExpression = '0 0 8 * * ?';

        // Check if the job with the same name already exists and unschedule it
        System.abortJob(jobName);

        // Schedule the job
        System.schedule(jobName, cronExpression, new EmailReminder());
    }
}