SElect d.description [department],docno,payername [PatientName],C.PK_iwItems [ItemCode], c.itemdesc [ItemDescription],a.amount from psPatinv a 
join pspatitem b on a.PK_TRXNO = b.FK_TRXNO
join iwItems c on c.PK_iwItems = b.FK_iwItemsREN 
join mscWarehouse  d on a.FK_mscWarehouse = d.PK_mscWarehouse Where doctype = 'CN' and convert(date, a.rendate) between '2018-01-01' and '2018-10-31' 


Select * From psPatinv Where doctype = 'CN'