public class wrapperClass {
       
    List<CHANNEL_ORDERS__Customer__c> customerList=[Select Id,Name,BIlling_Frequency__c,Active__c,Billing_Start_Date__c,Recent_Billing_Date__c,LastBillingDate__c,
                                                        (Select Id,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,Total_Licenses__c from CHANNEL_ORDERS__Service_Orders__r)
                                                        from CHANNEL_ORDERS__Customer__c 
                                                        where BIlling_Frequency__c='Monthly' AND Active__c=True AND LastBillingDate__c!=null AND Recent_Billing_Date__c!=null And BIlling_Frequency__c!=null];
        
        Set<Id>customerIdSet=new Set<Id>();
        /*for (CHANNEL_ORDERS__Customer__c customerServiceOrder:customerList){
             customerIdSet.add(customerServiceOrder.id);
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderList=[Select Id,CHANNEL_ORDERS__Customer__r.Id,CHANNEL_ORDERS__Customer__r.BIlling_Frequency__c,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,
                                                                        (Select Id,Name,CHANNEL_ORDERS__Product_Name__r.name,RelecoPrice__c,CHANNEL_ORDERS__Quantity__c from CHANNEL_ORDERS__Partner_Order_Detail__r)
                                                                       from CHANNEL_ORDERS__Service_Order__c where CHANNEL_ORDERS__Customer__c IN:customerIdSet AND CHANNEL_ORDERS__Customer__r.Active__c=True];
        
             system.debug('serviceOrderList'+serviceOrderList);
            
          Decimal Total_Admin_License__c=0.0;
          //  Decimal Total_Manager_License__c=0.0;
           // Decimal Total_Manager_License__c0.0;
            
            Map<Id,CHANNEL_ORDERS__Service_Order_Detail__c>SODMap=new Map<Id,CHANNEL_ORDERS__Service_Order_Detail__c>();
        
        //logic to calculate licence count and updating customer records
        for(CHANNEL_ORDERS__Service_Order__c serviceOrder:serviceOrderList){
            system.debug('serviceOrder='+serviceOrder);
        for(CHANNEL_ORDERS__Service_Order_Detail__c soDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
           system.debug('soDetail='+soDetail);
        if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.RelecoHR One Force.com Embedded Admin User Subscription){
         if(customerServiceOrder.Recent_Billing_Date__c>serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c && 
            customerServiceOrder.LastBillingDate__c<serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c){
            soDetail.Total_Admin_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+soDetail.Total_Admin_License__c;
                            System.debug('soDetail='+soDetail);
            }
         }
        }*/
        }