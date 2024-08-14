public class ApexClsLWC {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts(String actName) {
    List<Account> accountList = new List<Account>();
    if (actName != '') {
      String accountName = '%' + actName + '%';
      accountList = [SELECT Id, Name FROM Account WHERE Name LIKE :accountName];
    }
    return accountList;
  }
  @AuraEnabled
  public static void createOpp(String email, Id AccountId, Date CloseDate) {
    Opportunitiescustom__c opp = new Opportunitiescustom__c(
      Email__c = email,
      Account_Name__c = AccountId,
      Close_Date__c = CloseDate
    );
    insert opp;
  }
}
