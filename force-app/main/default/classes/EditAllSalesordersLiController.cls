public class EditAllSalesordersLiController {
    public Integer myvar { get; set; }
    public Opportunitiescustom__c oppc{get; set;}
    public List<SalesorderLineProduct__c> relatedSalesorderLi { get; set; }
    public Integer num{get; set;}
    public String oppId { get; set; }
    public integer index{get; set;}
    
    public EditAllSalesordersLiController() {
        oppc = new Opportunitiescustom__c();
        relatedSalesorderLi = new List<SalesorderLineProduct__c>();
        oppc.Id = ApexPages.currentPage().getParameters().get('id');
        relatedSalesorderLi = [
            SELECT Id,SalesorderLineProduct__c.Name, Account_Name__c, Discount_Type__c,Discount_Value__c, Quantity__c, Actual_Price__c, Unit_Price__c, Opportunity_Name__r.Name
            FROM SalesorderLineProduct__c
            WHERE Opportunity_Name__c = :oppc.Id
        ];
    }
    public PageReference updateSalesorderLi(){
        update relatedSalesorderLi;
        PageReference pf = new PageReference('/'+oppc.Id);
        return pf;
    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+oppc.Id);
        return pf;
    }
    public PageReference del(){
        delete relatedSalesorderLi[index];
        PageReference pf=new PageReference('/apex/EditAllSalesordersLi?id=' + oppc.Id);
        pf.setRedirect(True);
        return pf;        
    }

}