public class AccConOpp {
    public Account newAccount { get; set; }
    public Contact newContact { get; set; }
    public Opportunitiescustom__c newOpportunity { get; set; }
    
    public AccConOpp() {
        newAccount = new Account();
        newContact = new Contact();
        newOpportunity = new Opportunitiescustom__c();
    }
    public pagereference SaveIt(){
            insert newAccount;
            newContact.AccountId = newAccount.Id;
            insert newContact;
            newOpportunity.Account_Name__c = newAccount.Id;
            insert newOpportunity;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Records saved successfully.'));
            pagereference pf=new pagereference('/'+newAccount.Id);
            return pf;
                
        }
    public PageReference cancelAction() {
        return new PageReference('/apex/AccConOpp'); 
    }
}