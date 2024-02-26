@isTest
public class EmailNotificationBatch_test {
     
    static testMethod void testBatchClass()
    {
            List<CHANNEL_ORDERS__Customer__c> datalist = new List<CHANNEL_ORDERS__Customer__c>();
            CHANNEL_ORDERS__Customer__c a = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='Relecotech',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378425',CHANNEL_ORDERS__Customer_Street__c='Stree Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445201',Contract_Start_Date__c=date.newInstance(2022, 6, 26));
            datalist.add(a);
        
            CHANNEL_ORDERS__Customer__c b = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='TCS',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378426',CHANNEL_ORDERS__Customer_Street__c='Street Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c   ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445211',Contract_Start_Date__c=date.newInstance(2022, 06, 15));
            datalist.add(b);
        
             CHANNEL_ORDERS__Customer__c c = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='Softronix',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378427',CHANNEL_ORDERS__Customer_Street__c='walk Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c  ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445212',Contract_Start_Date__c=date.newInstance(2018, 07, 13));
            datalist.add(c);

            CHANNEL_ORDERS__Customer__c d = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='AVN',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378428',CHANNEL_ORDERS__Customer_Street__c='One Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c  ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445212',Contract_Start_Date__c=date.newInstance(2022, 06, 28));
            datalist.add(d);    
        
            CHANNEL_ORDERS__Customer__c e = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='IBN',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378429',CHANNEL_ORDERS__Customer_Street__c='Two Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c  ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445212',Contract_Start_Date__c=date.newInstance(2022, 07, 28));
            datalist.add(e);    
        
        	CHANNEL_ORDERS__Customer__c f = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='INFOSYS',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378430',CHANNEL_ORDERS__Customer_Street__c='Two Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c  ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445212',Contract_Start_Date__c=date.newInstance(2022, 06, 13));
            datalist.add(f);
        
        	CHANNEL_ORDERS__Customer__c g = new CHANNEL_ORDERS__Customer__c(CHANNEL_ORDERS__Customer_Company_Name__c='WIPRO',CHANNEL_ORDERS__Customer_Org_ID__c='00D124596378431',CHANNEL_ORDERS__Customer_Street__c='Two Way',CHANNEL_ORDERS__Customer_City__c='Nagpur',CHANNEL_ORDERS__Customer_Country__c  ='India',CHANNEL_ORDERS__Customer_State__c='Maharashtra',CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='445212',Contract_Start_Date__c=date.newInstance(2022, 06, 14));
            datalist.add(g); 
        
            insert datalist;
        
              Test.startTest();
              EmailNotificationBatch EmailNotificationBatch_test= new EmailNotificationBatch();
              Database.executeBatch(EmailNotificationBatch_test);
              Test.stopTest();
            
    }

}