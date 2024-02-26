global class EmailAlertScheduler implements Schedulable {

	  global void execute(SchedulableContext SC) {

	   EmailNotificationBatch batch=new EmailNotificationBatch();
           database.executebatch(batch);
	
	   }

	
}