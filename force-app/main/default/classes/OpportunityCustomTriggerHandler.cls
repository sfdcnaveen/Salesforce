public class OpportunityCustomTriggerHandler {
    public static void updateNameWithTimeStamp(List<Opportunitiescustom__c> newOppList){
        List<Opportunitiescustom__c> recordsToUpdate = new List<Opportunitiescustom__c>();
        DateTime timestamp = DateTime.now();
        String formattedTimeStamp = timestamp.format('dd/MM/yyyy');
        for(Opportunitiescustom__c opp: [SELECT Id,Name,NameWithTimestamp__c FROM Opportunitiescustom__c WHERE Id IN :newOppList])
        {
            opp.NameWithTimestamp__c = opp.Name + '-' + formattedTimeStamp;
            System.debug(opp.NameWithTimestamp__c);
            recordsToUpdate.add(opp);
        }
        update recordsToUpdate;
    }
        
}