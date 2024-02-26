@isTest
public class ServiceOrderTriggerHelperTest {
    
    /*
    @testSetup static void data_setUp(){
        
        //create Customer
        
        CHANNEL_ORDERS__Customer__c customer=new CHANNEL_ORDERS__Customer__c();
        customer.CHANNEL_ORDERS__Customer_Company_Name__c='SpancoSoftwareSolution.com';
        customer.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution.com';
        customer.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer.CHANNEL_ORDERS__Customer_Country__c='India';
        customer.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
        
        insert customer;
        
        // Create  Partner Contract Term1
        
        CHANNEL_ORDERS__Partner_Contract_Terms__c contractTerm=new CHANNEL_ORDERS__Partner_Contract_Terms__c();
        contractTerm.Name='SpancoSoftwareSolution';
        contractTerm.CHANNEL_ORDERS__Partner_API_Key__c='SpancoSoftwareSolution';
        
        insert contractTerm;
        
        // Create ServiceOrderRecord 1 
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderAddOn=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderAddOn.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderAddOn.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderAddOn.CHANNEL_ORDERS__Order_Type__c='Add-on';
        serviceOrderAddOn.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderAddOn.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderAddOn.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderAddOn;
        
        //
       
        // Create ServiceOrderRecord 2 
        CHANNEL_ORDERS__Service_Order__c serviceOrderRedu=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderRedu.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderRedu.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderRedu.CHANNEL_ORDERS__Order_Type__c='Reduction';
        serviceOrderRedu.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderRedu.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderRedu.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderRedu;
        
       
        //  List<CHANNEL_ORDERS__Service_Order__c> newserviceOrderList=new List<CHANNEL_ORDERS__Service_Order__c>();
        //  newserviceOrderList.add(serviceOrderAddOn);
        // newserviceOrderList.add(serviceOrderRedu);
        
        // insert newserviceOrderList;
        
        // create  Partner Product Catalog
        List<CHANNEL_ORDERS__Partner_Product_Catalog__c> productCatalogList=new List<CHANNEL_ORDERS__Partner_Product_Catalog__c>();
        
        CHANNEL_ORDERS__Partner_Product_Catalog__c adminProductCatalog=new CHANNEL_ORDERS__Partner_Product_Catalog__c();
        adminProductCatalog.Name=System.label.Admin_Product_Label;
        adminProductCatalog.CHANNEL_ORDERS__Product_ID__c='Admin';
        adminProductCatalog.CHANNEL_ORDERS__Pricing_Type__c='Fixed';
        adminProductCatalog.CHANNEL_ORDERS__Fixed_Price__c=20000;
        adminProductCatalog.CHANNEL_ORDERS__Partner_Contract_Terms__c=contractTerm.Id;
        productCatalogList.add(adminProductCatalog);
        
        CHANNEL_ORDERS__Partner_Product_Catalog__c ManagerProductCatalog=new CHANNEL_ORDERS__Partner_Product_Catalog__c();
        ManagerProductCatalog.Name=System.label.Manager_Product_Label;
        ManagerProductCatalog.CHANNEL_ORDERS__Product_ID__c='Manager';
        ManagerProductCatalog.CHANNEL_ORDERS__Pricing_Type__c='Fixed';
        ManagerProductCatalog.CHANNEL_ORDERS__Fixed_Price__c=20000;
        ManagerProductCatalog.CHANNEL_ORDERS__Partner_Contract_Terms__c=contractTerm.Id;
        productCatalogList.add(ManagerProductCatalog);
        
        CHANNEL_ORDERS__Partner_Product_Catalog__c employeeProductCatalog=new CHANNEL_ORDERS__Partner_Product_Catalog__c();
        employeeProductCatalog.Name=System.label.Manager_Product_Label;
        employeeProductCatalog.CHANNEL_ORDERS__Product_ID__c='Employee';
        employeeProductCatalog.CHANNEL_ORDERS__Pricing_Type__c='Fixed';
        employeeProductCatalog.CHANNEL_ORDERS__Fixed_Price__c=20000;
        employeeProductCatalog.CHANNEL_ORDERS__Partner_Contract_Terms__c=contractTerm.Id;
        productCatalogList.add(employeeProductCatalog);
        
        insert productCatalogList;
        
        //create Product__c
        Product2 adminProduct=TestDataFactory.createProduct('Releco HR2 Admin');        
        Product2 managerProduct=TestDataFactory.createProduct('Releco HR1 Manager');
        Product2 employeeProduct=TestDataFactory.createProduct('Releco HR1 Employee');
        
              
        //create ServiceOrderDetail 1 record
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail1.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //serviceOrderDetail1.Product__c=adminProduct.Id;
        serviceOrderDetail1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderAddOn.Id;
        serviceOrderDetail1.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail1;
        
        
        //create ServiceOrderDetail 2 record
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail2 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail2.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail2.CHANNEL_ORDERS__Product_Name__c=ManagerProductCatalog.Id;
        //serviceOrderDetail2.Product__c=managerProduct.Id;
        serviceOrderDetail2.CHANNEL_ORDERS__Partner_Order__c=serviceOrderAddOn.Id;
        serviceOrderDetail2.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail2;
        
        //create ServiceOrderDetail 3 record
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail3 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail3.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail3.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //serviceOrderDetail3.Product__c=employeeProduct.Id;
        serviceOrderDetail3.CHANNEL_ORDERS__Partner_Order__c=serviceOrderAddOn.Id;
        serviceOrderDetail3.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail3; 
        
        //create ServiceOrderDetail 4 record
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail4 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail4.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail4.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //serviceOrderDetail4.Product__c=adminProduct.Id;
        serviceOrderDetail4.CHANNEL_ORDERS__Partner_Order__c=serviceOrderRedu.Id;
        serviceOrderDetail4.CHANNEL_ORDERS__Quantity__c=10;
        
        insert serviceOrderDetail4;
        
        
        //create ServiceOrderDetail 5 record
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail5 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail5.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail5.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //serviceOrderDetail5.Product__c=managerProduct.Id;
        serviceOrderDetail5.CHANNEL_ORDERS__Partner_Order__c=serviceOrderRedu.Id;
        serviceOrderDetail5.CHANNEL_ORDERS__Quantity__c=5;
        
        insert serviceOrderDetail5;
        
        //create ServiceOrderDetail 6 record
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail6 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail6.CHANNEL_ORDERS__pc_Partner_Contract_Term__c= contractTerm.Id;
        serviceOrderDetail6.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //serviceOrderDetail6.Product__c=employeeProduct.Id;
        serviceOrderDetail6.CHANNEL_ORDERS__Partner_Order__c=serviceOrderRedu.Id;
        serviceOrderDetail6.CHANNEL_ORDERS__Quantity__c=5;
        
        insert serviceOrderDetail6;
        
         // Create ServiceOrderRecord 3
        CHANNEL_ORDERS__Service_Order__c serviceOrderReduction=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderReduction.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderReduction.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderReduction.CHANNEL_ORDERS__Order_Type__c='Reduction';
        serviceOrderReduction.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderReduction.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderReduction.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderReduction;
        
        
        TestDataFactory.createServiceOrderDetail( contractTerm, adminProductCatalog, adminProduct, serviceOrderReduction);
        TestDataFactory.createServiceOrderDetail( contractTerm, managerProductCatalog, managerProduct, serviceOrderReduction);
        TestDataFactory.createServiceOrderDetail( contractTerm, employeeProductCatalog, employeeProduct, serviceOrderReduction);
        
        
        
        
        
        //Test for Provisioned And Add-on serviceOder
        
       /* CHANNEL_ORDERS__Service_Order__c ServiceOrderProvisionedAdd=new CHANNEL_ORDERS__Service_Order__c();
        ServiceOrderProvisionedAdd.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        ServiceOrderProvisionedAdd.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        ServiceOrderProvisionedAdd.CHANNEL_ORDERS__Order_Type__c='Reduction';
        ServiceOrderProvisionedAdd.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        ServiceOrderProvisionedAdd.CHANNEL_ORDERS__Customer__c=customer.Id;
        ServiceOrderProvisionedAdd.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert ServiceOrderProvisionedAdd;*/
    
