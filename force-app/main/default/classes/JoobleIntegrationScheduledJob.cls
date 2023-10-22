public class JoobleIntegrationScheduledJob implements Schedulable {

    public void execute(SchedulableContext sc) {
        JoobleIntegration.retrieveJobs();
    }

    public static void scheduleJob() {
        String CRON_EXP = '0 07 12 ? * *';
        JoobleIntegrationScheduledJob job = new JoobleIntegrationScheduledJob();
        String jobId = System.schedule('JoobleIntegrationJob', CRON_EXP, job);
    }
}