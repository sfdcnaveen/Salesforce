public class AccountIterator implements Iterator<Account>{ 
   List<Account> accounts;
   Integer currentIndex;
    public AccountIterator(List<Account> accounts){
       this.accounts = accounts;
       this.currentIndex = 0;
    }
   public Boolean hasNext(){ 
       return currentIndex < accounts.size();
   }
   public Account next(){
       return accounts[currentIndex++];
   }
}