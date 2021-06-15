Declare @doseS date = '2020-02-26',
        @doseE date = '2021-02-26',
		@saisS date = '2020-08-26',
        @saisE date = '2021-02-26',
		@tresS date = '2020-11-26',
        @tresE date = '2021-02-26',
		@Inventorydate date = '2021-02-27'



SELECT b.isactive,b.PK_iwItems, b.itemdesc,e.description [GenericName],b.itemgroup,
	(Select isnull(format(sum(c.renqty),'0'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @doseS and @doseE)as '12 Months',
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
									from iwItemLedgerDaily a  where b.PK_iwItems = a.FK_iwItems  and a.refdate  < @Inventorydate and 
									(a.FK_mscWarehouse = '1019' or a.FK_mscWarehouse = '1010' )) AS INVENTORY,
	(Select isnull(FORMAT(SUM(c.renqty)/12,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @doseS and @doseE) as '12Months Avg. Sales',
	(Select isnull(FORMAT(SUM(c.renqty)/6,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @saisS and @saisE) as '6Months Avg. Sales',
	(Select isnull(FORMAT(SUM(c.renqty)/3,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @tresS and @tresE) as '3Months Avg. Sales',
	(Case When ((Select isnull(ROUND(SUM(c.renqty)/12,2),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @doseS and @doseE)) != 0 Then (Select isnull(ROUND(sum(isnull(a.purcqty,0) - isnull(a.purcoutqty,0) - isnull(a.purcretqty,0) + isnull(a.purcretinqty,0) - isnull(a.salesqty,0) + isnull(a.salesretqty,0) + isnull(a.adjinqty,0) - isnull(a.adjoutqty,0) + isnull(a.prodqty,0) - isnull(a.prodoutqty,0) + isnull(a.reqinqty,0) - isnull(a.reqoutqty,0) + isnull(a.issinqty,0) - isnull(a.issoutqty,0)),2),0) from iwItemLedgerDaily a  where b.PK_iwItems = a.FK_iwItems  and a.refdate  < @Inventorydate and (a.FK_mscWarehouse = '1019' or a.FK_mscWarehouse = '1010' ))/(Select isnull(FORMAT(SUM(c.renqty)/12,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @doseS and @doseE) Else 0 End) as 'Monthly Forward Cover in 12',
	(Case When ((Select isnull(ROUND(SUM(c.renqty)/6,2),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @saisS and @saisE)) != 0 Then (Select isnull(ROUND(sum(isnull(a.purcqty,0) - isnull(a.purcoutqty,0) - isnull(a.purcretqty,0) + isnull(a.purcretinqty,0) - isnull(a.salesqty,0) + isnull(a.salesretqty,0) + isnull(a.adjinqty,0) - isnull(a.adjoutqty,0) + isnull(a.prodqty,0) - isnull(a.prodoutqty,0) + isnull(a.reqinqty,0) - isnull(a.reqoutqty,0) + isnull(a.issinqty,0) - isnull(a.issoutqty,0)),2),0) from iwItemLedgerDaily a  where b.PK_iwItems = a.FK_iwItems  and a.refdate  < @Inventorydate and (a.FK_mscWarehouse = '1019' or a.FK_mscWarehouse = '1010' ))/(Select isnull(FORMAT(SUM(c.renqty)/6,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @saisS and @saisE) Else 0 End) as 'Monthly Forward Cover in 6',
	(Case When ((Select isnull(ROUND(SUM(c.renqty)/3,2),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @tresS and @tresE)) != 0 Then (Select isnull(ROUND(sum(isnull(a.purcqty,0) - isnull(a.purcoutqty,0) - isnull(a.purcretqty,0) + isnull(a.purcretinqty,0) - isnull(a.salesqty,0) + isnull(a.salesretqty,0) + isnull(a.adjinqty,0) - isnull(a.adjoutqty,0) + isnull(a.prodqty,0) - isnull(a.prodoutqty,0) + isnull(a.reqinqty,0) - isnull(a.reqoutqty,0) + isnull(a.issinqty,0) - isnull(a.issoutqty,0)),2),0) from iwItemLedgerDaily a  where b.PK_iwItems = a.FK_iwItems  and a.refdate  < @Inventorydate and (a.FK_mscWarehouse = '1019' or a.FK_mscWarehouse = '1010' ))/(Select isnull(FORMAT(SUM(c.renqty)/3,'0.00'),0) from psPatitem c Where b.PK_iwItems = c.FK_iwItemsREN and  convert(date,c.rendate) between @tresS and @tresE) Else 0 End) as 'Monthly Forward Cover in 3'
	
	FROM iwItemLedgerDaily a 
	inner join iwItems b on b.PK_iwItems = a.FK_iwItems 
	inner join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse 
	left join iwItemMedicines d on b.PK_iwItems = d.FK_iwItems
	left join mscGenerics e on e.PK_mscGenerics = d.FK_mscGenerics

GROUP BY b.isactive,b.PK_iwItems, b.itemdesc,b.itemgroup,e.description