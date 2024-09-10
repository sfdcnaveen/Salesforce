trigger AccountTrigger on Account (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        if(!Trigger.new.isEmpty()){
            for(Account acc : Trigger.New){
                if(acc.Phone == null){
                    acc.addError('You cannot insert account with Phone field as Empty');
                }
            }
        }
    }
    if(Trigger.isInsert && Trigger.isBefore){
        AccountTriggerHandler ath = new AccountTriggerHandler();
        ath.updateRatingBasedAnnualRevenue(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        AccountTriggerHandler ath = new AccountTriggerHandler();
        ath.createRelatedContact(Trigger.new);
    }
}