public class BatchCreateContacts implements Database.Batchable<sObject> {
    public integer recordCount = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([Select Id, Name From Account]);
    }
    public void execute(Database.BatchableContext bc, List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc: accList){
            Contact contact = new Contact();
            contact.LastName = acc.Name;
            contact.AccountId = acc.Id;
            conList.add(contact);
            recordCount++;
        }
        insert conList;
    }
    public void finish(Database.BatchableContext BC) {
        System.debug('Number of contacts created: '+ recordCount);
    }
}