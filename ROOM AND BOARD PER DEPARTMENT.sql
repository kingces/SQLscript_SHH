Declare  @Sdate date = '2017-01-01',
		 @Edate date = '2017-01-31'

		Select  (Select Count(distinct PatientFullName) From psPatRooms f join vwReportPatientProfile x on f.FK_psPatRegisters = x.pk_pspatregisters Where Convert(date, f.glpostdate) between  @Sdate and @Edate  and e.FK_psRooms = f.FK_psRooms) as 'Patient Count',
		e.FK_psRooms,
	  (Select ISNULL(sum(f.price),0) From psPatRooms f Where Convert(date, f.glpostdate) between  @Sdate and @Edate  and e.FK_psRooms = f.FK_psRooms ) as RoomRevenue,
	  (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'CT-SCAN' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'CT-SCAN',
	  (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Emergency' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as Emergency,
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Hemodialysis' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as Hemodialysis,
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Laboratory' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as Laboratory,
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Mammography' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as Mammography,
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'OB-Gyne' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'OB-Gyne',
	(Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'OR/DR' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'OR-DR',
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Pharmacy' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as Pharmacy,
	(Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Respiratory' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'Respiratory',
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'SHH' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as SHH,
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'Treadmill Stress Test' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'Treadmill Stress Test',
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and b.description = 'X-RAY' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'X-RAY',
	 (Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and (b.description = '2D ECHO SHH' or b.description = '2D ECHO') and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as '2D ECHO SHH',
	(Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO	
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and  b.description = 'Ambulance (NEW)' and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms) as 'ambulance',
	(Select ISNULL(sum(y.renqty  * y.renprice),0)From pspatinv a inner join psPatitem y on a.PK_TRXNO = y.FK_TRXNO		
			inner join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse	
			inner join psPatRooms z on z.FK_psPatRegisters = a.FK_psPatRegisters
			Where convert(date, a.glpostdate) between @Sdate and @Edate and a.pattrantype = 'i' AND e.FK_psRooms = z.FK_psRooms)+
	(Select ISNULL(sum(f.price),0) From psPatRooms f Where Convert(date, f.glpostdate) between  @Sdate and @Edate  and e.FK_psRooms = f.FK_psRooms ) as 'TOTAL REVENUE'

		from  pspatinv D 
	
		inner join psPatRooms E on D.FK_psPatRegisters = E.FK_psPatRegisters
		

		Where convert(date, e.glpostdate) between @Sdate and @Edate 

	 group by e.FK_psRooms
	 order by e.FK_psRooms