    /*
        
        //
        CHANNEL_ORDERS__Service_Order__c soProAddOn= TestDataFactory.createServiceOrder(contractTerm,customer);
        
         TestDataFactory.createServiceOrderDetail( contractTerm, adminProductCatalog, adminProduct, soProAddOn);
        TestDataFactory.createServiceOrderDetail( contractTerm, ManagerProductCatalog, managerProduct, soProAddOn);
        TestDataFactory.createServiceOrderDetail( contractTerm, employeeProductCatalog, employeeProduct, soProAddOn);
        
         //Test for Provisioned And Initial serviceOder
         /*CHANNEL_ORDERS__Service_Order__c ServiceOrderProvisionedInitial=new CHANNEL_ORDERS__Service_Order__c();
        ServiceOrderProvisionedInitial.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        ServiceOrderProvisionedInitial.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        ServiceOrderProvisionedInitial.CHANNEL_ORDERS__Order_Type__c='Reduction';
        ServiceOrderProvisionedInitial.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        ServiceOrderProvisionedInitial.CHANNEL_ORDERS__Customer__c=customer.Id;
        ServiceOrderProvisionedInitial.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert ServiceOrderProvisionedInitial;*/

   /*     CHANNEL_ORDERS__Service_Order__c soProInitial= TestDataFactory.createServiceOrder(contractTerm,customer);
        
         TestDataFactory.createServiceOrderDetail( contractTerm, adminProductCatalog, adminProduct, soProInitial);
        TestDataFactory.createServiceOrderDetail( contractTerm, managerProductCatalog, managerProduct, soProInitial);
        TestDataFactory.createServiceOrderDetail( contractTerm, employeeProductCatalog, employeeProduct, soProInitial);
        
        //Test for Activated And Reduction serviceOder
      CHANNEL_ORDERS__Service_Order__c ServiceOrderActivateReduction=new CHANNEL_ORDERS__Service_Order__c();
        ServiceOrderActivateReduction.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        ServiceOrderActivateReduction.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        ServiceOrderActivateReduction.CHANNEL_ORDERS__Order_Type__c='Reduction';
        ServiceOrderActivateReduction.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        ServiceOrderActivateReduction.CHANNEL_ORDERS__Customer__c=customer.Id;
        ServiceOrderActivateReduction.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert ServiceOrderActivateReduction;
        //
        CHANNEL_ORDERS__Service_Order__c soActiReduction= TestDataFactory.createServiceOrder(contractTerm,customer);
        
         TestDataFactory.createServiceOrderDetail( contractTerm, adminProductCatalog, adminProduct, ServiceOrderActivateReduction);
        TestDataFactory.createServiceOrderDetail( contractTerm, managerProductCatalog, managerProduct, ServiceOrderActivateReduction);
        TestDataFactory.createServiceOrderDetail( contractTerm, employeeProductCatalog, employeeProduct, ServiceOrderActivateReduction);
        
      //  //Test for Draft And Initial serviceOder
         CHANNEL_ORDERS__Service_Order__c ServiceOrderDraftInitial=new CHANNEL_ORDERS__Service_Order__c();
        ServiceOrderDraftInitial.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        ServiceOrderDraftInitial.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        ServiceOrderDraftInitial.CHANNEL_ORDERS__Order_Type__c='Initial';
        ServiceOrderDraftInitial.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        ServiceOrderDraftInitial.CHANNEL_ORDERS__Customer__c=customer.Id;
        ServiceOrderDraftInitial.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert ServiceOrderDraftInitial;
        CHANNEL_ORDERS__Service_Order__c soDraftInitial=TestDataFactory.createServiceOrder(contractTerm,customer);
        
         TestDataFactory.createServiceOrderDetail( contractTerm, adminProductCatalog, adminProduct, ServiceOrderDraftInitial);
        TestDataFactory.createServiceOrderDetail( contractTerm, managerProductCatalog, managerProduct, ServiceOrderDraftInitial);
        TestDataFactory.createServiceOrderDetail( contractTerm, employeeProductCatalog, employeeProduct, ServiceOrderDraftInitial);
        
        //create Activated and Cancellation serviceOrder
        
      CHANNEL_ORDERS__Service_Order__c ServiceOrderActivateCancellation=new CHANNEL_ORDERS__Service_Order__c();
        ServiceOrderActivateCancellation.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        ServiceOrderActivateCancellation.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        ServiceOrderActivateCancellation.CHANNEL_ORDERS__Order_Type__c='Initial';
        ServiceOrderActivateCancellation.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        ServiceOrderActivateCancellation.CHANNEL_ORDERS__Customer__c=customer.Id;
        ServiceOrderActivateCancellation.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert ServiceOrderActivateCancellation;
        CHANNEL_ORDERS__Service_Order__c soActivateCancellation=TestDataFactory.createServiceOrder(contractTerm,customer);
        
         TestDataFactory.createServiceOrderDetail( contractTerm, adminProductCatalog, adminProduct, ServiceOrderActivateCancellation);
        TestDataFactory.createServiceOrderDetail( contractTerm, managerProductCatalog, managerProduct, ServiceOrderActivateCancellation);
        TestDataFactory.createServiceOrderDetail( contractTerm, employeeProductCatalog, employeeProduct, ServiceOrderActivateCancellation);
      
   
    }
    
    @isTest
    private static void serviceOrderAddOnTest(){
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderAddOnList=[Select Id,Name,CHANNEL_ORDERS__Customer__c
                                                                      From CHANNEL_ORDERS__Service_Order__c
                                                                      where CHANNEL_ORDERS__Service_Order_Status__c='Draft' AND
                                                                      CHANNEL_ORDERS__Order_Type__c='Add-on'];
        
        for(CHANNEL_ORDERS__Service_Order__c serviceOrderAddOn:serviceOrderAddOnList){
            serviceOrderAddOn.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
            serviceOrderAddOn.CHANNEL_ORDERS__Order_Type__c='Add-on';
        }
        
        test.startTest();
        Update  serviceOrderAddOnList;   
        test.stopTest();
        
    }
    
    @isTest
    private static void serviceOrderReductionTest(){
        
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderReduList=[Select Id,Name,CHANNEL_ORDERS__Customer__c
                                                                     From CHANNEL_ORDERS__Service_Order__c
                                                                     where CHANNEL_ORDERS__Service_Order_Status__c='Draft' AND
                                                                     CHANNEL_ORDERS__Order_Type__c='Reduction'];
        
        System.assertEquals('Draft', serviceOrderReduList[0].CHANNEL_ORDERS__Service_Order_Status__c);
        
        for(CHANNEL_ORDERS__Service_Order__c so:serviceOrderReduList){
            so.CHANNEL_ORDERS__Service_Order_Status__c='Provisioned';
            so.CHANNEL_ORDERS__Order_Type__c='Reduction';
        }
        
        
        
        test.startTest();
        Update  serviceOrderReduList;  
        test.stopTest();
    }
    // Test for Provisioned And Add-on serviceOder
     @isTest
    private static void serviceOrderProAddOnTest(){
        
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderProAddOnList=[Select Id,Name,CHANNEL_ORDERS__Customer__c
                                                                     From CHANNEL_ORDERS__Service_Order__c
                                                                     where CHANNEL_ORDERS__Service_Order_Status__c='Draft' AND
                                                                     CHANNEL_ORDERS__Order_Type__c='Add-on'];
        
        for(CHANNEL_ORDERS__Service_Order__c proAdd:serviceOrderProAddOnList){
            proAdd.CHANNEL_ORDERS__Service_Order_Status__c='Provisioned';
            proAdd.CHANNEL_ORDERS__Order_Type__c='Add-on';
        }
        
        test.startTest();
        Update  serviceOrderProAddOnList;  
        test.stopTest();
    }
   // Test for Provisioned And Initial serviceOder
     @isTest
    private static void serviceOrderProInitialTest(){
        
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderProInitialList=[Select Id,Name,CHANNEL_ORDERS__Customer__c
                                                                     From CHANNEL_ORDERS__Service_Order__c
                                                                     where CHANNEL_ORDERS__Service_Order_Status__c='Draft' AND
                                                                     CHANNEL_ORDERS__Order_Type__c='Add-on'];
        
        for(CHANNEL_ORDERS__Service_Order__c proInitial:serviceOrderProInitialList){
            proInitial.CHANNEL_ORDERS__Service_Order_Status__c='Provisioned';
            proInitial.CHANNEL_ORDERS__Order_Type__c='Initial';
        }
        
        test.startTest();
        Update  serviceOrderProInitialList;  
        test.stopTest();
    }
      // Test for Activated And Reduction serviceOder
     @isTest
    private static void serviceOrderActiReductionTest(){
        
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderActiReductionList=[Select Id,Name,CHANNEL_ORDERS__Customer__c
                                                                     From CHANNEL_ORDERS__Service_Order__c
                                                                     where CHANNEL_ORDERS__Service_Order_Status__c='Draft' AND
                                                                     CHANNEL_ORDERS__Order_Type__c='Add-on'];
        
        for(CHANNEL_ORDERS__Service_Order__c ActiReduction :serviceOrderActiReductionList){
            ActiReduction.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
            ActiReduction.CHANNEL_ORDERS__Order_Type__c='Reduction';
        }
        
        test.startTest();
        Update  serviceOrderActiReductionList;  
        test.stopTest();
    }
   
 @isTest
    private static void serviceOrderActivatedCancellationTest(){
        
        List<CHANNEL_ORDERS__Service_Order__c> serviceOrderActivateCancellationList=[Select Id, Name,CHANNEL_ORDERS__Customer__c
                                                                      From CHANNEL_ORDERS__Service_Order__c
                                                                      where CHANNEL_ORDERS__Service_Order_Status__c='Draft' AND
                                                                      CHANNEL_ORDERS__Order_Type__c='Add-on'];
        
        for(CHANNEL_ORDERS__Service_Order__c serviceOrderActivateCancellation:serviceOrderActivateCancellationList){
            serviceOrderActivateCancellation.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
            serviceOrderActivateCancellation.CHANNEL_ORDERS__Order_Type__c='Cancellation Order';
        }
        
        test.startTest();
        update  serviceOrderActivateCancellationList;   
        test.stopTest();
        
    }    
    
    */
    
