public with sharing class MyController {
    @AuraEnabled(cacheable=true)
    public static Totals getTotals() {
        Totals totals = new Totals();
        totals.totalCustomers = [SELECT COUNT() FROM Customer__c];
        totals.totalProducts = [SELECT COUNT() FROM Product__c];
        totals.totalServiceOrders = [SELECT COUNT() FROM Service_Order__c];
        totals.totalServiceOrderDetails = [SELECT COUNT() FROM Service_Order_Detail__c];
        return totals;
    }
    
    public class Totals {
        @AuraEnabled public Integer totalCustomers;
        @AuraEnabled public Integer totalProducts;
        @AuraEnabled public Integer totalServiceOrders;
        @AuraEnabled public Integer totalServiceOrderDetails;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Customer__c> fetchCustomers() {
        return [
            SELECT Id, Name, Contract_Start_Date__c, Email_id__c, Total_Admin_License__c, Total_Employee_License__c, Total_Manager_License__c
            FROM Customer__c
        ];
    }
    
    
}