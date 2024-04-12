public class EmailOppLineItem {

    public EmailOppLineItem(ApexPages.StandardController controller) {

    }

   public Integer Tobedelete{get;set;}
    public List<String> ccmail = new List<String>{'pasupulatink@gmail.com'};
    public String tomail {get;set;}
    public string Cc{get;set;}
    public String Subject{get;set;}
    public string Emailbody{get;set;}
    public Opportunitiescustom__c opp {get;set;}
    public List <Opportunitiescustom__c> oppList {get;set;}
    public List <Opportunitiescustom__c> selectedOpp {get;set;}
    public list<string> Toaddress{get;set;}
    public list<string> Ccaddress{get;set;}
    public Set<Id> selectedIds { get; set; }
    ApexPages.StandardSetController stdController;

    
    public EmailOppLineItem(ApexPages.StandardSetController controller) {
       this.stdController = controller;
       selectedIds = new Set<Id>();
        List<Opportunitiescustom__c> selectedOpps = (List<Opportunitiescustom__c>) stdController.getSelected();
        for (Opportunitiescustom__c opp : selectedOpps) {
            selectedIds.add(opp.Id);
        }
       //opp = new Opportunitiescustom__c();
       //opp = [SELECT id,Name,Account_Name__r.Name,Stage__c,Contact_Name__r.Email,Close_Date__c FROM Opportunitiescustom__c where Id= :selectedIds];
       //oppList = new List <Opportunitiescustom__c>();
       Subject='Hello!!!';
       Emailbody='Good Morning';
       oppList =[SELECT id,Name,Account_Name__r.Name,Stage__c,Contact_Name__r.Email,Close_Date__c FROM Opportunitiescustom__c WHERE Id IN :selectedIds];
       
        if(!oppList.isempty()){
        for(Opportunitiescustom__c opp: oppList){
                      String oppName= opp.Name;
                       String accName= opp.Account_Name__r.Name;
                       String conName = opp.Contact_Name__r.Name;
                       String st= opp.Stage__c; 
                   }
        }
     }
    public pagereference  send()
    {
       Ccaddress= new list<string>();
        Toaddress= new list<string>();
        Ccaddress.add('pasupulatink@gmail.com');
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
    public void remove(){
        if(oppList != null && oppList.size()>Tobedelete){
            oppList.remove(Tobedelete);
        }
    }

}