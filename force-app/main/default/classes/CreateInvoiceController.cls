public class CreateInvoiceController {
    
    public Invoice__c i{get; set;}
    public list<SalesorderLineProduct__c> slpLi{get;set;}
    public List<InvoiceLineProduct__c> invoiceLineItems { get; set; }
    //public Integer myvar { get; set; }
    public Salesorder__c s{get;set;}
    //public InvoiceLineProduct__c ilp{get; set;}
    //public String sId{get; set;}
    public integer index{get; set;}
    
    
    public CreateInvoiceController() {
        s = new Salesorder__c();
        slpLi=new list<SalesorderLineProduct__c>();
        i = new Invoice__c();
        //ilp = new List<InvoiceLineProduct__c>();
        invoiceLineItems = new List<InvoiceLineProduct__c>();
        String sId=ApexPages.currentPage().getParameters().get('id');
        s.id = sId;
        s=[select id, name, Account__c,Contact__c, Quote__c, Opportunity__c,Valid_Till__c,Warranty__c,
              Remarks__c, Payment_terms__c,Delivery_Lead_Time__c from Salesorder__c where Id= :s.Id];
        slpLi = [
            SELECT Id, Name, Discount_Type__c,Discount_Value__c,Account_Name__c,Quote_Name__c, Invoiced_Quantity__c,Bal_Quantity__c,Balanced_Quantity__c, Quantity__c, Actual_Price__c, 
            Unit_Price__c, Opportunity_Name__c, Product__r.Product_Name__c, Total_Price__c,SalesorderLineProduct__c.Salesorder_Name__c, CGST__c,IGST__c,SGST__c
            FROM SalesorderLineProduct__c
            WHERE Salesorder_Name__c = :s.Id AND Balanced_Quantity__c!= 0
        ];
         
        for(SalesorderLineProduct__c ss: slpLi){
            ss.Bal_Quantity__c = ss.Balanced_Quantity__c;
        }

    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+s.Id);
        return pf;
    }
    public PageReference save() {
        i.Salesorder__c= s.id;
        i.Account__c=s.Account__c;
        i.Contact__c= s.Contact__c;
        i.Quote__c=s.Quote__c;
        i.Opportunity__c= s.Opportunity__c;
        i.Payment_terms__c= s.Payment_terms__c;
        i.Warranty__c= s.Warranty__c;
        i.Remarks__c= s.Remarks__c;
        i.Delivery_Lead_Time__c= s.Delivery_Lead_Time__c;

        insert i;
        
        for(SalesorderLineProduct__c cc: slpLi)
        {
            //cc.Invoiced_Quantity__c=cc.Bal_Quantity__c;
            InvoiceLineProduct__c ilp = new InvoiceLineProduct__c();
            ilp.Sales_orderline_item__c= cc.Id;
            ilp.Account_Name__c= cc.Account_Name__c;
            ilp.Opportunity_Name__c= cc.Opportunity_Name__c;
            ilp.Quote_Name__c= cc.Quote_Name__c;
            ilp.Sales_order_Name__c = cc.Salesorder_Name__c;
            ilp.Invoice_Name__c = i.id;
            ilp.Actual_Price__c= cc.Actual_Price__c;
            ilp.CGST__c= cc.CGST__c;
            ilp.IGST__c= cc.IGST__c;
            ilp.SGST__c= cc.SGST__c;
            ilp.Discount_Type__c= cc.Discount_Type__c;
            ilp.Discount_Value__c= cc.Discount_Value__c;
            ilp.Product_Description__c= ilp.Product_Description__c;
            ilp.Quantity__c= cc.Bal_Quantity__c;
            ilp.Unit_Price__c = cc.Unit_Price__c;
            ilp.Product__c = cc.Product__c;
            
            invoiceLineItems.add(ilp);
        }
        
        insert invoiceLineItems;
        PageReference pf = new PageReference('/'+s.Id);
        return pf;
    }
    public void del(){
        slpLi.remove(index-1);    
    }
        
}