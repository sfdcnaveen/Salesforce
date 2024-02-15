public class EditAllOpportunityLineItemsController {

    public Integer myvar { get; set; }
    public Opportunitiescustom__c oppc{get; set;}
    public List<OpportunityLineItems__c> relatedOppLi { get; set; }
    public Integer num{get; set;}
    public String oppId { get; set; }
    public integer index{get; set;}
    
    public EditAllOpportunityLineItemsController() {
        oppc = new Opportunitiescustom__c();
        relatedOppLi = new List<OpportunityLineItems__c>();
        oppc.Id = ApexPages.currentPage().getParameters().get('id');
        relatedOppLi = [
            SELECT Id, Name, Discount_Type__c,Discount_Value__c, Quantity__c, Actual_Price__c, Unit_Price__c, Opportunity_Name__r.Name
            FROM OpportunityLineItems__c
            WHERE Opportunity_Name__c = :oppc.Id
        ];
    }
    public PageReference updateOppLi(){
        update relatedOppLi;
        PageReference pf = new PageReference('/'+oppc.Id);
        return pf;
    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+oppc.Id);
        return pf;
    }
    public PageReference del(){
        delete relatedOppLi[index];
        PageReference pf=new PageReference('/apex/EditAllOpportunityLineItems?id=' + oppc.Id);
        pf.setRedirect(True);
        return pf;        
    }

}