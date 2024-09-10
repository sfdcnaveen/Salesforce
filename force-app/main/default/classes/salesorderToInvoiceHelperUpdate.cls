public class salesorderToInvoiceHelperUpdate {
    public static void InvoicedQty(List<InvoiceLineProduct__c> invListItm){
    	
        //To update Invoiced quantity on Sales_orderline_item__c
        Map<id, decimal> soliToQuanity = new Map<id,decimal>();
        Set<id> salesid = new Set<id>();
        Set<id> invoiceId = new Set<id>();
        for(InvoiceLineProduct__c inv : invListItm){
            if(inv.Sales_orderline_item__c != null){
                soliToQuanity.put(inv.Sales_orderline_item__c, inv.Quantity__c);
                salesid.add(inv.Sales_orderline_item__c);
                invoiceId.add(inv.Invoice_Name__c);
                system.debug(inv.Product__c);
            }
        }
        
		List<SalesorderLineProduct__c> sales = new List<SalesorderLineProduct__c>([Select id,Invoiced_Quantity__c from SalesorderLineProduct__c where id in: salesid]);
        
        for(SalesorderLineProduct__c soli : sales){
            decimal quantity = soli.Invoiced_Quantity__c;
            quantity += soliToQuanity.get(soli.id);
            soli.Invoiced_Quantity__c = quantity;
        }
        update sales;
        
        //To create inventory history
        Map<id, Invoice__c> invoiceMap = new Map<id, Invoice__c>([Select id, name,Ware_House__c from Invoice__c where id in : invoiceId]);
        List<InventoryHistory__c> inventhistory= new List<InventoryHistory__c>();
        
        for (InvoiceLineProduct__c inv : invListItm) {
            Invoice__c invoice = invoiceMap.get(inv.Invoice_Name__c);
            if (invoice != null) {
                Inventory__c inventory = [SELECT Id, Name FROM Inventory__c WHERE Warehouse__c =: invoice.Ware_House__c AND Product__c =: inv.Product__c];
                if (inventory != null) {
                    InventoryHistory__c newInventoryHistory = new InventoryHistory__c(
                        Invoiced_Line_Item_Quantity__c = inv.Quantity__c,
                        Invoice_Line_item__c = inv.Id,
                        Inventory__c = inventory.Id,
                        Product__c = inv.Product__c
                    );
                    inventHistory.add(newInventoryHistory);
                }
            }
        }
        insert inventHistory;
    }
}