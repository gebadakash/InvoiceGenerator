@isTest
private class testBatchForCustomer {
    @testSetup static void data_setUp(){
        
        //Create Account 
        Account acc=new Account();
        acc.Name='RelecoHRSoft';
        insert acc;
        
        //create Customer
        
        //Monthly
       // CHANNEL_ORDERS__Customer__c record1=TestDataFactory.createCustomerMonthly();
         CHANNEL_ORDERS__Customer__c customer1=new CHANNEL_ORDERS__Customer__c();
        customer1.CHANNEL_ORDERS__Customer_Company_Name__c='Mcc.com';
        customer1.CHANNEL_ORDERS__Customer_Org_ID__c='Mcc.com';
        customer1.Contract_Start_Date__c=system.today().addmonths(-1).adddays(1);
        customer1.BIlling_Frequency__c='Monthly';
        customer1.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer1.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer1.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer1.CHANNEL_ORDERS__Customer_Country__c='India';
        customer1.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
        insert customer1; 
        
        //Quarterly
       // CHANNEL_ORDERS__Customer__c record2=TestDataFactory.createCustomerQuarterly();
                CHANNEL_ORDERS__Customer__c customer2=new CHANNEL_ORDERS__Customer__c();
        customer2.CHANNEL_ORDERS__Customer_Company_Name__c='Qcc.com';
        customer2.CHANNEL_ORDERS__Customer_Org_ID__c='Qcc.com';
        customer2.Contract_Start_Date__c=system.today().addmonths(-3).addDays(1);
        customer2.BIlling_Frequency__c='Quarterly';
        customer2.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer2.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer2.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer2.CHANNEL_ORDERS__Customer_Country__c='India';
        customer2.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
    
        insert customer2; 
        
        //Half Yearly
       // CHANNEL_ORDERS__Customer__c record3=TestDataFactory.createCustomerForHalfYear();
         CHANNEL_ORDERS__Customer__c customer3=new CHANNEL_ORDERS__Customer__c();
        customer3.CHANNEL_ORDERS__Customer_Company_Name__c='Ycc.com';
        customer3.CHANNEL_ORDERS__Customer_Org_ID__c='Ycc.com';
        customer3.Contract_Start_Date__c=system.today().addmonths(-6).addDays(1);
        customer3.BIlling_Frequency__c='Half Yearly';
        customer3.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer3.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer3.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer3.CHANNEL_ORDERS__Customer_Country__c='India';
        customer3.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
    
        insert customer3; 

        
        //Annual
      //  CHANNEL_ORDERS__Customer__c record4=TestDataFactory.createCustomerForAnnual();
         CHANNEL_ORDERS__Customer__c customer4=new CHANNEL_ORDERS__Customer__c();
        customer4.CHANNEL_ORDERS__Customer_Company_Name__c='NYcc.com';
        customer4.CHANNEL_ORDERS__Customer_Org_ID__c='NYcc.com';
        customer4.Contract_Start_Date__c=system.today().addmonths(-12).addDays(1);
        customer4.BIlling_Frequency__c='Annual';
        customer4.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer4.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer4.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer4.CHANNEL_ORDERS__Customer_Country__c='India';
        customer4.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
    
        insert customer4; 
        
        //Create Contact
        Contact con=new Contact();
        con.LastName='Joy';
        con.Email='bhusaripratiksha@gmail.com';
        con.AccountId=acc.id;
        insert con; 
        
    }
   
 /*@isTest
    static void batchTestMethod(){
   
       Test.startTest();
        BatchClassForCustomer ba= new BatchClassForCustomer();
        Id jobid= Database.executeBatch(ba);
        Test.stopTest();
        
    }*/ 
    
   
      @isTest
   public static void customerScheduleableTest(){
   
       Test.StartTest();
        CustomerScheduleable batchSch= new CustomerScheduleable();
        String sch = '0 0 23 * * ?';
            system.schedule('Test status check',sch ,batchSch);
        Test.stopTest();
    }
    }