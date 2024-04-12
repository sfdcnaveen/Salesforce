public class sendemailfromopp {
    
    public List<sendemailfromoppwrap> oppwrap{get;set;}
    public List<Opportunitiescustom__c> opp{get;set;}
    public integer indexno{get;set;}
    
    public sendemailfromopp(){
        oppwrap = new List<sendemailfromoppwrap>();
        opp= new List<Opportunitiescustom__c>();
        for(Opportunitiescustom__c o: [Select id,Name,Account_Name__r.Name,Stage__c,Contact_Name__r.Email,Close_Date__c,OwnerId,Email__c from Opportunitiescustom__c]){
            oppwrap.add(new sendemailfromoppwrap(o));
        }
    }
    
    public class sendemailfromoppwrap{
        
        public boolean checkbox{get;set;}
        public Opportunitiescustom__c addedopp{get;set;}
        
        public sendemailfromoppwrap(Opportunitiescustom__c opp){
            checkbox = false;
            addedopp= opp;
        }
    }
    
    public void add(){
        for(sendemailfromoppwrap o: oppwrap){
            if(o.checkbox==true){
                opp.add(o.addedopp);
            }
            o.checkbox=false;
        }
    }
    
    public void send(){
        if(opp.size()>0){
            Messaging.SingleEmailMessage msg= new Messaging.SingleEmailMessage();
            for(Opportunitiescustom__c o :opp){
                String[] toAddress = new String[]{o.email__c};
                String[] ccAddress = new String[]{'pasupulatink@gmail.com'};
                msg.setToAddresses(toAddress);
                msg.setCcAddresses(ccAddress);
                msg.setSubject('Opportuntiy Details'); 
                msg.sethtmlBody('Hi '+'<br></br> Below are your opportunity details- <br></br> Name= '+o.name+
                                '<br></br> Email= '+o.Email__c+'<br></br> Close Date= '+o.Close_Date__c);
                messaging.sendEmail(new Messaging.singleEmailMessage[]{msg});
            }
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.CONFIRM,'Email sent successfully'));
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.WARNING,'No records selected. Please Seleted some record and then send email'));
        }
    }
    
    public pageReference Cancel(){
        pageReference pg = new pageReference('/lightning/o/Opportunity_Management__c/list?filterName=Recent');
        return pg;
    }
    
    public void deleteIt(){
        opp.remove(indexno-1);
    }
    
}