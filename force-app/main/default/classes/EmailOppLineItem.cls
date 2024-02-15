public class EmailOppLineItem {
    public ApexPages.StandardSetController controller;
    public string To{get;set;}
    public string Cc{get;set;}
    public string Subject{get;set;}
    public string Emailbody{get;set;}
    public Opportunitiescustom__c opp{get;set;}
    public list<string> Toaddress{get;set;}
    public list<string> Ccaddress{get;set;}
    public list<OpportunityLineItems__c> oppli{get;set;}
    public string recid{get;set;}
    
    public EmailOppLineItem(ApexPages.StandardSetController controller){
        String selectedIds = ApexPages.currentPage().getParameters().get('selectedIds');
        List<Id> ids = (selectedIds != null) ? selectedIds.split(',') : new List<Id>();
        opp = new Opportunitiescustom__c();
        opp=[select id, Name, Account_Name__r.Name, Stage__c,Close_Date__c,Lead_Source__c, Contact_Name__r.lastname, Contact_Name__r.Email from Opportunitiescustom__c
            where Id IN :ids];
        To= opp.Contact_Name__r.Email;
        Cc='nageswari422@gmail.com';
        Subject='Opportunity Details: '+opp.Name;
        Emailbody='<strong>Dear ' + opp.Contact_Name__r.lastname + ',</strong>' +
                   '<p>Hope you are doing well!</p>' +
                   '<p>Below are the details of the Opportunity, as requested by you! Please check and let us know for any further changes.</p>' +
                   '<b>Account Name: </b>' + opp.Account_Name__r.name + '</br>' +
                   '<b>Contact Name: </b>' + opp.Contact_Name__r.lastname + '</br>' +
                   '<b>Opportunity Name: </b>' + opp.Name + '</br>' +
                   '<b>Stage: </b>' + opp.Stage__c + '</br>'+
                   '<b>Close Date: </b>' + opp.Close_Date__c + '</br></br>';
        
        oppli= new list<OpportunityLineItems__c>();
        
        list<OpportunityLineItems__c> selectedRecord = controller.getSelected();
        if(!selectedRecord.isempty()){
        Emailbody+='<table border="1" style="border-collapse: collapse"><tr><th>Product Name</th><th>Quantity</th><th>Price</th></tr>';
        oppli=[select Id, Product__r.Name, Quantity__c, Unit_Price__c From OpportunityLineItems__c
               where Opportunity_Name__c= :opp.id AND Id IN :selectedRecord];
        
                  for(OpportunityLineItems__c a: oppli){
                       String prod= a.Product__r.Name;
                       Decimal qu= a.Quantity__c;
                       Decimal up= a.Unit_Price__c;
                       Emailbody += '<tr><td>' + prod + '</td><td>' + qu + '</td><td>' + up + '</td></tr>';   
                   }
            Emailbody +='</table>';
        }
        Emailbody +='<p>Please revert back to us on same Email.</p>'+
                    'Regards,</br> <b>Maheshwari</b>'; 
    }
    public pagereference sendemail(){
        Ccaddress= new list<string>();
        Toaddress= new list<string>();
        Ccaddress.add('nageswari422@gmail.com');
        Toaddress.add(opp.Contact_Name__r.Email);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(Toaddress);
        mail.setCcAddresses(Ccaddress);
        mail.setSubject(Subject);
        mail.setHtmlBody(Emailbody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        pagereference bb= new pagereference('/'+opp.Id);
        return bb;   
    }
    public pagereference cancelemail(){
        pagereference cc= new pagereference('/'+opp.Id);
        return cc;
    }
}