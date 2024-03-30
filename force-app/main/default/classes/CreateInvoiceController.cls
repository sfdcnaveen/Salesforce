public class CreateInvoiceController {
    
    public list<SalesorderLineProduct__c> lislip{get;set;}
    public Salesorder__c s{get;set;}
    public List<InvoiceLineProduct__c> invoiceLineItems { get; set; }
    public InvoiceLineProduct__c ilip{get; set;}
    public Invoice__c i{get; set;}
    public String sId{get; set;}
    
    public CreateInvoiceController() {
        s = new Salesorder__c();
        i = new Invoice__c();
        lislip=new list<SalesorderLineProduct__c>();
        ilip = new InvoiceLineProduct__c();
        invoiceLineItems = new List<InvoiceLineProduct__c>();
        sId=ApexPages.currentPage().getParameters().get('id');
        
        lislip = [
            SELECT Id, Name, Discount_Type__c,Discount_Value__c, Quantity__c, Actual_Price__c, Unit_Price__c, Opportunity_Name__c, Product__c, Total_Price__c,SalesorderLineProduct__c.Salesorder_Name__c
            FROM SalesorderLineProduct__c
            WHERE Salesorder_Name__c = :sId
        ];
        s = [SELECT Name,Account__c, Contact__c, Account__r.Name, Contact__r.Name
                           FROM Salesorder__c WHERE Salesorder__c.id = :sId LIMIT 1];
    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+sId);
        return pf;
    }
    public PageReference save() {
        i.Salesorder__c= s.id;
        i.Account__c=s.Account__r.id;
        i.Contact__c= s.Contact__r.id;
        insert i;
        for(SalesorderLineProduct__c cc: lislip)
        {
            ilip = new InvoiceLineProduct__c();
            ilip.Invoice_Name__c = i.id;
            ilip.Sales_order_Name__c = cc.Salesorder_Name__c;
            ilip.Product__c = cc.Product__c;
            ilip.Quantity__c = cc.Quantity__c;
            ilip.Unit_Price__c = cc.Unit_Price__c;
            invoiceLineItems.add(ilip);
        }
        upsert ilip;
        PageReference pf = new PageReference('/'+sId);
        return pf;
    }
        
}