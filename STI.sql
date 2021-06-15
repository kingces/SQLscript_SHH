select 
	c.docdate as [Document Date],
	c.docno as [Document No], 
	sum(a.qty) as [Quantity],
	sum(a.price) as [Unit Cost],
	sum(a.netcost) as [Balance],
	d.description as [Requesting Department],
	dd.description as [Source Department]
	
from iwwhitem a
	inner join iwitems b on a.FK_iwItems = b.PK_iwitems
	inner join iwWhinv c on a.FK_TRXNO = c.PK_TRXNO
	inner join mscwarehouse d on c.FK_mscWarehouseDST = d.pk_mscwarehouse
	inner join mscwarehouse dd on c.FK_mscWarehouseSRC = dd.pk_mscwarehouse
where
	c.docdate between '2016-01-01' and '2016-12-31'


	group by 	
	c.docdate,
	c.docno ,
	d.description,
	dd.description 

	order by c.docno
