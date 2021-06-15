sELECT c.patid [BARCODE],
a.PK_psPatRegisters,c.PatientFullName,C.FK_psRooms,d.Category,
FK_mscHospPlan [Membership],a.impression [CC],dischdiagnosis [DX],(select dbo.udf_ConcatAllAttendingDr(a.PK_psPatRegisters)) [AP],
	(select dbo.udf_ConcatAllAdmittingDr(a.PK_psPatRegisters)) [ROD],mghcdatetime,a.dischdate,a.mghdatetime
	fROM psPatRegisters a 
	join vwReportPatientProfile c on c.pk_pspatregisters = a.PK_psPatRegisters 
	join SHHDB.dbo.ERrevised d on a.PK_psPatRegisters = d.Pk_Pspatresgiter
	join mscDispositions e on e.PK_mscDispositions = a.FK_mscDispositions
	Where a.pattrantype = 'E' and convert(date,a.registrydate) between '2019-01-08' and '2019-01-8'
	order by d.Category