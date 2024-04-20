trigger InvoiceLineProductTrigger on InvoiceLineProduct__c (after insert, after update, after delete, after undelete, before update) {
     
    if(trigger.isInsert || trigger.isUpdate){
    	InvoiceLineProductTriggerHandler.handleBalancedquantity(trigger.new);
    }
    if(trigger.isDelete){
        InvoiceLineProductTriggerHandler.handleBalancedquantity(trigger.old); 
    }
    if(Trigger.isAfter && trigger.isInsert){
        inventoryHistoryHandlerClass.createInventoryHistoryFromInvoiceLineProduct(Trigger.New);
    }
}