trigger UpdateCustomerLicenses on Service_Order__c (after insert, after update) {
    Set<Id> customerIds = new Set<Id>();
    Map<Id, Decimal> adminLicensesMap = new Map<Id, Decimal>();
    Map<Id, Decimal> managerLicensesMap = new Map<Id, Decimal>();
    Map<Id, Decimal> employeeLicensesMap = new Map<Id, Decimal>();
    
    
    for (Service_Order__c order : Trigger.new) {
        // Only process orders with status = "Received"
        if (order.Order_Status__c == 'Received') {
            customerIds.add(order.Customer__c);
        }
    }
    
    
    // Query related Service Order Details and calculate license totals
    List<Service_Order_Detail__c> details = [SELECT Total_Quantity__c, Product_Name__c, Service_Order__r.Customer__c, Product_Name__r.Name, Service_Order__r.Order_Type__c
                                             FROM Service_Order_Detail__c 
                                             WHERE Service_Order__r.Customer__c IN :customerIds];

    for (Service_Order_Detail__c detail : details) {
    if (detail.Product_Name__r.Name == 'Admin License') {
        if (adminLicensesMap.containsKey(detail.Service_Order__r.Customer__c)) {
            if (detail.Service_Order__r.Order_Type__c == 'Reduction') {
                adminLicensesMap.put(detail.Service_Order__r.Customer__c, adminLicensesMap.get(detail.Service_Order__r.Customer__c) - detail.Total_Quantity__c);
            } else {
                adminLicensesMap.put(detail.Service_Order__r.Customer__c, adminLicensesMap.get(detail.Service_Order__r.Customer__c) + detail.Total_Quantity__c);
            }
        } else {
            adminLicensesMap.put(detail.Service_Order__r.Customer__c, detail.Total_Quantity__c);
        }
    } else if (detail.Product_Name__r.Name == 'Manager License') {
        if (managerLicensesMap.containsKey(detail.Service_Order__r.Customer__c)) {
            if (detail.Service_Order__r.Order_Type__c == 'Reduction') {
                managerLicensesMap.put(detail.Service_Order__r.Customer__c, managerLicensesMap.get(detail.Service_Order__r.Customer__c) - detail.Total_Quantity__c);
            } else {
                managerLicensesMap.put(detail.Service_Order__r.Customer__c, managerLicensesMap.get(detail.Service_Order__r.Customer__c) + detail.Total_Quantity__c);
            }
        } else {
            managerLicensesMap.put(detail.Service_Order__r.Customer__c, detail.Total_Quantity__c);
        }
    } else if (detail.Product_Name__r.Name == 'Employee License') {
        if (employeeLicensesMap.containsKey(detail.Service_Order__r.Customer__c)) {
            if (detail.Service_Order__r.Order_Type__c == 'Reduction') {
                employeeLicensesMap.put(detail.Service_Order__r.Customer__c, employeeLicensesMap.get(detail.Service_Order__r.Customer__c) - detail.Total_Quantity__c);
            } else {
                employeeLicensesMap.put(detail.Service_Order__r.Customer__c, employeeLicensesMap.get(detail.Service_Order__r.Customer__c) + detail.Total_Quantity__c);
            }
        } else {
            employeeLicensesMap.put(detail.Service_Order__r.Customer__c, detail.Total_Quantity__c);
        }
    }
           
}
    

    
    // Update Customer records with license totals
    List<Customer__c> customersToUpdate = new List<Customer__c>();
    for (Id customerId : customerIds) {
        Customer__c customer = new Customer__c(Id = customerId);
        if (adminLicensesMap.containsKey(customerId)) {
            customer.Total_Admin_License__c = adminLicensesMap.get(customerId);
        }
        if (managerLicensesMap.containsKey(customerId)) {
            customer.Total_Manager_License__c = managerLicensesMap.get(customerId);
        }
        if (employeeLicensesMap.containsKey(customerId)) {
            customer.Total_Employee_License__c = employeeLicensesMap.get(customerId);
        }
        customersToUpdate.add(customer);
    }
    
    if (!customersToUpdate.isEmpty()) {
        update customersToUpdate;
    }
    
    
}