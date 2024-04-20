trigger OpportunityCustomTrigger on Opportunitiescustom__c (before insert, after insert) {
    if(trigger.isAfter && trigger.isInsert){
        OpportunityCustomTriggerHandler.updateNameWithTimeStamp(trigger.new);
    }
}