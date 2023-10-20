public class JoobleIntegrationScheduledJob implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        JoobleIntegration.retrieveJobs();
    }
}
