trigger ServiceOrderTrigger on CHANNEL_ORDERS__Service_Order__c (after insert, after update) {
    if(Trigger.isAfter){
        
        // Checking for the request type
        if(Trigger.isInsert ){
           ServiceOrderTriggerHelper.calculateLicenseCustomer(Trigger.new);
          
        }
       if(Trigger.isUpdate){
           ServiceOrderTriggerHelper.calculateLicenseCustomer(Trigger.new);
            
        }
    }
}