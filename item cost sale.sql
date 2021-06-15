Declare @YEAR VARCHAR(20) = 2017


SELECT z.description,x.FK_iwItemsREN, w.itemdesc,
	 (Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 1 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'January'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 2 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'February'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 3 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'March'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 4 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'April'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 5 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'May'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 6 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'June'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 7 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'July'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 8 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'August'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 9 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'September'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 10 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'October'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 11 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'November'
	,(Select isnull(sum(c.renprice),0) from psPatitem c left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO left outer join iwItems e on c.FK_iwItemsREN = e.PK_iwItems Where YEAR(convert(date,d.glpostdate)) = @YEAR  and MONTH(convert(date,d.glpostdate)) = 12 and c.FK_iwItemsREN = x.FK_iwItemsREN)as 'December'
	
	FROM psPatinv y
	left outer join psPatitem x on x.FK_TRXNO = y.PK_TRXNO
	left outer join mscWarehouse z on y.FK_mscWarehouse = z.PK_mscWarehouse 
	left outer join iwItems w on x.FK_iwItemsREN = w.PK_iwItems
	left outer join psPatLedgers xx on xx.FK_TRXNO = y.PK_TRXNO
WHERE z.description <> 'Pharmacy' 

GROUP BY z.description,x.FK_iwItemsREN, w.itemdesc 

order by z.description,w.itemdesc 
