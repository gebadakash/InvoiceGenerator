public class ServiceOrderDetailTriggerClass{
public static void calculateLicenseCustomer(List<CHANNEL_ORDERS__Service_Order__c>newServiceOrderList){

        Set<Id>customerIdSet=new Set<Id>();
        for(CHANNEL_ORDERS__Service_Order__c serviceOrder:newServiceOrderList){
            customerIdSet.add(serviceOrder.CHANNEL_ORDERS__Customer__c);
        }
        
        
        List<CHANNEL_ORDERS__Service_Order__c>serviceOrderAllCustList=[Select Id,Name,CHANNEL_ORDERS__Customer__c,CHANNEL_ORDERS__Service_Order_Status__c,CHANNEL_ORDERS__Order_Type__c,
                                                                       (Select Id,CHANNEL_ORDERS__Quantity__c,Product__c,Product__r.Name FROM CHANNEL_ORDERS__Partner_Order_Detail__r)
                                                                       From CHANNEL_ORDERS__Service_Order__c 
                                                                       Where CHANNEL_ORDERS__Customer__c IN :customerIdSet AND  
                                                                       (CHANNEL_ORDERS__Service_Order_Status__c='Provisioned' OR CHANNEL_ORDERS__Service_Order_Status__c='Activated') AND 
                                                                       (CHANNEL_ORDERS__Order_Type__c='Reduction' OR CHANNEL_ORDERS__Order_Type__c='Add-On')];

System.debug('serviceOrderAllCustList='+serviceOrderAllCustList);
        Map<Id,CHANNEL_ORDERS__Customer__c>customerMap=new  Map<Id,CHANNEL_ORDERS__Customer__c>();
        for(CHANNEL_ORDERS__Service_Order__c serviceOrder:serviceOrderAllCustList){
            if(customerMap.containsKey(serviceOrder.CHANNEL_ORDERS__Customer__c)){
                CHANNEL_ORDERS__Customer__c customer=customerMap.get(serviceOrder.CHANNEL_ORDERS__Customer__c);
                
                for(CHANNEL_ORDERS__Service_Order_Detail__c soDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                    if(soDetail.Product__r.Name=='Releco HR2 Admin'){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on'){
                            customer.Total_Admin_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Admin_License__c;
                            System.debug('customer'+customer);
                        }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Admin_License__c=customer.Total_Admin_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                        }
                    }
                    
                    if(soDetail.Product__r.Name=='Releco HR1 Manager'){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on'){
                            customer.Total_Manager_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Manager_License__c;
                            System.debug('customer'+customer); 
                        }
                        
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Manager_License__c=customer.Total_Manager_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                        }
                    }
                    
                    if(soDetail.Product__r.Name=='Releco HR1 Employee'){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on'){
                            customer.Total_Employee_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Employee_License__c;
                            System.debug('customer'+customer);
                        }
                        
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Employee_License__c=customer.Total_Employee_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                        }
                    } 
                    
                }
            }else{
                CHANNEL_ORDERS__Customer__c customer=new CHANNEL_ORDERS__Customer__c();
                customer.Id=serviceOrder.CHANNEL_ORDERS__Customer__c;
                customer.Total_Admin_License__c=0;
                customer.Total_Employee_License__c=0;
                customer.Total_Manager_License__c=0;
                
                for(CHANNEL_ORDERS__Service_Order_Detail__c soDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                    if(soDetail.Product__r.Name=='Releco HR2 Admin'){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on'){
                            customer.Total_Admin_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Admin_License__c;
                            System.debug('Activated customer'+customer);
                        }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Admin_License__c=customer.Total_Admin_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                        }
                    }
                    
                    if(soDetail.Product__r.Name=='Releco HR1 Manager'){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated'&& serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on'){
                            customer.Total_Manager_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Manager_License__c;
                            System.debug('customer'+customer); 
                        }
                        
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned'&& serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Manager_License__c=customer.Total_Manager_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                            System.debug('Total_Manager_License__c='+  customer.Total_Manager_License__c);
                        }
                    }
                    
                    if(soDetail.Product__r.Name=='Releco HR1 Employee'){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on'){
                            customer.Total_Employee_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Employee_License__c;
                            System.debug('customer Employee'+customer);
                        }
                        
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Employee_License__c=customer.Total_Employee_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                            
                        }
                    } 
                    
                }
                customerMap.put(customer.Id,customer);
                
            } 
        }
        
        Update customerMap.values();
    }
}