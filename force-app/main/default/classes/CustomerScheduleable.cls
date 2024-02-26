global class CustomerScheduleable implements Schedulable{
    global void execute(SchedulableContext sc) {
        // Implement any logic to be scheduled
       
        // We now call the batch class to be scheduled
        BatchClassForCustomer b = new BatchClassForCustomer();
       
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b,100);
    }
   
}