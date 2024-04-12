public class MultipleProductsController {
    public List<SalesorderLineProduct__c> slp{get; set;}
    public Salesorder__c sc{get; set;}
    public String scId {get; set;}
    public MultipleProductsController(){
        sc = new Salesorder__c();
        slp = new List<SalesorderLineProduct__c>();
        sc.Id=ApexPages.currentPage().getParameters().get('id');
        
    }
    public PageReference saveProducts() {
        if (sc != null) {
        for (SalesorderLineProduct__c p : slp) {
            p.Salesorder_Name__c = sc.Id;
        }
        }
        if (!slp.isEmpty()) {
        insert slp;
        }
        PageReference pf = new PageReference('/'+sc.Id);
        return pf;
    }
    public void addProducts() {
        slp.add(new SalesorderLineProduct__c());
    }    
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+sc.Id);
        return pf;
    }
}