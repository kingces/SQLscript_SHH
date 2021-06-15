select   a.FK_mscWarehouseSRC,
					   a.FK_mscWarehouseDST,
					   a.docno [Document No.],
					   a.docdate [Document Date],
					   b.FK_iwItems [Item ID],
					   c.itemdesc [Item Description],
					   b.unit,
					   b.price,
					   b.qty [Quantity],
					   b.netcost [Amount],
					   a.remarks,
					   d.PK_mscWarehouse,
					   d.description [mscWarehouseDST],
					   e.description [Issuing Department],
					   a.cancelflag,
					   a.postflag,
					   a.deleteflag
                    	   
				from iwIssinv a

					   inner join iwIssitem b on
						  a.PK_TRXNO = b.FK_TRXNO
					   inner join iwItems c on
						  b.FK_iwItems = c.PK_iwItems
					   inner join mscWarehouse d on
						  a.FK_mscWarehouseDST = d.PK_mscWarehouse
					   inner join mscWarehouse e on 
						  a.FK_mscWarehouseSRC = e.PK_mscWarehouse 
						  where convert(date, a.docdate) between '2017-09-01' and '2017-12-31' and d.description = 'LABORATORY'