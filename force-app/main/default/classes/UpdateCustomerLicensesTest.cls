@isTest
public class UpdateCustomerLicensesTest {
    @isTest
    static void testUpdateCustomerLicenses() {
        // Create test data
        Customer__c customer = new Customer__c();
        insert customer;
        
        Product__c adminLicense = new Product__c(Name = 'Admin License');
        insert adminLicense;
        
        Product__c managerLicense = new Product__c(Name = 'Manager License');
        insert managerLicense;
        
        Product__c employeeLicense = new Product__c(Name = 'Employee License');
        insert employeeLicense;
        
        Service_Order__c serviceOrder = new Service_Order__c(Customer__c = customer.Id, Order_Status__c = 'Received');
        insert serviceOrder;
        
        Service_Order_Detail__c adminDetail = new Service_Order_Detail__c(
            Service_Order__c = serviceOrder.Id,
            Product_Name__c = adminLicense.Id,
            Total_Quantity__c = 5
        );
        insert adminDetail;
        
        Service_Order_Detail__c managerDetail = new Service_Order_Detail__c(
            Service_Order__c = serviceOrder.Id,
            Product_Name__c = managerLicense.Id,
            Total_Quantity__c = 3
        );
        insert managerDetail;
        
        Service_Order_Detail__c employeeDetail = new Service_Order_Detail__c(
            Service_Order__c = serviceOrder.Id,
            Product_Name__c = employeeLicense.Id,
            Total_Quantity__c = 10
        );
        insert employeeDetail;
        
        // Call the trigger manually
        List<Service_Order__c> serviceOrders = new List<Service_Order__c>{serviceOrder};
        
        // Update Service_Order__c records first
        serviceOrder.Order_Status__c = 'In Process';
        update serviceOrders;
        
        // Update Service_Order_Detail__c records
        adminDetail.Total_Quantity__c = 2;
        update adminDetail;
        
        managerDetail.Total_Quantity__c = 1;
        update managerDetail;
        
        employeeDetail.Total_Quantity__c = 5;
        update employeeDetail;
        
        // Update Service_Order__c records again
        serviceOrder.Order_Status__c = 'Received';
        update serviceOrders;
        
        // Retrieve the updated Customer record
        Customer__c updatedCustomer = [SELECT Id, Total_Admin_License__c, Total_Manager_License__c, Total_Employee_License__c FROM Customer__c WHERE Id = :customer.Id];
        
        // Verify the updated license totals for reduction
        System.assertEquals(2, updatedCustomer.Total_Admin_License__c, 'Incorrect Total_Admin_License__c value');
        System.assertEquals(1, updatedCustomer.Total_Manager_License__c, 'Incorrect Total_Manager_License__c value');
        System.assertEquals(5, updatedCustomer.Total_Employee_License__c, 'Incorrect Total_Employee_License__c value');
    }
}