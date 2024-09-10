trigger OpportunitySplitTrigger on Opportunity (after insert) {

    List<OpportunitySplit> opportunitySplitsToInsert = new List<OpportunitySplit>();
    List<OpportunitySplit> opportunitySplitsToUpdate = new List<OpportunitySplit>();

    // Retrieve the Revenue Split Type ID (using SplitType's DeveloperName)
    OpportunitySplit revenueSplitType = [SELECT SplitTypeId, SplitType.DeveloperName FROM OpportunitySplit WHERE SplitType.DeveloperName = 'Revenue' LIMIT 1];
    Id revenueSplitTypeId = revenueSplitType.SplitTypeId;

    // Debugging the Revenue Split Type ID
    System.debug('Revenue Split Type ID: ' + revenueSplitTypeId);

    // Process each Opportunity
    for(Opportunity opp : Trigger.new) {
        // Fetch existing Opportunity Splits for the Opportunity
        List<OpportunitySplit> existingSplits = [SELECT Id, SplitOwnerId, SplitPercentage FROM OpportunitySplit 
                                                 WHERE OpportunityId = :opp.Id 
                                                 AND SplitTypeId = :revenueSplitTypeId];

        Boolean opportunityOwnerSplitUpdated = false;
        Boolean accountOwnerSplitExists = false;

        // Fetch the Account Owner
        Account account = [SELECT OwnerId FROM Account WHERE Id = :opp.AccountId LIMIT 1];

        // Process existing Opportunity Splits to update Opportunity Owner's split
        for (OpportunitySplit existingSplit : existingSplits) {
            if (existingSplit.SplitOwnerId == opp.OwnerId) {
                // Update the Opportunity Owner's split percentage to 25%
                existingSplit.SplitPercentage = 25;
                opportunitySplitsToUpdate.add(existingSplit);
                opportunityOwnerSplitUpdated = true;
            } else if (existingSplit.SplitOwnerId == account.OwnerId) {
                // If Account Owner already has a split, update it to 75%
                existingSplit.SplitPercentage = 75;
                opportunitySplitsToUpdate.add(existingSplit);
                accountOwnerSplitExists = true;
            }
        }

        // If the Account Owner doesn't have a split, create a new split for them
        if (!accountOwnerSplitExists && account.OwnerId != opp.OwnerId) {
            OpportunitySplit accountOwnerSplit = new OpportunitySplit();
            accountOwnerSplit.OpportunityId = opp.Id;
            accountOwnerSplit.SplitTypeId = revenueSplitTypeId;
            accountOwnerSplit.SplitOwnerId = account.OwnerId;
            accountOwnerSplit.SplitPercentage = 75;
            opportunitySplitsToInsert.add(accountOwnerSplit);
        }

        // If the Opportunity Owner's split wasn't found, create a new one
        if (!opportunityOwnerSplitUpdated) {
            OpportunitySplit oppOwnerSplit = new OpportunitySplit();
            oppOwnerSplit.OpportunityId = opp.Id;
            oppOwnerSplit.SplitTypeId = revenueSplitTypeId;
            oppOwnerSplit.SplitOwnerId = opp.OwnerId;
            oppOwnerSplit.SplitPercentage = 25;
            opportunitySplitsToInsert.add(oppOwnerSplit);
        }
    }

    // Update existing Opportunity Splits
    if (!opportunitySplitsToUpdate.isEmpty()) {
        update opportunitySplitsToUpdate;
    }

    // Insert new Opportunity Splits
    if (!opportunitySplitsToInsert.isEmpty()) {
        insert opportunitySplitsToInsert;
    }
}