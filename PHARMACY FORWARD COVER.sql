Declare @saisS date  = '2018-09-30',
		@saisE date  = '2019-03-31',
		@tresS date  = '2019-01-31',
		@tresE date  = '2019-03-31',
		@Inventorydate date = '2019-03-31'

SELECT b.PK_iwItems, b.itemdesc,b.itemgroup,
	(Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @saisS and @saisE)as  '6 Months',
	(Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @tresS and @tresE)as  '3 Months',
	( Select isnull(fORMAT(sum(isnull(a.purcqty,0)
                                    - isnull(a.purcoutqty,0)
                                    - isnull(a.purcretqty,0)
                                    + isnull(a.purcretinqty,0)
                                    - isnull(a.salesqty,0)
                                    + isnull(a.salesretqty,0)
                                    + isnull(a.adjinqty,0)
                                    - isnull(a.adjoutqty,0)
                                    + isnull(a.prodqty,0) 
                                    - isnull(a.prodoutqty,0)
                                    + isnull(a.reqinqty,0)
                                    - isnull(a.reqoutqty,0)
                                    + isnull(a.issinqty,0)
                                    - isnull(a.issoutqty,0)),'0'),0) 
									from iwItemLedgerDaily a join mscWarehouse x on a.FK_mscWarehouse = x.PK_mscWarehouse where b.PK_iwItems = a.FK_iwItems  and CONVERT(DATE,a.refdate)  = @Inventorydate and 
									(x.description = 'Pharmacy')) AS INVENTORY,
	(Select isnull(FORMAT(SUM(c.renqty)/180,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @saisS and @saisE) as '6Months Avg. Sales',
	(Select isnull(FORMAT(SUM(c.renqty)/90,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @tresS and @tresE) as '3Months Avg. Sales'	
	FROM iwItemLedgerDaily a inner join iwItems b on b.PK_iwItems = a.FK_iwItems inner join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse 

WHERE c.description = 'Pharmacy' 

GROUP BY b.PK_iwItems, b.itemdesc,b.itemgroup ORDER BY itemgroup