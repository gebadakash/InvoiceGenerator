public class serviceOrderThirdAssign {
    public static void calculateMonthlyLicenseCustomer(){
         
        List<CHANNEL_ORDERS__Service_Order__c>PartialBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        List<CHANNEL_ORDERS__Service_Order__c>FullBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
       
        List<CHANNEL_ORDERS__Customer__c> customerList=[Select Id,Name,BIlling_Frequency__c,Active__c,Billing_Start_Date__c,Recent_Billing_Date__c,LastBillingDate__c,
                                                        (Select Id,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,Total_Licenses__c from CHANNEL_ORDERS__Service_Orders__r)
                                                        from CHANNEL_ORDERS__Customer__c 
                                                        where BIlling_Frequency__c='Monthly' AND Active__c=True AND LastBillingDate__c!=null AND Recent_Billing_Date__c!=null And BIlling_Frequency__c!=null];
        system.debug('customerList'+customerList);
        
        Set<Id>customerIdSet=new Set<Id>();
        for (CHANNEL_ORDERS__Customer__c customerServiceOrder:customerList){
             customerIdSet.add(customerServiceOrder.id);
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderList=[Select Id,CHANNEL_ORDERS__Customer__r.Id,CHANNEL_ORDERS__Customer__r.BIlling_Frequency__c,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,
                                                                        (Select Id,Name,CHANNEL_ORDERS__Product_Name__r.name,RelecoPrice__c,CHANNEL_ORDERS__Quantity__c from CHANNEL_ORDERS__Partner_Order_Detail__r)
                                                                       from CHANNEL_ORDERS__Service_Order__c where CHANNEL_ORDERS__Customer__c IN:customerIdSet AND CHANNEL_ORDERS__Customer__r.Active__c=True];
        
             system.debug('serviceOrderList'+serviceOrderList);
        
         Map<Id,Decimal>PartialBillingMap=new Map<Id,Decimal>();
         Decimal MonthlyPartialBillingCount = 0.0;
         Decimal MonthlyFullBillingCount = 0.0;        
         
         for(CHANNEL_ORDERS__Service_Order__c serviceOrder:serviceOrderList){
           //Monthly Billing     
                
            if(customerServiceOrder.Recent_Billing_Date__c>serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c && 
               customerServiceOrder.LastBillingDate__c<serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c ){
                  
                system.debug('serviceOrder'+serviceOrder);
                   
            // Calculate the Number of Day between two dates
                Integer noOfDays = serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c.daysBetween(customerServiceOrder.Recent_Billing_Date__c);
                system.debug('noOfDays'+noOfDays);
             
           PartialBillingMap.put(serviceOrder.Id,(serviceOrder.Releo_Total_Revenue__c*noOfDays/30));
               for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                  
                   
                   system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderDetail.CHANNEL_ORDERS__Product_Name__r.name);
                    system.debug('RelecoPrice__c'+serviceOrderDetail.RelecoPrice__c);
                    system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderDetail.CHANNEL_ORDERS__Quantity__c);
                 }
                decimal ServiceLicence = PartialBillingMap.get(serviceOrder.Id);
                system.debug('ServiceLicence='+ServiceLicence);
                   
                MonthlyPartialBillingCount += PartialBillingMap.get(serviceOrder.Id);
                 system.debug('MonthlyPartialBillingCount'+MonthlyPartialBillingCount);
              
                PartialBillingList.add(serviceOrder);
               system.debug('PartialBillingList'+PartialBillingList);
                        
            }else{
                Map<Id,Decimal>FullBillingMap=new Map<Id,Decimal>();
          
                    if(serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c<customerServiceOrder.LastBillingDate__c){
                       system.debug('serviceOrder='+serviceOrder);
                       FullBillingMap.put(serviceOrder.Id,(serviceOrder.Releo_Total_Revenue__c));
                        
                 for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                     
                            system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderDetail.CHANNEL_ORDERS__Product_Name__r.name);
                            system.debug('RelecoPrice__c'+serviceOrderDetail.RelecoPrice__c);
                            system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderDetail.CHANNEL_ORDERS__Quantity__c);
                             }
                         decimal ServiceLicence = PartialBillingMap.get(serviceOrder.Id);
                          system.debug('ServiceLicence='+ServiceLicence);
                        
                     MonthlyFullBillingCount += FullBillingMap.get(serviceOrder.Id);
                     system.debug('MonthlyFullBillingCount='+MonthlyFullBillingCount);
                        
                        
                          }
                 FullBillingList.add(serviceOrder);
                        system.debug('FullBillingList'+FullBillingList);
               }
                }
             
           Decimal TotalBilling=0.0;
             
            TotalBilling=MonthlyPartialBillingCount+MonthlyFullBillingCount;
            system.debug('TotalBilling='+TotalBilling);
            system.debug('MonthlyPartialBillingCount='+MonthlyPartialBillingCount);
            system.debug('MonthlyFullBillingCount='+MonthlyFullBillingCount);      
        }    
    }
} 
    
        //Quarterly Billing
    
        /* public static void calculateLicenseCustomerForQuarterly(){
                
        List<CHANNEL_ORDERS__Service_Order__c>PartialBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        List<CHANNEL_ORDERS__Service_Order__c>FullBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        
        List<CHANNEL_ORDERS__Customer__c> customerList=[Select Id,Name,BIlling_Frequency__c,Active__c,Billing_Start_Date__c,Recent_Billing_Date__c,LastBillingDate__c,
                                                        (Select Id,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,Total_Licenses__c from CHANNEL_ORDERS__Service_Orders__r)
                                                        from CHANNEL_ORDERS__Customer__c 
                                                        where BIlling_Frequency__c='Quarterly' AND  Active__c=True AND LastBillingDate__c!=null AND Recent_Billing_Date__c!=null And BIlling_Frequency__c!=null];
        system.debug('customerList'+customerList);

         Set<Id>customerIdSet=new Set<Id>();
        for (CHANNEL_ORDERS__Customer__c customerServiceOrder:customerList){
             customerIdSet.add(customerServiceOrder.id);
        
      List<CHANNEL_ORDERS__Service_Order__c> serviceOrderList=[Select Id,CHANNEL_ORDERS__Customer__r.Id,CHANNEL_ORDERS__Customer__r.BIlling_Frequency__c,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,
                                                                        (Select Id,Name,CHANNEL_ORDERS__Product_Name__r.name,RelecoPrice__c,CHANNEL_ORDERS__Quantity__c from CHANNEL_ORDERS__Partner_Order_Detail__r)
                                                                       from CHANNEL_ORDERS__Service_Order__c where CHANNEL_ORDERS__Customer__c IN:customerIdSet AND CHANNEL_ORDERS__Customer__r.Active__c=True];
        
             system.debug('serviceOrderList'+serviceOrderList);
        
         
            
            
            Map<Id,Decimal>PartialBillingMap=new Map<Id,Decimal>();
               Decimal QuarterlyPartialBillingCount=0.0;
               Decimal QuarterlyFullBillingCount=0.0;
           
            for (CHANNEL_ORDERS__Customer__c customerQuarterly:customerList){
            for(CHANNEL_ORDERS__Service_Order__c serviceOrderQuarterly:customerQuarterly.CHANNEL_ORDERS__Service_Orders__r){
                
             if(customerQuarterly.Recent_Billing_Date__c>serviceOrderQuarterly.CHANNEL_ORDERS__Service_Start_Date__c && 
               customerQuarterly.LastBillingDate__c<serviceOrderQuarterly.CHANNEL_ORDERS__Service_Start_Date__c){
                system.debug('serviceOrderQuarterly'+serviceOrderQuarterly);
                
            // Calculate the Number of Day between two dates
                Integer noOfDays = serviceOrderQuarterly.CHANNEL_ORDERS__Service_Start_Date__c.daysBetween(customerQuarterly.Recent_Billing_Date__c);
                system.debug('noOfDays'+noOfDays);
                
          PartialBillingMap.put(serviceOrderQuarterly.Id,(serviceOrderQuarterly.Releo_Total_Revenue__c*noOfDays/90));
                   
                for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderQuarterlyDetail:serviceOrderQuarterly.CHANNEL_ORDERS__Partner_Order_Detail__r){
                    system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderQuarterlyDetail.CHANNEL_ORDERS__Product_Name__r.name);
                    system.debug('RelecoPrice__c'+serviceOrderQuarterlyDetail.RelecoPrice__c);
                    system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderQuarterlyDetail.CHANNEL_ORDERS__Quantity__c);
                    
                }
                
                decimal ServiceLicence = PartialBillingMap.get(serviceOrderQuarterly.Id);
                system.debug('ServiceLicence='+ServiceLicence);
                   
                 QuarterlyPartialBillingCount += PartialBillingMap.get(serviceOrderQuarterly.Id);
                 system.debug('QuarterlyPartialBillingCount'+QuarterlyPartialBillingCount);
              
                PartialBillingList.add(serviceOrderQuarterly);
                system.debug('PartialBillingMap'+QuarterlyPartialBillingCount);
                
            }else{
                Map<Id,Decimal>FullBillingMap=new Map<Id,Decimal>();
          
                    if(serviceOrderQuarterly.CHANNEL_ORDERS__Service_Start_Date__c<customerQuarterly.LastBillingDate__c){
                        system.debug('serviceOrderQuarterly='+serviceOrderQuarterly);
                        
                        FullBillingMap.put(serviceOrderQuarterly.Id,(serviceOrderQuarterly.Releo_Total_Revenue__c));
                        for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderQuarterlyDetail:serviceOrderQuarterly.CHANNEL_ORDERS__Partner_Order_Detail__r){
                            system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderQuarterlyDetail.CHANNEL_ORDERS__Product_Name__r.name);
                            system.debug('RelecoPrice__c'+serviceOrderQuarterlyDetail.RelecoPrice__c);
                            system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderQuarterlyDetail.CHANNEL_ORDERS__Quantity__c);
                            
                        }
                        decimal ServiceQuarterlyLicence = PartialBillingMap.get(serviceOrderQuarterly.Id);
                          system.debug('ServiceQuarterlyLicence='+ServiceQuarterlyLicence);
                        
                        
                     QuarterlyFullBillingCount += FullBillingMap.get(serviceOrderQuarterly.Id);
                     system.debug('QuarterlyFullBillingCount='+QuarterlyFullBillingCount);
                        
                         FullBillingList.add(serviceOrderQuarterly);
                        system.debug('FullBillingMap'+serviceOrderQuarterly);
                    } 
                }
               
            }
           Decimal TotalBilling=0.0;
             
            TotalBilling=QuarterlyPartialBillingCount+QuarterlyFullBillingCount;
            system.debug('TotalBilling='+TotalBilling);
            
            system.debug('QuarterlyPartialBillingCount='+QuarterlyPartialBillingCount);
           
            system.debug('QuarterlyFullBillingCount='+QuarterlyFullBillingCount);
            
           
            }
            
            
        }
    
         }

    

    // Half Yearly Billing
    
     public static void calculateCustomerLicenseForHalfYearly(){
                
        List<CHANNEL_ORDERS__Service_Order__c>PartialBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        List<CHANNEL_ORDERS__Service_Order__c>FullBillingList=new List<CHANNEL_ORDERS__Service_Order__c>();
        
        List<CHANNEL_ORDERS__Customer__c> customerList=[Select Id,Name,BIlling_Frequency__c,Active__c,Billing_Start_Date__c,Recent_Billing_Date__c,LastBillingDate__c,
                                                        (Select Id,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,Total_Licenses__c from CHANNEL_ORDERS__Service_Orders__r)
                                                        from CHANNEL_ORDERS__Customer__c 
                                                        where BIlling_Frequency__c='Half Yearly' AND  Active__c=True AND LastBillingDate__c!=null AND Recent_Billing_Date__c!=null And BIlling_Frequency__c!=null];
        system.debug('customerList'+customerList);
         Set<Id>customerIdSet=new Set<Id>();
         for (CHANNEL_ORDERS__Customer__c customerHalfYearly:customerList){
         customerIdSet.add(customerHalfYearly.Id);
             
                
            List<CHANNEL_ORDERS__Service_Order__c> serviceOrderList=[Select Id,CHANNEL_ORDERS__Customer__r.Id,CHANNEL_ORDERS__Customer__r.BIlling_Frequency__c,Name,CHANNEL_ORDERS__Service_Start_Date__c,Releo_Total_Revenue__c,
                                                                        (Select Id,Name,CHANNEL_ORDERS__Product_Name__r.name,RelecoPrice__c,CHANNEL_ORDERS__Quantity__c from CHANNEL_ORDERS__Partner_Order_Detail__r)
                                                                       from CHANNEL_ORDERS__Service_Order__c where CHANNEL_ORDERS__Customer__c IN:customerIdSet AND CHANNEL_ORDERS__Customer__r.Active__c=True];
        
             system.debug('serviceOrderList'+serviceOrderList);
         Map<Id,Decimal>PartialBillingMap=new Map<Id,Decimal>();
               Decimal HalfYearlyPartialBillingCount=0.0;
               Decimal HalfYearlyFullBillingCount=0.0;
           
           
            for(CHANNEL_ORDERS__Service_Order__c serviceOrderHalfYearly:customerHalfYearly.CHANNEL_ORDERS__Service_Orders__r){
                
             if(customerHalfYearly.Recent_Billing_Date__c>serviceOrderHalfYearly.CHANNEL_ORDERS__Service_Start_Date__c && 
               customerHalfYearly.LastBillingDate__c<serviceOrderHalfYearly.CHANNEL_ORDERS__Service_Start_Date__c){
                system.debug('serviceOrderHalfYearly='+serviceOrderHalfYearly);
                
            // Calculate the Number of Day between two dates
                Integer noOfDays = serviceOrderHalfYearly.CHANNEL_ORDERS__Service_Start_Date__c.daysBetween(customerHalfYearly.Recent_Billing_Date__c);
                system.debug('noOfDays'+noOfDays);
                
          PartialBillingMap.put(serviceOrderHalfYearly.Id,(serviceOrderHalfYearly.Releo_Total_Revenue__c*noOfDays/180));
                   
                for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderHalfYearlyDetail:serviceOrderHalfYearly.CHANNEL_ORDERS__Partner_Order_Detail__r){
                    system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderHalfYearlyDetail.CHANNEL_ORDERS__Product_Name__r.name);
                    system.debug('RelecoPrice__c'+serviceOrderHalfYearlyDetail.RelecoPrice__c);
                    system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderHalfYearlyDetail.CHANNEL_ORDERS__Quantity__c);
                    
                }
                
                decimal ServiceLicence = PartialBillingMap.get(serviceOrderHalfYearly.Id);
                system.debug('ServiceLicence='+ServiceLicence);
                   
                 HalfYearlyPartialBillingCount += PartialBillingMap.get(serviceOrderHalfYearly.Id);
                 system.debug('HalfYearlyPartialBillingCount'+HalfYearlyPartialBillingCount);
              
                PartialBillingList.add(serviceOrderHalfYearly);
                system.debug('PartialBillingMap'+HalfYearlyPartialBillingCount);
                
            }else{
                Map<Id,Decimal>FullBillingMap=new Map<Id,Decimal>();
          
                    if(serviceOrderHalfYearly.CHANNEL_ORDERS__Service_Start_Date__c<customerHalfYearly.LastBillingDate__c){
                        system.debug('serviceOrderHalfYearly='+serviceOrderHalfYearly);
                        
                        FullBillingMap.put(serviceOrderHalfYearly.Id,(serviceOrderHalfYearly.Releo_Total_Revenue__c));
                        for(CHANNEL_ORDERS__Service_Order_Detail__c serviceOrderHalfYearlyDetail:serviceOrderHalfYearly.CHANNEL_ORDERS__Partner_Order_Detail__r){
                            system.debug('CHANNEL_ORDERS__Product_Name__r.name'+serviceOrderHalfYearlyDetail.CHANNEL_ORDERS__Product_Name__r.name);
                            system.debug('RelecoPrice__c'+serviceOrderHalfYearlyDetail.RelecoPrice__c);
                            system.debug('CHANNEL_ORDERS__Quantity__c'+serviceOrderHalfYearlyDetail.CHANNEL_ORDERS__Quantity__c);
                            
                        }
                        decimal HalfYearlyServiceLicence = PartialBillingMap.get(serviceOrderHalfYearly.Id);
                          system.debug('HalfYearlyServiceLicence='+HalfYearlyServiceLicence);
                        
                        
                     HalfYearlyFullBillingCount += FullBillingMap.get(serviceOrderHalfYearly.Id);
                     system.debug('HalfYearlyFullBillingCount='+HalfYearlyFullBillingCount);
                        
                         FullBillingList.add(serviceOrderHalfYearly);
                        system.debug('FullBillingMap'+serviceOrderHalfYearly);
                    } 
                }
               
            }
           Decimal TotalBilling=0.0;
             
            TotalBilling=HalfYearlyPartialBillingCount+HalfYearlyFullBillingCount;
            system.debug('TotalBilling='+TotalBilling);
            
            system.debug('HalfYearlyPartialBillingCount='+HalfYearlyPartialBillingCount);
           
            system.debug('HalfYearlyFullBillingCount='+HalfYearlyFullBillingCount);
            
         }
     }
            }*/