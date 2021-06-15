Declare @YEAR VARCHAR(20) = 2017,
		@dep varchar (20) = 'Emergency'

SELECT 
	   DATENAME(MONTH, convert(date,x.glpostdate)),z.description,w.PK_iwItems,w.itemdesc,
	

	  (Select ISNULL(FORMAT(sum(b.renqty),'0'),0) From psPatinv a left outer join psPatitem b on a.PK_TRXNO = b.FK_TRXNO left outer join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left outer join psPatLedgers e on e.FK_TRXNO = a.PK_TRXNO left outer join iwItems f on b.FK_iwItemsREN = f.PK_iwItems Where DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate)) AND (a.pattrantype = 'E' OR a.pattrantype = 'O') and w.PK_iwItems = f.PK_iwItems and z.description = c.description) as 'Procedure TOTAL (OPD+ERD)',
	  (Select ISNULL(FORMAT(sum(b.renqty * b.renprice),'0,00.00'),0) From psPatinv a left outer join psPatitem b on a.PK_TRXNO = b.FK_TRXNO left outer join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left outer join psPatLedgers e on e.FK_TRXNO = a.PK_TRXNO left outer join iwItems f on b.FK_iwItemsREN = f.PK_iwItems Where DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate)) AND (a.pattrantype = 'E' OR a.pattrantype = 'O') and w.PK_iwItems = f.PK_iwItems and z.description = c.description) as 'Revenue TOTAL (OPD+ERD)',
	  (Select ISNULL(FORMAT(sum(b.renqty),'0'),0) From psPatinv a left outer join psPatitem b on a.PK_TRXNO = b.FK_TRXNO left outer join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left outer join psPatLedgers e on e.FK_TRXNO = a.PK_TRXNO left outer join iwItems f on b.FK_iwItemsREN = f.PK_iwItems Where DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate)) AND (a.pattrantype = 'I') and w.PK_iwItems = f.PK_iwItems and z.description = c.description) as 'Procedure TOTAL (IPD)',
	  (Select ISNULL(FORMAT(sum(b.renqty * b.renprice),'0,00.00'),0) From psPatinv a left outer join psPatitem b on a.PK_TRXNO = b.FK_TRXNO left outer join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left outer join psPatLedgers e on e.FK_TRXNO = a.PK_TRXNO left outer join iwItems f on b.FK_iwItemsREN = f.PK_iwItems Where DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate)) AND (a.pattrantype = 'I') and w.PK_iwItems = f.PK_iwItems and z.description = c.description) as 'Revenue TOTAL (IPD)',
	  (Select ISNULL(FORMAT(sum(b.renqty),'0'),0) From psPatinv a left outer join psPatitem b on a.PK_TRXNO = b.FK_TRXNO left outer join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left outer join psPatLedgers e on e.FK_TRXNO = a.PK_TRXNO left outer join iwItems f on b.FK_iwItemsREN = f.PK_iwItems Where DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate)) AND w.PK_iwItems = f.PK_iwItems and z.description = c.description) as 'TOTAL Procedure (IPD+OPD+ERD)',
	  (Select ISNULL(FORMAT(sum(b.renqty * b.renprice),'0,00.00'),0) From psPatinv a left outer join psPatitem b on a.PK_TRXNO = b.FK_TRXNO left outer join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse left outer join psPatLedgers e on e.FK_TRXNO = a.PK_TRXNO left outer join iwItems f on b.FK_iwItemsREN = f.PK_iwItems Where DATENAME(MONTH,convert(date,a.glpostdate)) = DATENAME(MONTH,convert(date,x.glpostdate)) and YEAR(convert(date,X.glpostdate)) =YEAR(convert(date,a.glpostdate)) AND w.PK_iwItems = f.PK_iwItems and z.description = c.description) as 'Revenue Procedure (IPD+OPD+ERD)'
	 

FROM psPatinv x 
		left outer join psPatitem y on x.PK_TRXNO = y.FK_TRXNO 
		left outer join mscWarehouse  z on x.FK_mscWarehouse = z.PK_mscWarehouse 
		left outer join psPatRegisters v on x.FK_psPatRegisters = v.PK_psPatRegisters
		left outer join iwItems w on y.FK_iwItemsREN = w.PK_iwItems
		left outer join psPatLedgers xx on xx.FK_TRXNO = x.PK_TRXNO
		wHERE YEAR(convert(date,X.glpostdate)) = @YEAR  and  MONTH(convert(date,x.glpostdate)) = 8

GROUP BY 
		 z.description,
		 w.PK_iwItems,
		 w.itemdesc,
		 w.PK_iwItems,
		 YEAR(convert(date,x.glpostdate)), 
		 MONTH(convert(date,x.glpostdate)), 
		 DATENAME(MONTH, convert(date,x.glpostdate))

		 order by MONTH(convert(date,x.glpostdate)),z.description,w.PK_iwItems
 
