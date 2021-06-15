select * from 
(
Select
dbo.udf_GetItemDescription (a.fk_iwitems) [Item Description],
a.FK_iwItems as [Item ID],

(select itemgroup from iwItemS where PK_iwItems = fk_iwitems) [Item Group],
dbo.udf_getdepartmentname (a.fk_mscwarehouse) [Department],
SUM(a.qtyin)-SUM(a.qtyout) as [Invty Balance-Ledger],
(select sum(purcqty+salesretqty+adjinqty+reqinqty+prodqty+issinqty+purcretinqty)-
sum(purcretqty+salesqty+adjoutqty+reqoutqty+prodoutqty+issoutqty+purcoutqty) from iwItemLedgerDaily where FK_iwItems = 
a.FK_iwItems and FK_mscWarehouse = a.FK_mscWarehouse) as [Invty Balance-Daily],
(select sum(purcqty+salesretqty+adjinqty+reqinqty+prodqty+issinqty+purcretinqty)-
sum(purcretqty+salesqty+adjoutqty+reqoutqty+prodoutqty+issoutqty+purcoutqty) from iwWareitem where FK_iwItems = 
a.FK_iwItems and FK_mscWarehouse = a.FK_mscWarehouse) as [Invty Balance-Wareitem]
from iwItemLedger a
group by a.FK_iwItems, a.FK_mscWarehouse
) as aa
where (aa.[Invty Balance-Ledger] <> aa.[Invty Balance-Daily]) or (aa.[Invty Balance-Ledger]<> aa.[Invty Balance-Wareitem]) and aa.[Item ID] = 'M13008867'