    ////New test Method
    
    @isTest
    public static void ServiceOrderTriggerMethod(){
        //create Customer
        
        CHANNEL_ORDERS__Customer__c customer=new CHANNEL_ORDERS__Customer__c();
        customer.CHANNEL_ORDERS__Customer_Company_Name__c='SpancoSoftwareSolution.com';
        customer.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution.com';
        customer.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer.CHANNEL_ORDERS__Customer_Country__c='India';
        customer.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
        
        insert customer;
        
        // Create  Partner Contract Term1
        
        CHANNEL_ORDERS__Partner_Contract_Terms__c contractTerm=new CHANNEL_ORDERS__Partner_Contract_Terms__c();
        contractTerm.Name='SpancoSoftwareSolution';
        contractTerm.CHANNEL_ORDERS__Partner_API_Key__c='SpancoSoftwareSolution';
        
        insert contractTerm;
        
        List<CHANNEL_ORDERS__Partner_Product_Catalog__c> productCatalogList=new List<CHANNEL_ORDERS__Partner_Product_Catalog__c>();
        
        CHANNEL_ORDERS__Partner_Product_Catalog__c adminProductCatalog=new CHANNEL_ORDERS__Partner_Product_Catalog__c();
        adminProductCatalog.Name=System.label.Admin_Product_Label;
        adminProductCatalog.CHANNEL_ORDERS__Product_ID__c='Admin';
        adminProductCatalog.CHANNEL_ORDERS__Pricing_Type__c='Fixed';
        adminProductCatalog.CHANNEL_ORDERS__Fixed_Price__c=20000;
        adminProductCatalog.CHANNEL_ORDERS__Partner_Contract_Terms__c=contractTerm.Id;
        productCatalogList.add(adminProductCatalog);
        
        CHANNEL_ORDERS__Partner_Product_Catalog__c ManagerProductCatalog=new CHANNEL_ORDERS__Partner_Product_Catalog__c();
        ManagerProductCatalog.Name=System.label.Manager_Product_Label;
        ManagerProductCatalog.CHANNEL_ORDERS__Product_ID__c='Manager';
        ManagerProductCatalog.CHANNEL_ORDERS__Pricing_Type__c='Fixed';
        ManagerProductCatalog.CHANNEL_ORDERS__Fixed_Price__c=20000;
        ManagerProductCatalog.CHANNEL_ORDERS__Partner_Contract_Terms__c=contractTerm.Id;
        productCatalogList.add(ManagerProductCatalog);
        
        CHANNEL_ORDERS__Partner_Product_Catalog__c employeeProductCatalog=new CHANNEL_ORDERS__Partner_Product_Catalog__c();
        employeeProductCatalog.Name=System.label.Employee_Product_Label;
        employeeProductCatalog.CHANNEL_ORDERS__Product_ID__c='Employee';
        employeeProductCatalog.CHANNEL_ORDERS__Pricing_Type__c='Fixed';
        employeeProductCatalog.CHANNEL_ORDERS__Fixed_Price__c=20000;
        employeeProductCatalog.CHANNEL_ORDERS__Partner_Contract_Terms__c=contractTerm.Id;
        productCatalogList.add(employeeProductCatalog);
        
        insert productCatalogList;
        
        // Create ServiceOrderRecord initial
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderInitial=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderInitial.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderInitial.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderInitial.CHANNEL_ORDERS__Order_Type__c='Initial';
        serviceOrderInitial.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderInitial.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderInitial.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderInitial;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  adminServiceOrderDetailInitial =new CHANNEL_ORDERS__Service_Order_Detail__c();
        adminServiceOrderDetailInitial.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        adminServiceOrderDetailInitial.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //adminServiceOrderDetailInitial.Product__c=adminProduct.Id;
        adminServiceOrderDetailInitial.CHANNEL_ORDERS__Partner_Order__c=serviceOrderInitial.Id;
        adminServiceOrderDetailInitial.CHANNEL_ORDERS__Quantity__c=20;
        
        insert adminServiceOrderDetailInitial;
        
        
        CHANNEL_ORDERS__Service_Order_Detail__c  managerServiceOrderDetailInitial =new CHANNEL_ORDERS__Service_Order_Detail__c();
        managerServiceOrderDetailInitial.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        managerServiceOrderDetailInitial.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //managerServiceOrderDetailInitial.Product__c=adminProduct.Id;
        managerServiceOrderDetailInitial.CHANNEL_ORDERS__Partner_Order__c=serviceOrderInitial.Id;
        managerServiceOrderDetailInitial.CHANNEL_ORDERS__Quantity__c=20;
        
        insert managerServiceOrderDetailInitial;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  employeeServiceOrderDetailInitial =new CHANNEL_ORDERS__Service_Order_Detail__c();
        employeeServiceOrderDetailInitial.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        employeeServiceOrderDetailInitial.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //employeeServiceOrderDetailInitial.Product__c=adminProduct.Id;
        employeeServiceOrderDetailInitial.CHANNEL_ORDERS__Partner_Order__c=serviceOrderInitial.Id;
        employeeServiceOrderDetailInitial.CHANNEL_ORDERS__Quantity__c=20;
        
        insert employeeServiceOrderDetailInitial;
        
        serviceOrderInitial.CHANNEL_ORDERS__Service_Order_Status__c='Provisioned';
        
        update serviceOrderInitial;
        
        
        // Create ServiceOrderRecord for addOn
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderAddOn=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderAddOn.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderAddOn.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderAddOn.CHANNEL_ORDERS__Order_Type__c='Add-on';
        serviceOrderAddOn.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderAddOn.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderAddOn.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderAddOn;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail1.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //serviceOrderDetail1.Product__c=adminProduct.Id;
        serviceOrderDetail1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderAddOn.Id;
        serviceOrderDetail1.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail1;
        
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail2 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail2.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail2.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //serviceOrderDetail1.Product__c=adminProduct.Id;
        serviceOrderDetail2.CHANNEL_ORDERS__Partner_Order__c=serviceOrderAddOn.Id;
        serviceOrderDetail2.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail2;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  serviceOrderDetail3 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        serviceOrderDetail3.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        serviceOrderDetail3.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //serviceOrderDetail1.Product__c=adminProduct.Id;
        serviceOrderDetail3.CHANNEL_ORDERS__Partner_Order__c=serviceOrderAddOn.Id;
        serviceOrderDetail3.CHANNEL_ORDERS__Quantity__c=20;
        
        insert serviceOrderDetail3;
        
        serviceOrderAddOn.CHANNEL_ORDERS__Service_Order_Status__c='Provisioned';
        
        update serviceOrderAddOn;
        
       
        
     
        // Create  ServiceOrder Record for reduction 
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderReduction=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderReduction.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderReduction.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderReduction.CHANNEL_ORDERS__Order_Type__c='Reduction';
        serviceOrderReduction.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderReduction.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderReduction.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderReduction;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  adminServiceOrderDetailReduction =new CHANNEL_ORDERS__Service_Order_Detail__c();
        adminServiceOrderDetailReduction.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        adminServiceOrderDetailReduction.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //adminServiceOrderDetailReduction.Product__c=adminProduct.Id;
        adminServiceOrderDetailReduction.CHANNEL_ORDERS__Partner_Order__c=serviceOrderReduction.Id;
        adminServiceOrderDetailReduction.CHANNEL_ORDERS__Quantity__c=5;
        
        insert adminServiceOrderDetailReduction;
        
        
        CHANNEL_ORDERS__Service_Order_Detail__c  managerServiceOrderDetailReduction =new CHANNEL_ORDERS__Service_Order_Detail__c();
        managerServiceOrderDetailReduction.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        managerServiceOrderDetailReduction.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //managerserviceOrderDetailReduction.Product__c=adminProduct.Id;
        managerServiceOrderDetailReduction.CHANNEL_ORDERS__Partner_Order__c=serviceOrderReduction.Id;
        managerServiceOrderDetailReduction.CHANNEL_ORDERS__Quantity__c=5;
        
        insert managerserviceOrderDetailReduction;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  employeeServiceOrderDetailReduction =new CHANNEL_ORDERS__Service_Order_Detail__c();
        employeeServiceOrderDetailReduction.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        employeeServiceOrderDetailReduction.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //employeeServiceOrderDetailReduction.Product__c=adminProduct.Id;
        employeeServiceOrderDetailReduction.CHANNEL_ORDERS__Partner_Order__c=serviceOrderReduction.Id;
        employeeServiceOrderDetailReduction.CHANNEL_ORDERS__Quantity__c=5;
        
        insert employeeServiceOrderDetailReduction;
        
        serviceOrderReduction.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
        update serviceOrderReduction;
           
        
        // Create  ServiceOrder Record for cancellation 
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderCancellation=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderCancellation.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderCancellation.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderCancellation.CHANNEL_ORDERS__Order_Type__c='Cancellation Order';
        serviceOrderCancellation.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderCancellation.CHANNEL_ORDERS__Customer__c=customer.Id;
        serviceOrderCancellation.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderCancellation;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  adminServiceOrderDetailCancellation =new CHANNEL_ORDERS__Service_Order_Detail__c();
        adminServiceOrderDetailCancellation.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        adminServiceOrderDetailCancellation.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //adminServiceOrderDetailCancellation.Product__c=adminProduct.Id;
        adminServiceOrderDetailCancellation.CHANNEL_ORDERS__Partner_Order__c=serviceOrderCancellation.Id;
        adminServiceOrderDetailCancellation.CHANNEL_ORDERS__Quantity__c=5;
        
        insert adminServiceOrderDetailCancellation;
        
        
        CHANNEL_ORDERS__Service_Order_Detail__c  managerServiceOrderDetailCancellation =new CHANNEL_ORDERS__Service_Order_Detail__c();
        managerServiceOrderDetailCancellation.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        managerServiceOrderDetailCancellation.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //managerServiceOrderDetailCancellation.Product__c=adminProduct.Id;
        managerServiceOrderDetailCancellation.CHANNEL_ORDERS__Partner_Order__c=serviceOrderCancellation.Id;
        managerServiceOrderDetailCancellation.CHANNEL_ORDERS__Quantity__c=5;
        
        insert managerServiceOrderDetailCancellation;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  employeeServiceOrderDetailCancellation =new CHANNEL_ORDERS__Service_Order_Detail__c();
        employeeServiceOrderDetailCancellation.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        employeeServiceOrderDetailCancellation.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //employeeServiceOrderDetailCancellation.Product__c=adminProduct.Id;
        employeeServiceOrderDetailCancellation.CHANNEL_ORDERS__Partner_Order__c=serviceOrderCancellation.Id;
        employeeServiceOrderDetailCancellation.CHANNEL_ORDERS__Quantity__c=5;
        
        insert employeeServiceOrderDetailCancellation;
        
        serviceOrderCancellation.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
        update serviceOrderCancellation;
        
        
		//create Customer
        
        CHANNEL_ORDERS__Customer__c customer1=new CHANNEL_ORDERS__Customer__c();
        customer1.CHANNEL_ORDERS__Customer_Company_Name__c='Sample.com';
        customer1.CHANNEL_ORDERS__Customer_Org_ID__c='Sample.com';
        customer1.CHANNEL_ORDERS__Customer_Street__c='Nagpur';
        customer1.CHANNEL_ORDERS__Customer_State__c='Maharashtra';
        customer1.CHANNEL_ORDERS__Customer_ZIP_Postal_Code__c='440034';
        customer1.CHANNEL_ORDERS__Customer_Country__c='India';
        customer1.CHANNEL_ORDERS__Customer_City__c='Nagpur';
        
        
        insert customer1;
	
        
        // Create 2nd ServiceOrder Record for reduction 
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderReduction1=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderReduction1.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderReduction1.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderReduction1.CHANNEL_ORDERS__Order_Type__c='Reduction';
        serviceOrderReduction1.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderReduction1.CHANNEL_ORDERS__Customer__c=customer1.Id;
        serviceOrderReduction1.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderReduction1;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  adminServiceOrderDetailReduction1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        adminServiceOrderDetailReduction1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        adminServiceOrderDetailReduction1.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //adminServiceOrderDetailReduction1.Product__c=adminProduct.Id;
        adminServiceOrderDetailReduction1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderReduction1.Id;
        adminServiceOrderDetailReduction1.CHANNEL_ORDERS__Quantity__c=5;
        
        insert adminServiceOrderDetailReduction1;
        
        
        CHANNEL_ORDERS__Service_Order_Detail__c  managerServiceOrderDetailReduction1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        managerServiceOrderDetailReduction1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        managerServiceOrderDetailReduction1.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //managerServiceOrderDetailReduction1.Product__c=adminProduct.Id;
        managerServiceOrderDetailReduction1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderReduction1.Id;
        managerServiceOrderDetailReduction1.CHANNEL_ORDERS__Quantity__c=5;
        
        insert managerServiceOrderDetailReduction1;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  employeeServiceOrderDetailReduction1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        employeeServiceOrderDetailReduction1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        employeeServiceOrderDetailReduction1.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //employeeServiceOrderDetailReduction1.Product__c=adminProduct.Id;
        employeeServiceOrderDetailReduction1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderReduction1.Id;
        employeeServiceOrderDetailReduction1.CHANNEL_ORDERS__Quantity__c=5;
        
        insert employeeServiceOrderDetailReduction1;
        
        serviceOrderReduction1.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
        update serviceOrderReduction;
           
        
        // Create 3rd ServiceOrder Record for cancellation 
        
        CHANNEL_ORDERS__Service_Order__c serviceOrderCancellation1=new CHANNEL_ORDERS__Service_Order__c();
        serviceOrderCancellation1.CHANNEL_ORDERS__Customer_Org_ID__c='SpancoSoftwareSolution';
        serviceOrderCancellation1.CHANNEL_ORDERS__Service_Order_Status__c='Draft';
        serviceOrderCancellation1.CHANNEL_ORDERS__Order_Type__c='Cancellation Order';
        serviceOrderCancellation1.CHANNEL_ORDERS__Partner_Contract_Rules__c=contractTerm.Id;
        serviceOrderCancellation1.CHANNEL_ORDERS__Customer__c=customer1.Id;
        serviceOrderCancellation1.CHANNEL_ORDERS__Service_Start_Date__c=system.today(); 
        
        insert serviceOrderCancellation1;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  adminServiceOrderDetailCancellation1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        adminServiceOrderDetailCancellation1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        adminServiceOrderDetailCancellation1.CHANNEL_ORDERS__Product_Name__c=adminProductCatalog.Id;
        //adminServiceOrderDetailCancellation1.Product__c=adminProduct.Id;
        adminServiceOrderDetailCancellation1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderCancellation1.Id;
        adminServiceOrderDetailCancellation1.CHANNEL_ORDERS__Quantity__c=5;
        
        insert adminServiceOrderDetailCancellation1;
        
        
        CHANNEL_ORDERS__Service_Order_Detail__c  managerServiceOrderDetailCancellation1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        managerServiceOrderDetailCancellation1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        managerServiceOrderDetailCancellation1.CHANNEL_ORDERS__Product_Name__c=managerProductCatalog.Id;
        //managerServiceOrderDetailCancellation1.Product__c=adminProduct.Id;
        managerServiceOrderDetailCancellation1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderCancellation1.Id;
        managerServiceOrderDetailCancellation1.CHANNEL_ORDERS__Quantity__c=5;
        
        insert managerServiceOrderDetailCancellation1;
        
        CHANNEL_ORDERS__Service_Order_Detail__c  employeeServiceOrderDetailCancellation1 =new CHANNEL_ORDERS__Service_Order_Detail__c();
        employeeServiceOrderDetailCancellation1.CHANNEL_ORDERS__pc_Partner_Contract_Term__c=contractTerm.Id;
        employeeServiceOrderDetailCancellation1.CHANNEL_ORDERS__Product_Name__c=employeeProductCatalog.Id;
        //employeeServiceOrderDetailCancellation1.Product__c=adminProduct.Id;
        employeeServiceOrderDetailCancellation1.CHANNEL_ORDERS__Partner_Order__c=serviceOrderCancellation1.Id;
        employeeServiceOrderDetailCancellation1.CHANNEL_ORDERS__Quantity__c=5;
        
        insert employeeServiceOrderDetailCancellation1;
        
        serviceOrderCancellation1.CHANNEL_ORDERS__Service_Order_Status__c='Activated';
		Test.startTest();
        update serviceOrderCancellation1;
        Test.stopTest();
        
        
        
    }
    
}