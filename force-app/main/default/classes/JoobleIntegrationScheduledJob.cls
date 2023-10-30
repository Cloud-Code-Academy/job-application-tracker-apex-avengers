public class JoobleIntegrationScheduledJob implements Schedulable {

    public void execute(SchedulableContext sc) {
        String keywords = 'Salesforce Developer';
        String location = 'Remote';
        JoobleIntegration.retrieveJobs(keywords, location);
    }

    public static void scheduleJob() {
        String CRON_EXP = '0 0 13 ? * *';
        JoobleIntegrationScheduledJob job = new JoobleIntegrationScheduledJob();
        String scheduledJobId = System.schedule('JoobleIntegrationJob', CRON_EXP, job);
    }
}