public class AccountTriggerHandler {
    public void updateRatingBasedAnnualRevenue(List<Account> accList){
        for(Account acc : accList){
            if( acc.AnnualRevenue >= 10000){
                acc.Rating = 'Hot';
            }
            else{
                acc.Rating = 'Cold';
            }
        }
    }
    public void createRelatedContact(List<Account> accList){
        //List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            System.debug('Account: '+acc);
            Contact con = new Contact();
            con.LastName = acc.Name+' contact';
            con.Phone = acc.Phone;
            con.Email = acc.Email__c;
            con.AccountId = acc.Id;
            insert con;
            //conList.add(con);
            System.debug('Contact: '+con);
        }
        //insert conList;
    }
}