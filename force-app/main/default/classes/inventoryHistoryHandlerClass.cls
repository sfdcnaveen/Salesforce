public class inventoryHistoryHandlerClass {
    public static void createInventoryHistoryFromInvoiceLineProduct(list<InvoiceLineProduct__c> invlist){
        
        Set<Id> iliIds= new Set<Id>();
        for(InvoiceLineProduct__c il: invlist){
        	iliIds.add(il.Id);
        }
        List<InvoiceLineProduct__c> iliList2= [Select Id, Invoice_Name__r.Ware_House__c, Product__c, Quantity__c from InvoiceLineProduct__c where Id in: iliIds];
      	List<InventoryHistory__c> ihLi = new List<InventoryHistory__c>();
        for(InvoiceLineProduct__c ilp : invlist){
            InventoryHistory__c ih = new InventoryHistory__c();
            ih.Product__c = ilp.Product__c;
            ih.Invoice_Line_Item__c = ilp.id;
            ih.Invoiced_Line_Item_Quantity__c = ilp.Quantity__c;
            Id warehouseId= ilp.Invoice_Name__r.Ware_House__c;
            Id productId= ilp.Product__c;
            Inventory__c inventory= [Select Id from Inventory__c where Product__c=: productId And Warehouse__c=:warehouseId];
            ih.Inventory__c= inventory.id;
            ihLi.add(ih);
        }
       
        if(!ihLi.isEmpty()){
			insert ihLi;
        } 
    }
}