
 Select a.rendate,
		a.FK_psPatRegisters,
		c.itemdesc,
		sum(a.renqty) as Quantity,
		a.purcprice,
		d.priAttdngDoctor
		From psPatitem a
		join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse
		join iwItems c on a.FK_iwItemsREN = c.PK_iwItems
		join vwReportInpatientMstrList_sa d on d.PK_psPatRegisters = a.FK_psPatRegisters
		

		Where convert(date,rendate) between '2019-1-01' and '2019-3-31' and c.itemgroup = 'MED'

		GROUP BY a.rendate,
		a.FK_psPatRegisters,
		c.itemdesc,
		a.purcprice,
		d.priAttdngDoctor 


		Select ItemDescription,VendorName From vwReportPurchaseAnalysisNew Where Convert(date, docdate) between '2018-12-01' and '2019-03-31' group by ItemDescription,VendorName order by VendorName