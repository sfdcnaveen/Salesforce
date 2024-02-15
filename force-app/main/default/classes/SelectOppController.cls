public class SelectOppController {

    public List<Opportunitiescustom__c> selectedOpportunities { get; set; }
    
    public SelectOppController() {
        selectedOpportunities = new List<Opportunitiescustom__c>();
    }
    
    public PageReference displaySelectedOpportunities() {
        String[] opportunityIds = ApexPages.currentPage().getParameters().get('ids').split(',');
        
        selectedOpportunities = [
            SELECT Name, Account_Name__c, Stage__c
            FROM Opportunitiescustom__c
            WHERE Id IN :opportunityIds
        ];
        
        return null;
    }
}