public with sharing class CustomOppListView {
    public List<Opportunitiescustom__c> custOppList{get;set;}
    public String listIndex{get;set;}
    

    public CustomOppListView(){
        String recordIdsParam = ApexPages.currentPage().getParameters().get('recordIds');
       
        if (!String.isBlank(recordIdsParam)) {
            String[] recordIds = recordIdsParam.split(',');
            custOppList = [SELECT Id, Name, Stage__c, Account_Name__r.Name, Lead_Source__c, Email__c, Contact_Name__r.Name,Close_Date__c FROM Opportunitiescustom__c WHERE Id IN :recordIds];
        } else {
            custOppList = new List<Opportunitiescustom__c>();
        }
    }

    public void sendEmail() {
    for (Opportunitiescustom__c opp : custOppList) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setTemplateId('00X5j000002XvBe'); 
        //mail.setToAddresses(new List<String>{opp.Email__c});
        //mail.setTargetObjectId('01I5j000003KHUr'); 
        //mail.setWhatId(opp.Id);
        
        String[] toAddress = new String[]{opp.Email__c};
        String[] ccAddress = new String[]{'pasupulatink@gmail.com'};
         mail.setToAddresses(toAddress);
         mail.setCcAddresses(ccAddress);
         mail.setSubject('Opportuntiy Details'); 
         mail.sethtmlBody('Hi '+'<br></br> Below are your opportunity details- <br></br> Name= '+opp.name+
                                '<br></br> Email= '+opp.Email__c+'<br></br> Close Date= '+opp.Close_Date__c);
         messaging.sendEmail(new Messaging.singleEmailMessage[]{mail});

        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch (Exception e) {
            System.debug('An error occurred while sending the email: ' + e.getMessage());
        }
    }
}
    public void performdelete(){
        if (listIndex != null) {
            Integer indexToDelete = -1;
            for (Integer i = 0; i < custOppList.size(); i++) {
                if (custOppList[i].Id == listIndex) {
                    indexToDelete = i;
                    break;
                }
            }
            if (indexToDelete != -1) {
                custOppList.remove(indexToDelete);
            }
       }
   }
}