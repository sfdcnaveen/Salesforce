trigger AvoidDuplicateEmails on Contact (before insert, before update) {
    // Collect all the account Ids from the contacts being inserted or updated
    Set<Id> accountIds = new Set<Id>();
    for (Contact contact : Trigger.new) {
        accountIds.add(contact.AccountId);
    }
    
    // Query all the contacts related to the account Ids
    Map<Id, List<Contact>> accountContacts = new Map<Id, List<Contact>>();
    for (Contact existingContact : [SELECT Id, Email, AccountId FROM Contact WHERE AccountId IN :accountIds AND Email != null]) {
        if (!accountContacts.containsKey(existingContact.AccountId)) {
            accountContacts.put(existingContact.AccountId, new List<Contact>());
        }
        accountContacts.get(existingContact.AccountId).add(existingContact);
    }
    
    // Iterate through the contacts being inserted or updated
    for (Contact newContact : Trigger.new) {
        if (newContact.Email != null) {
            List<Contact> contactsInAccount = accountContacts.get(newContact.AccountId);
            if (contactsInAccount != null) {
                // Check for duplicate emails within the account
                for (Contact existingContact : contactsInAccount) {
                    if (existingContact.Email == newContact.Email && existingContact.Id != newContact.Id) {
                        newContact.Email.addError('Another contact in the same account has the same email.');
                        break;
                    }
                }
            }
        }
    }
}