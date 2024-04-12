public class QuotePDFController {
    public List<Quotes__c> quLi{get;set;}
    public Quotes__c qu{get;set;}
    public String accId{get;set;}
    public Account ac{get;set;}
    
    public QuotePDFController(){
        qu= new Quotes__c();
        qu=[select ID, Name, Account__c,Contact__c, Delivery_Lead_Time__c, Opportunitiescustom__c, Payment_terms__c, Quote_Date__c, Remarks__c,Valid_Till__c, Warranty__c 
              from Quotes__c WHERE ID=: ApexPages.currentPage().getParameters().get('Id') limit 1];
        accId= qu.Account__c;
        ac = [SELECT Id, Name, BillingStreet, ShippingStreet, BillingCity, ShippingCity, BillingPostalCode, ShippingPostalCode, BillingState, ShippingState  FROM Account WHERE Id = :accId LIMIT 1];
    
    }

    public List<Quotes__c> getQuotesList(){
        return quLi;
        
    }
}