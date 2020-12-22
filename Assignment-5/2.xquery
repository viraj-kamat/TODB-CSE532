for $item in doc("dataset/purchaseorders.xml")/PurchaseOrders/PurchaseOrder/item
group by $a := $item/partid
order by $a
let $prodprice:= doc("dataset/products.xml")/products/product[@pid = $a]/description/price
let $totalprice := xs:int(sum($item/quantity)) * xs:float($prodprice)
return <totalcost partid="{$a}">{$totalprice}</totalcost>


