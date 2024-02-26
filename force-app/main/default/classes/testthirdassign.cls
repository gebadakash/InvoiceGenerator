public class testthirdassign {
    public static void testthirdassignMethod(){
        
        List<CHANNEL_ORDERS__Service_Order__c>PartialBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        List<CHANNEL_ORDERS__Service_Order__c>FullBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        
             List<CHANNEL_ORDERS__Customer__c> customerList=[Select Id,Name,BIlling_Frequency__c,Billing_Start_Date__c,Recent_Billing_Date__c,LastBillingDate__c,
                                                             (Select Id,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,Total_Licenses__c from CHANNEL_ORDERS__Service_Orders__r)
                                                        from CHANNEL_ORDERS__Customer__c 
                                                        where id='a098I00000197ILQAY' AND BIlling_Frequency__c='Monthly' AND LastBillingDate__c!=null AND Recent_Billing_Date__c!=null ];
        system.debug('customerList'+customerList);
        
        Map<Id,Decimal>serviceMap=new Map<Id,Decimal>();
         Decimal ServiceOrderPartialBillingCount = 0.0;
         Decimal ServiceOrderFullBillingCount = 0.0;
        for (CHANNEL_ORDERS__Customer__c customerServiceOrder:customerList){
            for(CHANNEL_ORDERS__Service_Order__c serviceOrder:customerServiceOrder.CHANNEL_ORDERS__Service_Orders__r){
            if(customerServiceOrder.Recent_Billing_Date__c>serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c && 
               customerServiceOrder.LastBillingDate__c<serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c){
                system.debug('serviceOrder'+serviceOrder);
                
            // Calculate the Number of Day between two dates
                Integer noOfDays = serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c.daysBetween(customerServiceOrder.Recent_Billing_Date__c);
                system.debug('noOfDays'+noOfDays);
                
          serviceMap.put(serviceOrder.Id,(serviceOrder.Releo_Total_Revenue__c*noOfDays/30));
                   
                for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                    system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderDetail.CHANNEL_ORDERS__Product_Name__r.name);
                    system.debug('RelecoPrice__c'+serviceOrderDetail.RelecoPrice__c);
                    system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderDetail.CHANNEL_ORDERS__Quantity__c);
                    
                }
                
                decimal ServiceLicence = serviceMap.get(serviceOrder.Id);
                system.debug('ServiceLicence='+ServiceLicence);
                   
                 ServiceOrderPartialBillingCount += serviceMap.get(serviceOrder.Id);
                 system.debug('ServiceOrderPartialBillingCount'+ServiceOrderPartialBillingCount);
              
                PartialBillingList.add(serviceOrder);
                system.debug('serviceMap'+serviceMap);
                
            }else{
                Map<Id,Decimal>serviceMap2=new Map<Id,Decimal>();
          
                    if(serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c<customerServiceOrder.LastBillingDate__c){
                        system.debug('serviceOrder='+serviceOrder);
                        
                        serviceMap2.put(serviceOrder.Id,(serviceOrder.Releo_Total_Revenue__c));
                        for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                            system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderDetail.CHANNEL_ORDERS__Product_Name__r.name);
                            system.debug('RelecoPrice__c'+serviceOrderDetail.RelecoPrice__c);
                            system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderDetail.CHANNEL_ORDERS__Quantity__c);
                            
                        }
                        
                     ServiceOrderFullBillingCount += serviceMap2.get(serviceOrder.Id);
                     system.debug('ServiceOrderFullBillingCount='+ServiceOrderFullBillingCount);
                        
                         FullBillingList.add(serviceOrder);
                        system.debug('serviceMap2'+serviceOrder);
                    } 
                }
               
            }
           Decimal TotalBilling=0.0;
             
            TotalBilling=ServiceOrderPartialBillingCount+ServiceOrderFullBillingCount;
            system.debug('TotalBilling='+TotalBilling);
            
            system.debug('ServiceOrderPartialBillingCount='+ServiceOrderPartialBillingCount);
           
            system.debug('ServiceOrderFullBillingCount='+ServiceOrderFullBillingCount);  
        }
    
    }
}