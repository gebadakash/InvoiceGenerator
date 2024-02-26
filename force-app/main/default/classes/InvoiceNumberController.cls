public class InvoiceNumberController {
    @AuraEnabled(cacheable=true)
    public static Decimal getAndIncrementInvoiceNumber() {
        Invoice_Number__c invoiceNumber = [SELECT Number__c FROM Invoice_Number__c LIMIT 1 FOR UPDATE];
        Decimal currentNumber = invoiceNumber.Number__c;
        Decimal newNumber = currentNumber + 1;
        updateInvoiceNumber(invoiceNumber.Id, newNumber);
        return newNumber;
    }
    
    @Future
    public static void updateInvoiceNumber(Id invoiceNumberId, Decimal newNumber) {
        Invoice_Number__c invoiceNumber = new Invoice_Number__c(Id = invoiceNumberId, Number__c = newNumber);
        update invoiceNumber;
    }
}