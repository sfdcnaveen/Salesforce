public class EditAllSalesordersLiController {
    public Integer myvar { get; set; }
    public Salesorder__c so{get; set;}
    public List<SalesorderLineProduct__c> relatedSalesorderLi { get; set; }
    public Integer num{get; set;}
    public integer index{get; set;}
    
    public EditAllSalesordersLiController() {
        so = new Salesorder__c();
        so.Id = ApexPages.currentPage().getParameters().get('id');
        relatedSalesorderLi = new List<SalesorderLineProduct__c>();
        relatedSalesorderLi = [
            SELECT Id,SalesorderLineProduct__c.Name, Account_Name__c, Discount_Type__c,Discount_Value__c, Quantity__c, Actual_Price__c, Unit_Price__c, Opportunity_Name__r.Name
            FROM SalesorderLineProduct__c
            WHERE Salesorder_Name__c = :so.Id
        ];
    }
    public PageReference updateSalesorderLi(){
        update relatedSalesorderLi;
        PageReference pf = new PageReference('/'+so.Id);
        return pf;
    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+so.Id);
        return pf;
    }
    public PageReference del(){
        delete relatedSalesorderLi[index];
        PageReference pf=new PageReference('/apex/EditAllSalesordersLi?id=' + so.Id);
        pf.setRedirect(True);
        return pf;        
    }

}