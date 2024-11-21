public with sharing class RelatedRecordCreatorController {
  @AuraEnabled
  public static Map<String, String> createRelatedRecords(
    Map<String, Object> accountData,
    Map<String, Object> contactData,
    Map<String, Object> opportunityData
  ) {
    Map<String, String> result = new Map<String, String>();

    try {
      // Create Account
      Account newAccount = new Account(
        Name = (String) accountData.get('Name'),
        Industry = (String) accountData.get('Industry'),
        Phone = (String) accountData.get('Phone')
      );
      insert newAccount;
      result.put('accountId', newAccount.Id);

      // Create Contact
      Contact newContact = new Contact(
        AccountId = newAccount.Id,
        FirstName = (String) contactData.get('FirstName'),
        LastName = (String) contactData.get('LastName'),
        Email = (String) contactData.get('Email')
      );
      insert newContact;
      result.put('contactId', newContact.Id);

      // Create Opportunity
      Opportunity newOpportunity = new Opportunity(
        AccountId = newAccount.Id,
        Name = (String) opportunityData.get('Name'),
        StageName = (String) opportunityData.get('StageName'),
        CloseDate = Date.valueOf((String) opportunityData.get('CloseDate'))
      );
      insert newOpportunity;
      result.put('opportunityId', newOpportunity.Id);

      return result;
    } catch (Exception e) {
      throw new AuraHandledException(
        'Error creating records: ' + e.getMessage()
      );
    }
  }

  @AuraEnabled(cacheable=true)
  public static Map<String, List<Map<String, String>>> getPicklistValues() {
    Map<String, List<Map<String, String>>> result = new Map<String, List<Map<String, String>>>();

    // Get Industry picklist values
    Schema.DescribeFieldResult industryField = Account.Industry.getDescribe();
    List<Schema.PicklistEntry> industryValues = industryField.getPicklistValues();
    result.put('industryValues', getPicklistOptions(industryValues));

    // Get Stage picklist values
    Schema.DescribeFieldResult stageField = Opportunity.StageName.getDescribe();
    List<Schema.PicklistEntry> stageValues = stageField.getPicklistValues();
    result.put('stageValues', getPicklistOptions(stageValues));

    return result;
  }

  private static List<Map<String, String>> getPicklistOptions(
    List<Schema.PicklistEntry> picklistEntries
  ) {
    List<Map<String, String>> options = new List<Map<String, String>>();
    for (Schema.PicklistEntry entry : picklistEntries) {
      if (entry.isActive()) {
        options.add(
          new Map<String, String>{
            'label' => entry.getLabel(),
            'value' => entry.getValue()
          }
        );
      }
    }
    return options;
  }
}
