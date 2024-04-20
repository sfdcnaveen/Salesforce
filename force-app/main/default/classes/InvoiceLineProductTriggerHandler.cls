public class InvoiceLineProductTriggerHandler {
    public static void handleBalancedquantity(list<InvoiceLineProduct__c> invlist){
        list<SalesorderLineProduct__c> updsales= new list<SalesorderLineProduct__c>();
        
        list<id> salesupdate= new list<id>();
        for(InvoiceLineProduct__c aa: invlist){
            if(aa.Sales_orderline_item__c!= null){
                salesupdate.add(aa.Sales_orderline_item__c);
            }
        }
        for(SalesorderLineProduct__c ss: [select id,Invoiced_Quantity__c from SalesorderLineProduct__c where Id IN :salesupdate]){
            decimal quantity= 0;
              for(InvoiceLineProduct__c ic: [select id, Quantity__c from InvoiceLineProduct__c where Sales_orderline_item__c = :ss.id]){
                 quantity= quantity + ic.Quantity__c; 
           }
            ss.Invoiced_Quantity__c = quantity;
            updsales.add(ss);
       }
        update updsales;
    }      
}