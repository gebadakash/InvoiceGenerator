/***************************************************************************************************************
 *  This class is used in ServiceOrderTrigger                                                                  *
 *  It is used to calculated and update total licence count for admin, employee and manager on customer record *                                                                                           *
 * *************************************************************************************************************/

public class ServiceOrderTriggerHelper {
    public static void calculateLicenseCustomer(List<CHANNEL_ORDERS__Service_Order__c>newServiceOrderList){
        Set<Id>customerIdSet=new Set<Id>();
        for(CHANNEL_ORDERS__Service_Order__c serviceOrder:newServiceOrderList){
            customerIdSet.add(serviceOrder.CHANNEL_ORDERS__Customer__c);
        }
        //getting all servive order record of customers that comes from newServiceOrderList
        List<CHANNEL_ORDERS__Service_Order__c>serviceOrderAllCustList=[Select Id,Name,CHANNEL_ORDERS__Customer__c,CHANNEL_ORDERS__Service_Order_Status__c,CHANNEL_ORDERS__Order_Type__c,
                                                                       (Select Id,CHANNEL_ORDERS__Quantity__c,CHANNEL_ORDERS__Product_Name__c,CHANNEL_ORDERS__Product_Name__r.Name FROM CHANNEL_ORDERS__Partner_Order_Detail__r)
                                                                       From CHANNEL_ORDERS__Service_Order__c 
                                                                       Where CHANNEL_ORDERS__Customer__c IN :customerIdSet AND  
                                                                       (CHANNEL_ORDERS__Service_Order_Status__c='Provisioned' OR CHANNEL_ORDERS__Service_Order_Status__c='Activated' OR CHANNEL_ORDERS__Service_Order_Status__c='Draft') AND 
                                                                       (CHANNEL_ORDERS__Order_Type__c='Reduction' OR CHANNEL_ORDERS__Order_Type__c='Add-On' OR CHANNEL_ORDERS__Order_Type__c='Initial' OR CHANNEL_ORDERS__Order_Type__c='Cancellation Order')];
        System.debug('serviceOrderAllCustList'+serviceOrderAllCustList);
        
        Map<Id,CHANNEL_ORDERS__Customer__c>customerMap=new  Map<Id,CHANNEL_ORDERS__Customer__c>();
        
        //logic to calculate licence count and updating customer records
        for(CHANNEL_ORDERS__Service_Order__c serviceOrder:serviceOrderAllCustList){
           if(customerMap.containsKey(serviceOrder.CHANNEL_ORDERS__Customer__c)){
                CHANNEL_ORDERS__Customer__c customer=customerMap.get(serviceOrder.CHANNEL_ORDERS__Customer__c);
                
                for(CHANNEL_ORDERS__Service_Order_Detail__c soDetail:serviceOrder.CHANNEL_ORDERS__Partner_Order_Detail__r){
                    if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.Admin_Product_Label){
                        
                         if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && (serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Initial' || serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on')){
                              customer.Total_Admin_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Admin_License__c;
                            System.debug('customer'+customer);
                         
                         } if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Admin_License__c=customer.Total_Admin_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                            System.debug('customer'+customer);
                        }if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Cancellation Order'){
                            customer.Total_Admin_License__c=0;
                            System.debug('customer'+customer); 
                        }                         
                        } 
                        if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.Manager_Product_Label){
                           if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && (serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Initial' || serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on')){
                                customer.Total_Manager_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Manager_License__c;
                                System.debug('Customer'+customer);     
                            
                            }if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Cancellation Order'){
                                customer.Total_Manager_License__c=0;
                                System.debug('customer'+customer); 
                            } if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                                customer.Total_Manager_License__c=customer.Total_Manager_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                                System.debug('customer'+customer);
                            }
                        }
                        if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.Employee_Product_Label){
                     if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Cancellation Order'){
                                customer.Total_Employee_License__c=0;
                                System.debug('customer'+customer); 
                            
                           }if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && (serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Initial' || serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on')){
                                customer.Total_Employee_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Employee_License__c;
                                System.debug('customer'+customer);
                            }if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                                customer.Total_Employee_License__c=customer.Total_Employee_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                                System.debug('customer'+customer);
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
                    if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.Admin_Product_Label){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && (serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Initial' || serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-On')){
                              customer.Total_Admin_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Admin_License__c;
                            
                            System.debug('Total_Admin_License__c'+customer.Total_Admin_License__c);
                         
                         }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Cancellation Order'){
                            customer.Total_Admin_License__c=0;
                            System.debug('customer'+customer); 
                        }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                            customer.Total_Admin_License__c=customer.Total_Admin_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                            System.debug('customer'+customer);
                        }
                    }
                    
                    if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.Manager_Product_Label){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Cancellation Order'){
                            customer.Total_Manager_License__c=0;
                            System.debug('customer'+customer); 
                        }if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && (serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Initial' || serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on')){
                              customer.Total_Manager_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Manager_License__c;
                            System.debug('customer'+customer);
                         
                         }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                                customer.Total_Manager_License__c=customer.Total_Manager_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                                System.debug('customer'+customer);
                            }
                        
                    }
                    
                    if(soDetail.CHANNEL_ORDERS__Product_Name__r.Name==System.Label.Employee_Product_Label){
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Provisioned' && (serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Initial' || serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Add-on')){
                              customer.Total_Employee_License__c=soDetail.CHANNEL_ORDERS__Quantity__c+customer.Total_Employee_License__c;
                            System.debug('Total_Employee_License__c'+customer.Total_Employee_License__c);
                         
                         }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Cancellation Order'){
                            customer.Total_Employee_License__c=0;
                            System.debug('customer'+customer); 
                        }
                        if(serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c=='Activated' && serviceOrder.CHANNEL_ORDERS__Order_Type__c=='Reduction'){
                                customer.Total_Employee_License__c=customer.Total_Employee_License__c-soDetail.CHANNEL_ORDERS__Quantity__c;
                                System.debug('customer'+customer);
                            }
                    }
                } 
         

        
               customerMap.put(customer.Id,customer);
           System.debug('customerMap'+customerMap);
        }
         
        }
       
       Update customerMap.values();
     System.debug('customerMap'+customerMap.values());
        
    }
  
   
    }