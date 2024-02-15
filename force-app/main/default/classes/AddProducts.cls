public class AddProducts {
    public List<OpportunityLineItems__c> pro{get; set;}
    public Opportunitiescustom__c oppc{get; set;}
    public String oppId {get; set;}
    public AddProducts(){
        oppc = new Opportunitiescustom__c();
        pro = new List<OpportunityLineItems__c>();
        oppc.Id=ApexPages.currentPage().getParameters().get('id');
        
    }
    public PageReference saveProducts() {
        if (oppc != null) {
        for (OpportunityLineItems__c p : pro) {
            p.Opportunity_Name__c = oppc.Id;
        }
        }
        if (!pro.isEmpty()) {
        insert pro;
        }
        PageReference pf = new PageReference('/'+oppc.Id);
        return pf;
    }
    public void addProducts() {
        pro.add(new OpportunityLineItems__c());
    }    
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+oppc.Id);
        return pf;
    }
}