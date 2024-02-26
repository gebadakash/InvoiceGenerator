public with sharing class InvoiceDataController {
    @AuraEnabled(cacheable=true)
    public static InvoiceData fetchDataForCustomer(Id customerId) {
        Customer__c customerRecord = [SELECT Id, Terms__c, Email_id__c FROM Customer__c WHERE Id = :customerId];
        
        Decimal terms = customerRecord.Terms__c != null ? customerRecord.Terms__c : 0.0;
        String termsValue = (terms == 0) ? 'Due on Receipt' : String.valueOf(terms.intValue());
        
        // Calculate invoiceDate and dueDate based on terms
        Date invoiceDate = Date.today();
        Date dueDate = invoiceDate.addDays(terms.intValue());
        
        InvoiceData data = new InvoiceData();
        if (termsValue == 'Due on Receipt') {
            data.terms = termsValue;
        } else {
            data.terms = 'Net ' + termsValue;
        }
        data.invoiceDate = formatDate(invoiceDate);
        data.dueDate = formatDate(dueDate);
        
        // Populate company info
        Map<String, String> companyInfo = getCompanyInfo();
        data.companyName = companyInfo.get('name');
        data.companyStreet = companyInfo.get('street');
        data.companyCity = companyInfo.get('city');
        data.companyPostalCode = companyInfo.get('postalCode');
        data.companyState = companyInfo.get('state');
        data.companyCountry = companyInfo.get('country');
        
        return data;
    }
    
    public static String formatDate(Date dateValue) {
        String year = String.valueOf(dateValue.year());
        String month = String.valueOf(dateValue.month()).leftPad(2, '0');
        String day = String.valueOf(dateValue.day()).leftPad(2, '0');
        return day + '/' + month + '/' + year;
    }
    
    public class InvoiceData {
        @AuraEnabled public String terms;
        @AuraEnabled public String invoiceDate;
        @AuraEnabled public String dueDate;
        @AuraEnabled public String companyName;
        @AuraEnabled public String companyStreet;
        @AuraEnabled public String companyCity;
        @AuraEnabled public String companyPostalCode;
        @AuraEnabled public String companyState;
        @AuraEnabled public String companyCountry;
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getCompanyInfo() {
        Organization org = [SELECT Name, Street, City, PostalCode, State, Country FROM Organization LIMIT 1];
        
        Map<String, String> companyInfo = new Map<String, String>();
        companyInfo.put('name', org.Name);
        companyInfo.put('street', org.Street);
        companyInfo.put('city', org.City);
        companyInfo.put('postalCode', org.PostalCode);
        companyInfo.put('state', org.State);
        companyInfo.put('country', org.Country);
        
        system.debug('companyInfo' + companyInfo);
        return companyInfo;
    }
    
    @AuraEnabled
    public static void savePdfAsAttachment(String parentId, String pdfContent, String attachmentName) {
        Attachment attachment = new Attachment();
        attachment.ParentId = parentId;
        attachment.Name = attachmentName;
        attachment.Body = EncodingUtil.base64Decode(pdfContent);
        attachment.ContentType = 'application/pdf'; // Set the content type
        insert attachment;
    }
    
    
    @AuraEnabled
    public static void sendEmailWithAttachment(Id customerId, String pdfContent) {
        Customer__c customer = [SELECT Email_id__c FROM Customer__c WHERE Id = :customerId LIMIT 1];
        String customerEmail = customer.Email_id__c;
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{customerEmail});
        email.setSubject('Invoice');
        email.setPlainTextBody('Thank you for using our services. Please find the attached invoice.');
        
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('invoice.pdf');
        attachment.setContentType('application/pdf');
        attachment.setInline(false);
        attachment.setBody(EncodingUtil.base64Decode(pdfContent));
        
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{attachment});
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        
        if (results[0].isSuccess()) {
            System.debug('Email sent successfully');
        } else {
            System.debug('Email send failed: ' + results[0].getErrors()[0].getMessage());
        }
    }    
}