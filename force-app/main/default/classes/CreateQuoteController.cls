public class CreateQuoteController {

    public list<OpportunityLineItems__c> lioppli{get;set;}
    public Opportunitiescustom__c opp{get;set;}
    public String oppId{get; set;}
    public List<QuoteLineItem__c> quoteLineItems { get; set; }
    public QuoteLineItem__c qli{get; set;}
    public Quotes__c qc{get; set;}
    
    public CreateQuoteController() {
        opp = new Opportunitiescustom__c();
        qc = new Quotes__c();
        lioppli=new list<OpportunityLineItems__c>();
        qli = new QuoteLineItem__c();
        quoteLineItems = new List<QuoteLineItem__c>();
        oppId=ApexPages.currentPage().getParameters().get('id');
        lioppli=new list<OpportunityLineItems__c>();
        lioppli = [
            SELECT Id, Name, Discount_Type__c,Discount_Value__c, Quantity__c, Actual_Price__c, Unit_Price__c, Opportunity_Name__c, Product__c, Total_Price__c
            FROM OpportunityLineItems__c
            WHERE Opportunity_Name__c = :oppId
        ];
        opp = [SELECT Name,Account_Name__c, Contact_Name__c, Account_Name__r.Name, Contact_Name__r.Name
                           FROM Opportunitiescustom__c WHERE Opportunitiescustom__c.id = :oppId LIMIT 1];
    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+oppId);
        return pf;
    }
    public PageReference save() {
        qc.Opportunitiescustom__c= opp.id;
        qc.Account__c=opp.Account_Name__r.id;
        qc.Contact__c= opp.Contact_Name__r.id;
        insert qc;
        for(OpportunityLineItems__c cc: lioppli)
        {
            qli = new QuoteLineItem__c();
            qli.Quotes__c = qc.id;
            qli.Opportunity__c = cc.Opportunity_Name__c;
            qli.Product__c = cc.Product__c;
            qli.Quantity__c = cc.Quantity__c;
            qli.Unit_Price__c = cc.Unit_Price__c;
            quoteLineItems.add(qli);
        }
        upsert qli;
        PageReference pf = new PageReference('/'+oppId);
        return pf;
    }
}