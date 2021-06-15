INSERT INTO SHHDB.dbo.WFC (FK_iwItems,ThreeMonths,OneMonth,TwoWeeks,Inventory)
SELECT b.PK_iwItems,	
(Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between DATEADD(MONTH,- 3,convert(Date,GETDATE())) and convert(Date,GETDATE())),	
(Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between DATEADD(MONTH,- 1,convert(Date,GETDATE())) and convert(Date,GETDATE())),
(Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between DATEADD(WEEK, - 2,convert(Date,GETDATE())) and convert(Date,GETDATE())),
( Select isnull(fORMAT(sum(isnull(a.purcqty,0)- isnull(a.purcoutqty,0)- isnull(a.purcretqty,0) + isnull(a.purcretinqty,0)- isnull(a.salesqty,0) + isnull(a.salesretqty,0) + isnull(a.adjinqty,0)   - isnull(a.adjoutqty,0) + 
 isnull(a.prodqty,0) - isnull(a.prodoutqty,0) + isnull(a.reqinqty,0) - isnull(a.reqoutqty,0) + isnull(a.issinqty,0) - isnull(a.issoutqty,0)),'0'),0) from iwItemLedgerDaily a  where b.PK_iwItems = a.FK_iwItems  
 and a.refdate  < DATEADD(DAY,+1,convert(Date,GETDATE())) and (a.FK_mscWarehouse = '1019' or a.FK_mscWarehouse = '1010' ))
 FROM iwItemLedgerDaily a inner join iwItems b on b.PK_iwItems = a.FK_iwItems inner join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left join iwItemMedicines d on b.PK_iwItems = d.FK_iwItems left join mscGenerics e on e.PK_mscGenerics = d.FK_mscGenerics 
 where (Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between DATEADD(MONTH,- 6,convert(Date,GETDATE())) and convert(Date,GETDATE())) <> 0
 and (b.PK_iwItems not like 'E%' and b.PK_iwItems not like '%OPM%') and isactive = '1' group by b.PK_iwItems

-- delete from SHHDB.dbo.WFC
