public with sharing class AccConOppAuraEnabled {
  @AuraEnabled
  public static Id createAccount(
    String Name,
    String Phone,
    String Website,
    String Industry,
    String Description,
    String Rating
  ) {
    Account acc = new Account(
      Name = Name,
      Phone = Phone,
      Website = Website,
      Industry = Industry,
      Description = Description,
      Rating = Rating
    );
    insert acc;
    return acc.Id;
  }

  @AuraEnabled
  public static Id createContact(
    String FirstName,
    String LastName,
    Id AccountId,
    String Phone,
    String Email,
    String Title
  ) {
    if (Phone != null && Phone.length() != 10) {
      throw new AuraHandledException('Phone number must be 10 digits');
    }
    if (Phone == null && Email == null) {
      throw new AuraHandledException('Phone & Email both cannot be blank');
    }
    Contact con = new Contact(
      AccountId = AccountId,
      FirstName = FirstName,
      LastName = LastName,
      Phone = Phone,
      Email = Email,
      Title = Title
    );
    insert con;
    return con.Id;
  }

  @AuraEnabled
  public static void createOpportunity(
    String Name,
    String StageName,
    Id ContactId,
    Date CloseDate,
    Id AccountId
  ) {
    Opportunitiescustom__c opp = new Opportunitiescustom__c(
      Contact_Name__c = ContactId,
      Stage__c = StageName,
      Close_Date__c = CloseDate,
      Account_Name__c = AccountId
    );
    insert opp;
  }
}
