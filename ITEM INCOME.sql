	  Declare @YEAR VARCHAR(20) = 2018,
        @dep varchar (20) = 'Pharmacy'
		

SELECT 


	  y.FK_iwItemsREN [ItemCode],w.itemdesc,zzz.itemcategory,
	  
	  
	  
	  
	  (Select ISNULL (sum(b.renqty),0) From psPatinv a join psPatitem b on a.PK_TRXNO = b.FK_TRXNO join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters  join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO Where CASE WHEN convert(date,a.glpostdate) < '04/01/2018' THEN d.pattrantype else a.pattrantype end = 'I' AND  b.FK_iwItemsREN = y.FK_iwItemsREN and z.description = c.description and  DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate))) as 'IPD TOTAL CENSUS',
	  (Select ISNULL (sum(b.renqty),0) From psPatinv a join psPatitem b on a.PK_TRXNO = b.FK_TRXNO join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters  join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO Where CASE WHEN convert(date,a.glpostdate) < '04/01/2018' THEN d.pattrantype else a.pattrantype end <> 'I'AND b.FK_iwItemsREN = y.FK_iwItemsREN and z.description = c.description AND DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate))) as 'OPD TOTAL CENSUS',
	  (Select ISNULL (sum(b.renqty),0) From psPatinv a join psPatitem b on a.PK_TRXNO = b.FK_TRXNO join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters  join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO Where b.FK_iwItemsREN = y.FK_iwItemsREN and z.description = c.description) as 'TOTAL CENSUS',
	  --TOTAL REVENUE
	  (Select ISNULL(FORMAT(sum(b.renqty * b.renprice),'0,00.00'),0) From psPatinv a join psPatitem b on a.PK_TRXNO = b.FK_TRXNO join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO Where CASE WHEN convert(date,a.glpostdate) < '04/01/2018' THEN d.pattrantype else a.pattrantype end = 'I'   and b.FK_iwItemsREN = y.FK_iwItemsREN and z.description = c.description AND DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate))) as 'IPD TOTAL REVENUE',
	  (Select ISNULL(FORMAT(sum(b.renqty * b.renprice),'0,00.00'),0) From psPatinv a join psPatitem b on a.PK_TRXNO = b.FK_TRXNO join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO  Where CASE WHEN convert(date,a.glpostdate) < '04/01/2018' THEN d.pattrantype else a.pattrantype end <> 'I' and b.FK_iwItemsREN = y.FK_iwItemsREN and z.description = c.description AND DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate))) as 'OPD TOTAL REVENUE',
	  (Select ISNULL(FORMAT(sum(b.renqty * b.renprice),'0,00.00'),0) From psPatinv a join psPatitem b on a.PK_TRXNO = b.FK_TRXNO join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO  Where b.FK_iwItemsREN = y.FK_iwItemsREN and z.description = c.description AND DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate))) as 'TOTAL REVENUE'

FROM psPatinv x 
		join psPatitem y on x.PK_TRXNO = y.FK_TRXNO 
		join mscWarehouse z on x.FK_mscWarehouse = z.PK_mscWarehouse 
		join psPatRegisters v on x.FK_psPatRegisters = v.PK_psPatRegisters
		join iwItems w on y.FK_iwItemsREN = w.PK_iwItems
		join psPatLedgers xyz on xyz.FK_TRXNO = x.PK_TRXNO
		join vwHISItemsMstrList ZZZ on zzz.PK_iwItems = w.PK_iwItems
	
		wHERE convert(date,X.glpostdate) between '2018-12-01' AND '2018-12-31' AND z.description = @dep

GROUP BY 
		y.FK_iwItemsREN,w.itemdesc, z.description,zzz.itemcategory
		,DATENAME(MONTH,convert(date,x.glpostdate)),YEAR(convert(date,x.glpostdate))
 
order by  w.itemdesc