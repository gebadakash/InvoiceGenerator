public class BillingWrapper {
    
      public CHANNEL_ORDERS__Customer__c customer;
      public List<CHANNEL_ORDERS__Service_Order__c> serviceOrderPartialWrapper;
      public List<CHANNEL_ORDERS__Service_Order__c> serviceOrderFullWrapper;
      public Decimal TotalBilling;
        
     public BillingWrapper(){
        this.customer=new CHANNEL_ORDERS__Customer__c();
        this.serviceOrderPartialWrapper=new List<CHANNEL_ORDERS__Service_Order__c>();
         this.serviceOrderFullWrapper=new List<CHANNEL_ORDERS__Service_Order__c>();
        this.TotalBilling=0.0;  
       
          
    }
      public BillingWrapper (CHANNEL_ORDERS__Customer__c customer,List<CHANNEL_ORDERS__Service_Order__c> serviceOrderPartialWrapper,List<CHANNEL_ORDERS__Service_Order__c>serviceOrderFullWrapper,Decimal TotalBilling){
            this.customer=customer;
            this.serviceOrderPartialWrapper=serviceOrderPartialWrapper;
            this.serviceOrderFullWrapper=serviceOrderFullWrapper;
            this.TotalBilling=TotalBilling;
       
        }
    
}