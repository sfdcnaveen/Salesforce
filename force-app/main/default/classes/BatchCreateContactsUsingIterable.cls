public class BatchCreateContactsUsingIterable implements Database.Batchable<Account>, Iterator<Account>, Iterable<Account> {
    List<Account> accounts;
   Integer currentIndex;
    public Boolean hasNext(){ 
       return currentIndex < accounts.size();
   }
   public Account next(){
       return accounts[currentIndex++];
   }
    public Iterator<Account> iterator(){
      List<Account> accounts =[SELECT Id, Name FROM Account];
      return new AccountIterator(accounts);
   }
    public Iterable<Account> start(Database.BatchableContext bc){
        return new AccountIterable();
    }
    public void execute(Database.BatchableContext bc, List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc: accList){
            Contact contact = new Contact();
            contact.LastName = acc.Name;
            contact.AccountId = acc.Id;
            conList.add(contact);
        }
        insert conList;
    }
    public void finish(Database.BatchableContext bc){
        
    }
    
}