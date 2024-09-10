@RestResource(urlMapping='/Account/*')
global class AccessSalesforceFromIntegration {
	@HttpGet
    global static List<Account> getAccounts(){
        return [Select Id, Name From Account];
    }
}