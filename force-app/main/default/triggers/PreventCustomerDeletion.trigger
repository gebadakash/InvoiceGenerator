trigger PreventCustomerDeletion on Customer__c (before delete, before insert) {
    if (Trigger.isDelete) {
        for (Customer__c customer : Trigger.old) {
            if (customer.Active__c) {
                customer.addError('You cannot delete an active customer.');
            }
        }
    }
    
    if (Trigger.isInsert) {
        for (Customer__c customer : Trigger.new) {
            if (!customer.Active__c) {
                customer.addError('Customer record cannot be inserted without checking the "Active" checkbox.');
            }
        }
    }
}