public class CreateQuoteController {

    public Id oppId { get; set; }
    public Quotes__c quote { get; set; }
    public Opportunitiescustom__c oppc{get; set;}
    public List<Quotes__c > relatedQuotes { get; set; }

    public CreateQuoteController () {
        oppId = ApexPages.CurrentPage().getParameters().get('oppId');
        quote = new Quotes__c(Opportunitiescustom__c = oppId);
        relatedQuotes = new List<Quotes__c >();
        relatedQuotes = [
            SELECT Id, Name, Account__r.Name, Contact__r.Name, Delivery_Lead_Time__c, Payment_terms__c, Quote_Date__c, Remarks__c, Valid_Till__c, Warranty__c, Opportunitiescustom__r.Name
            FROM Quotes__c 
            WHERE Opportunitiescustom__c = :oppId
        ];
    }
    public PageReference save() {
            insert quote;
            PageReference pf = new PageReference('/'+quote.Id);
            return pf;
    }
    public PageReference cancel() {
        PageReference pf = new PageReference('/'+oppId );
        return pf;
    }
}