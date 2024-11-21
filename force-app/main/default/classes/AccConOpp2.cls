public with sharing class AccConOpp2 {
  @AuraEnabled
  public static void createAccountContactOpportunity(
    Account account,
    Contact contact,
    Opportunitiescustom__c opportunity
  ) {
    try {
      insert account;
      contact.AccountId = account.Id;
      insert contact;
      opportunity.Account_Name__c = account.Id;
      opportunity.Contact_Name__c = contact.Id;
      insert opportunity;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}