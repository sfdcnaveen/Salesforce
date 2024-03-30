public class AccountIterable implements Iterable<Account> {
    public Iterator<Account> iterator(){
      List<Account> accounts =[SELECT Id, Name FROM Account];
      return new AccountIterator(accounts);
   }
}