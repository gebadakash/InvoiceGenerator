@isTest
public class TestDataFactory {
    
    public static Product2 createProduct(String productName){
        Product2 product=new Product2();
        product.Name=productName;      
        insert product;
        return product;
    }
    
    public static CHANNEL_ORDERS__Service_Order__c createServiceOrder(CHANNEL_ORDERS__Partner_Contract_Terms__c contractTerm,CHANNEL_ORDERS__Customer__c customer){
         CHANNEL_ORDERS__Service_Order__c serviceOrder=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrder.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrder.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrder.CHANNEL_ORDERS__Order_Type__c='Add-on';
        serviceOrder.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrder.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrder.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrder;
        return serviceOrder;
    }

    public static CHANNEL_ORDERS__Service_Order_Detail__c createServiceOrderDetail(CHANNEL_ORDERS__Partner_Contract_Terms__c contractTerm,CHANNEL_ORDERS__Partner_Product_Catalog__c productCatalog,Product2 product,CHANNEL_ORDERS__Service_Order__c serviceOrder){
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail.CHANNEL_ORDERS__Product_Name__c=productCatalog.Id;
        serviceOrderDetail.Product__c=product.Id;
        serviceOrderDetail.CHANNEL_ORDERS__Partner_Order__c=serviceOrder.Id;
        serviceOrderDetail.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail;
        return serviceOrderDetail;
    }
  
       //Customer Batch Apex
       
    public static CHANNEL_ORDERS__Customer__c createCustomerMonthly(){
        CHANNEL_ORDERS__Customer__c customer1=new CHANNEL_ORDERS__Customer__c();
        customer1.CHANNEL_ORDERS__Customer_Company_Name__c='Mcc.com';
        customer1.CHANNEL_ORDERS__Customer_Org_ID__c='Mcc.com';
        customer1.Contract_Start_Date__c=date.parse('05/10/2023');
        customer1.BIlling_Frequency__c='Monthly';
        customer1.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer1.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer1.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer1.CHANNEL_ORDERS__Customer_Country__c='India';
        customer1.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
        insert customer1; 
        return customer1;
    }

    public static CHANNEL_ORDERS__Customer__c createCustomerQuarterly(){
        CHANNEL_ORDERS__Customer__c customer2=new CHANNEL_ORDERS__Customer__c();
        customer2.CHANNEL_ORDERS__Customer_Company_Name__c='Qcc.com';
        customer2.CHANNEL_ORDERS__Customer_Org_ID__c='Qcc.com';
        customer2.Contract_Start_Date__c=date.parse('3/10/2023');
        customer2.BIlling_Frequency__c='Quarterly';
        customer2.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer2.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer2.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer2.CHANNEL_ORDERS__Customer_Country__c='India';
        customer2.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
    
        insert customer2; 
        return customer2;
    }
    
     public static CHANNEL_ORDERS__Customer__c createCustomerForHalfYear(){
        CHANNEL_ORDERS__Customer__c customer3=new CHANNEL_ORDERS__Customer__c();
        customer3.CHANNEL_ORDERS__Customer_Company_Name__c='Ycc.com';
        customer3.CHANNEL_ORDERS__Customer_Org_ID__c='Ycc.com';
        customer3.Contract_Start_Date__c=date.parse('12/10/2022');
        customer3.BIlling_Frequency__c='Half Yearly';
        customer3.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer3.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer3.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer3.CHANNEL_ORDERS__Customer_Country__c='India';
        customer3.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
    
        insert customer3; 
        return customer3;
    }
    public static CHANNEL_ORDERS__Customer__c createCustomerForAnnual(){
        CHANNEL_ORDERS__Customer__c customer4=new CHANNEL_ORDERS__Customer__c();
        customer4.CHANNEL_ORDERS__Customer_Company_Name__c='NYcc.com';
        customer4.CHANNEL_ORDERS__Customer_Org_ID__c='NYcc.com';
        customer4.Contract_Start_Date__c=date.parse('6/10/2021');
        customer4.BIlling_Frequency__c='Annual';
        customer4.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer4.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer4.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer4.CHANNEL_ORDERS__Customer_Country__c='India';
        customer4.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
    
        insert customer4; 
        return customer4;
    }
    
     public static  Messaging.SingleEmailMessage  createEmailMessage(Id templateId,CHANNEL_ORDERS__Customer__c customer, Contact conList){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toAddresses=new List<String>{'bhusaripratiksha@gmail.com'};
            // Who you are sending the email to
            mail.setTargetObjectId(conList.id);
         // The email template ID used for the email
        mail.setTemplateId(templateId);
        mail.setWhatId(customer.Id);   
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setReplyTo('bhusaripratiksha@gmail.com');
        mail.setSenderDisplayName('CustomerBillingEmailAlert');
        mail.setSaveAsActivity(false);
        return mail;
            }
}