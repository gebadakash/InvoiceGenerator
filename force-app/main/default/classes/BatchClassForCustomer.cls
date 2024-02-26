public class BatchClassForCustomer implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        string query='select id,Name,Contract_Start_Date__c,BIlling_Frequency__c,LastBillingDate__c,Contract_Expiry_Date__c,CHANNEL_ORDERS__Account__c,Active__c from CHANNEL_ORDERS__Customer__c where BIlling_Frequency__c!=null AND Contract_Start_Date__c!=null AND Active__c=true';
        System.debug('query'+query);
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<CHANNEL_ORDERS__Customer__c> allCustomerOrderRecords){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<CHANNEL_ORDERS__Customer__c>customerList=new List<CHANNEL_ORDERS__Customer__c>();
        Id templateId = [select id, name from EmailTemplate where developername = 'License_Expiry_Notification_Template'].id;
        System.debug('allCustomerOrderRecords'+allCustomerOrderRecords);
        Contact con=[Select Id,Name from Contact limit 1];
        system.debug('con'+con);
        
        //Monthly Email Notification 
        set<CHANNEL_ORDERS__Customer__c> customerSetId=new set<CHANNEL_ORDERS__Customer__c>();
        for(CHANNEL_ORDERS__Customer__c customer:allCustomerOrderRecords){
                           
        Date FutureBillingDate;

          FutureBillingDate=system.today().adddays(1);
            
             Date referenceDate;
         
            referenceDate=customer.Contract_Start_Date__c;
            
            //  Create currentContractStartDatePeriod with monthly Condition
          if(customer.BIlling_Frequency__c=='Monthly'){
                System.debug('referenceDate'+referenceDate);
                Date b = Date.today();
                system.debug('b'+b);
                // calculate the number of month between two dates
                Integer monthDiff = referenceDate.monthsBetween(b);
                system.debug('monthDiff'+monthDiff);
                integer result= math.mod(monthDiff,1);
                //Check conditons is true
                if(monthDiff!=0 && monthDiff>0 && referenceDate.addMonths(monthDiff).day()-1==System.today().day() && math.mod(monthDiff,1)==0){
                    System.debug('B'+(referenceDate.addMonths(monthDiff).day()-1==System.today().day()));
                   customer.LastBillingDate__c=FutureBillingDate.addMonths(-1);
                    customer.Recent_Billing_Date__c=FutureBillingDate;
                   
                    customerList.add(customer);

                    Messaging.SingleEmailMessage monthlyMail= createEmailMessage(templateId, customer,con);
                    if(monthlyMail!=null){
                        mails.add(monthlyMail);
                    } 
                }
                customerSetId.add(customer);
            }
            
         //Quarterly email Notification
         if(customer.BIlling_Frequency__c=='Quarterly'){
                Date b = Date.today();
                Integer quarterlymonthDiff = referenceDate.monthsBetween(b);
                //Check conditons is true
                integer result= math.mod(quarterlymonthDiff,3);
                if(quarterlymonthDiff!=0 && quarterlymonthDiff>0 && referenceDate.addMonths(quarterlymonthDiff).day()-1==System.today().day() && math.mod(quarterlymonthDiff,3)==0){
                    customer.LastBillingDate__c=FutureBillingDate.addMonths(-3);
                    customer.Recent_Billing_Date__c=FutureBillingDate;
                    
                    customerList.add(customer);

                    Messaging.SingleEmailMessage quarterlyMail= createEmailMessage(templateId, customer,con);
                    if(quarterlyMail!=null){
                        mails.add(quarterlyMail);
                    }
                }                                         
                customerSetId.add(customer);
            }
            
            // Half Yearly Email Notification
            if(customer.BIlling_Frequency__c=='Half Yearly'){
                Date b = Date.today();
                Integer halfYearlymonthDiff = referenceDate.monthsBetween(b);
                integer result= math.mod(halfYearlymonthDiff,6);
                if(halfYearlymonthDiff!=0 && halfYearlymonthDiff>0 && referenceDate.addMonths(halfYearlymonthDiff).day()-1==System.today().day() && math.mod(halfYearlymonthDiff,6)==0){
                    customer.LastBillingDate__c=FutureBillingDate.addMonths(-6);
                    customer.Recent_Billing_Date__c=FutureBillingDate;
                     
                    customerList.add(customer);

                    Messaging.SingleEmailMessage halfYearlyMail= createEmailMessage(templateId, customer,con);
                    if(halfYearlyMail!=null){
                        mails.add(halfYearlyMail);
                    }
                }
                customerSetId.add(customer);
            }
            
            // Annual Email Notification
           if(customer.BIlling_Frequency__c=='Annual'){
                Date b = Date.today();
                Integer AnnualmonthDiff = referenceDate.monthsBetween(b);
                integer result= math.mod(AnnualmonthDiff,12);
                if(AnnualmonthDiff!=0 && AnnualmonthDiff>0 && referenceDate.addMonths(AnnualmonthDiff).day()-1==System.today().day() && math.mod(AnnualmonthDiff,12)==0){
                     customer.LastBillingDate__c=FutureBillingDate.addMonths(-12);
                    customer.Recent_Billing_Date__c=FutureBillingDate;
                   
                    customerList.add(customer);

                    Messaging.SingleEmailMessage AnnualMail= createEmailMessage(templateId, customer,con);
                    if(AnnualMail!=null){
                        mails.add(AnnualMail);
                    }
                }
                customerSetId.add(customer);
            }
        }
        if(mails.size() > 0){
            update customerList;
            Messaging.sendEmail(mails);
        }
    }
    public void finish(Database.BatchableContext bc){
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
                          TotalJobItems, CreatedBy.Email
                          FROM AsyncApexJob WHERE Id =
                          :BC.getJobId()];
        //further finish method logic
    }
    // Method for Email Notification giving to Contacts via Accounts from customers
    public static Messaging.SingleEmailMessage  createEmailMessage(Id templateId,CHANNEL_ORDERS__Customer__c customer, Contact con){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toAddresses=new List<String>{'bhusaripratiksha@gmail.com'};
           // mail.toAddresses=new List<String>{'piyush@relecotech.com'};  
                // Who you are sending the email to
                mail.setTargetObjectId(con.id);
        mail.setTreatTargetObjectAsRecipient(false);
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