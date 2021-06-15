Declare @doseS date = '2017-05-25',
        @doseE date = '2018-09-25',
		@saisS date = '2018-02-25',
        @saisE date = '2018-09-25',
		@tresS date = '2018-05-25',
        @tresE date = '2018-09-25',
		@Inventorydate date = '2018-11-1'



SELECT b.PK_iwItems, b.itemdesc,b.bigunit,b.unit,
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
									from iwItemLedgerDaily a join mscWarehouse x on a.FK_mscWarehouse = x.PK_mscWarehouse  where b.PK_iwItems = a.FK_iwItems  and a.refdate  < @Inventorydate and 
									(x.description = 'LABOR')) AS QTY,
									b.lastpurcprice [UNITCOST], ( Select isnull(fORMAT(sum(isnull(a.purcqty,0)
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
									from iwItemLedgerDaily a join mscWarehouse x on a.FK_mscWarehouse = x.PK_mscWarehouse  where b.PK_iwItems = a.FK_iwItems  and a.refdate  < @Inventorydate and 
									(x.description = 'CSR')) *   b.lastpurcprice [TOTALCOST]	
									FROM iwItemLedgerDaily a 
									inner join iwItems b on b.PK_iwItems = a.FK_iwItems 
									inner join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse
									inner join vwHISItemsMstrList d on a.FK_iwItems = d.PK_iwItems
	and d.itemcategory = 'Laboratory Supplies' AND B.isactive = 1


GROUP BY isactive,b.PK_iwItems, b.itemdesc,b.itemgroup,b.bigunit,b.unit,b.lastpurcprice 