public class PdfController {
	
    @AuraEnabled
    public static void saveAsAttachment(List<AttachmentWrapper> attachments) {
        List<Attachment> attachmentList = new List<Attachment>();

        for (AttachmentWrapper attachmentWrapper : attachments) {
            // Convert the Base64 string to Blob
            Blob attachmentBlob = EncodingUtil.base64Decode(attachmentWrapper.attachmentBody);

            // Create the attachment record
            Attachment attachment = new Attachment();
            attachment.ParentId = attachmentWrapper.recId;
            attachment.Name = attachmentWrapper.fileName;
            attachment.Body = attachmentBlob;
            attachment.ContentType = 'application/pdf';

            attachmentList.add(attachment);
        }

        // Insert the attachment records
        insert attachmentList;
    }

    public class AttachmentWrapper {
        @AuraEnabled
        public Id recId { get; set; }
        @AuraEnabled
        public String fileName { get; set; }
        @AuraEnabled
        public String attachmentBody { get; set; }
    }
    
    @AuraEnabled(cacheable=true)
    public static void sendEmailWithAttachment(Id recId, String attachmentName, String attachmentBody) {
        // Retrieve the customer's email address from the Customer object
        Customer__c customer = [SELECT Email_id__c FROM Customer__c WHERE Id = :recId];
        String recipientEmail = customer.Email_id__c;
        
        // Create a new EmailFileAttachment object for the invoice attachment
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName(attachmentName);
        attachment.setBody(EncodingUtil.base64Decode(attachmentBody));
        
        // Create a new SingleEmailMessage object
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { recipientEmail });
        email.setSubject('Invoice');
        email.setPlainTextBody('Please find the attached invoice.');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {attachment});
        
        // Send the email
        Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        
        // Check the results of the email sending operation
        if (sendResults[0].isSuccess()) {
            System.debug('Email sent successfully');
        } else {
            System.debug('Failed to send the email');
            throw new AuraHandledException('Failed to send the email');
        }
    
    }
    
}