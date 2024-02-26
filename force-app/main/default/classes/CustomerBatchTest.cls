@isTest
public class CustomerBatchTest {
@testSetup static void data_setUp(){
    
    //create customer 
    
        //Monthly   
      CHANNEL_ORDERS__Customer__c customer=new CHANNEL_ORDERS__Customer__c();
        customer.CHANNEL_ORDERS__Customer_Company_Name__c='Acc.com';
        customer.CHANNEL_ORDERS__Customer_Org_ID__c='Acc.com';
        customer.Contract_Start_Date__c=Date.newInstance(2023,6,10);
        customer.BIlling_Frequency__c='Monthly';
        customer.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer.CHANNEL_ORDERS__Customer_Country__c='India';
        customer.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
        
        insert customer; 
    
    //Quarterly
   CHANNEL_ORDERS__Customer__c record2=TestDataFactory.createCustomerQuarterly();
    //Half Yearly
     CHANNEL_ORDERS__Customer__c record3=TestDataFactory.createCustomerForHalfYear();
   
    //Annual
     CHANNEL_ORDERS__Customer__c record4=TestDataFactory.createCustomerForAnnual();
   
      
}
     @isTest
    private static void customerEmaiNotificationTest(){
        
        List<CHANNEL_ORDERS__Customer__c> customerListId=[Select Name,BIlling_Frequency__c,Contract_Start_Date__c
                                                                      From CHANNEL_ORDERS__Customer__c
                                                                      where Contract_Start_Date__c!=null AND
                                                                      BIlling_Frequency__c!=null];
        
        set<CHANNEL_ORDERS__Customer__c> customerSetId=new set<CHANNEL_ORDERS__Customer__c>();
        for(CHANNEL_ORDERS__Customer__c customerList:customerListId){
         List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Id templateId = [select id, name from EmailTemplate where developername = 'License_Expiry_Notification_Template'].id;
            if((customerList.Contract_Start_Date__c.addMonths(1)-1==System.today() || (customerList.Contract_Start_Date__c.addMonths(1)-1<=System.today().addYears(-1))) && customerList.BIlling_Frequency__c=='Monthly'){
             system.debug('customerList='+customerList);
             Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                mail1.toAddresses=new List<String>{'bhusaripratiksha@gmail.com'};
                    // Who you are sending the email to
                    mail1.setTargetObjectId('0038I00000N13T1QAJ');
                // The email template ID used for the email
                mail1.setTemplateId(templateId);
                //mail1.setWhatId(customer.Id);   
                mail1.setBccSender(false);
                mail1.setUseSignature(false);
                mail1.setReplyTo('bhusaripratiksha@gmail.com');
                mail1.setSenderDisplayName('CustomerLicenseExpiryEmailAlert');
                mail1.setSaveAsActivity(false); 
                mails.add(mail1);
              
              customerSetId.add(customerList);
           System.debug('customerSetId'+customerSetId);
          
                
      }
          if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }   
            
        }
        
        test.startTest();
           BatchClassForCustomer b=new BatchClassForCustomer();
           database.executeBatch(b);

        test.stopTest();
        
    }
     @isTest
    private static void customerQuarterlyEmaiNotificationTest(){
        
        List<CHANNEL_ORDERS__Customer__c> customerListId=[Select Name,BIlling_Frequency__c,Contract_Start_Date__c
                                                                      From CHANNEL_ORDERS__Customer__c
                                                                      where Contract_Start_Date__c!=null AND
                                                                      BIlling_Frequency__c!=null];
        
     
        
         set<CHANNEL_ORDERS__Customer__c> customerSetId=new set<CHANNEL_ORDERS__Customer__c>();
        for(CHANNEL_ORDERS__Customer__c customerList:customerListId){
         List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Id templateId = [select id, name from EmailTemplate where developername = 'License_Expiry_Notification_Template'].id;
           if((customerList.Contract_Start_Date__c.addMonths(3)-1==System.today() || (customerList.Contract_Start_Date__c.addMonths(3)-1<=System.today().addYears(-1))) && customerList.BIlling_Frequency__c=='Quarterly'){
             system.debug('customerList='+customerList);
            
            
                
             Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                mail1.toAddresses=new List<String>{'bhusaripratiksha@gmail.com'};
                    // Who you are sending the email to
                    mail1.setTargetObjectId('0038I00000N13T1QAJ');
                // The email template ID used for the email
                mail1.setTemplateId(templateId);
                //mail1.setWhatId(customer.Id);   
                mail1.setBccSender(false);
                mail1.setUseSignature(false);
                mail1.setReplyTo('bhusaripratiksha@gmail.com');
                mail1.setSenderDisplayName('CustomerLicenseExpiryEmailAlert');
                mail1.setSaveAsActivity(false); 
                mails.add(mail1);
              
              customerSetId.add(customerList);
           System.debug('customerSetId'+customerSetId);
          
                
      }
          if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }   
            
        }
        
        test.startTest();
           BatchClassForCustomer b=new BatchClassForCustomer();
           database.executeBatch(b);

        test.stopTest();
        
    }
        
         @isTest
    private static void customerHalf_YearlyEmaiNotificationTest(){
        
        List<CHANNEL_ORDERS__Customer__c> customerListId=[Select Name,BIlling_Frequency__c,Contract_Start_Date__c
                                                                      From CHANNEL_ORDERS__Customer__c
                                                                      where Contract_Start_Date__c!=null AND
                                                                      BIlling_Frequency__c!=null];
        
     
        
         set<CHANNEL_ORDERS__Customer__c> customerSetId=new set<CHANNEL_ORDERS__Customer__c>();
        for(CHANNEL_ORDERS__Customer__c customerList:customerListId){
         List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Id templateId = [select id, name from EmailTemplate where developername = 'License_Expiry_Notification_Template'].id;
            if((customerList.Contract_Start_Date__c.addMonths(6)-1==System.today() || (customerList.Contract_Start_Date__c.addMonths(6)-1<=System.today().addYears(-1))) && customerList.BIlling_Frequency__c=='Quarterly'){
             system.debug('customerList='+customerList);
             Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                mail1.toAddresses=new List<String>{'bhusaripratiksha@gmail.com'};
                    // Who you are sending the email to
                    mail1.setTargetObjectId('0038I00000N13T1QAJ');
                // The email template ID used for the email
                mail1.setTemplateId(templateId);
                //mail1.setWhatId(customer.Id);   
                mail1.setBccSender(false);
                mail1.setUseSignature(false);
                mail1.setReplyTo('bhusaripratiksha@gmail.com');
                mail1.setSenderDisplayName('CustomerLicenseExpiryEmailAlert');
                mail1.setSaveAsActivity(false); 
                mails.add(mail1);
              
              customerSetId.add(customerList);
           System.debug('customerSetId'+customerSetId);
          
                
      }
          if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }   
            
        }
        
        test.startTest();
           BatchClassForCustomer b=new BatchClassForCustomer();
           database.executeBatch(b);

        test.stopTest();
        
    }   
}