trigger UpdateContactPhoneNumber on Contact (before insert) {
    Set<Id> accountIds = new Set<Id>();
    for(Contact contact : Trigger.new){
        accountIds.add(contact.AccountId);
    }
    Map<Id, Account> accounts = new Map<Id,Account>([SELECT Id,Name, Phone FROM Account WHERE Id IN :accountIds]);
    for(Contact contact : Trigger.new){
        Account relatedAccount = accounts.get(contact.AccountId);
        if(relatedAccount != null && contact.LastName == relatedAccount.Name){
            contact.Phone = relatedAccount.Phone;
        }
    }
}