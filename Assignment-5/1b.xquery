doc("dataset/purchaseorders.xml")//PurchaseOrder[(@Status = "Unshipped" or @Status = "UnShipped"  )  and @OrderDate="2006-02-18"]//item[partid != "100-100-01"]