select  

	a.registryno,
	b.fullname,
	a.registrydate,
	a.FK_mscHospPlan as HospitalPlan,
	dbo.udf_ConcatAllGuarantorsPerRegistry(a.PK_psPatRegisters) as GuarantorName,
	g.AdmissionSource,
	h.description as ServiceType,
	c.FK_psRooms as ROomNo,
	i.RoomType as RoomClassification,
	c.age2,
	d.gender,
	d.civilstatus,
	 CAST(d.cpaddress AS NVARCHAR(100)) [address],
	a.casetype,
	--e.CaseType,
	a.impression,
	a.dischdiagnosis,
	a.dischdate,
	isnull(datediff(day, a.registrydate,a.dischdate),0) as [no of days diff],
	--e.DischargeDate,
	dbo.udf_ConcatAllAttendingDr(a.PK_psPatRegisters) as AttendingDoctor,
	dbo.udf_GetPrimaryAdmitDoctor(a.PK_psPatRegisters) AS AdmittingDoctor,
	--e.AdmittingDoctor,
	a.mrremarks,
	a.pattrantype as RegistryType,
	a.hospno

from psPatRegisters a
	inner join psDatacenter b on
		a.FK_emdPatients = b.PK_psDatacenter
	inner join vwReportPatientProfile c on
		a.PK_psPatRegisters = c.pk_pspatregisters
	inner join psPersonaldata d on
		a.FK_emdPatients = d.PK_psPersonalData
	--inner join vwReportRegistrationDetails e on
	--	a.FK_emdPatients = e.FK_emdPatients
	inner join vwNursingServiceMstrList g on
		a.PK_psPatRegisters = g.PK_psPatRegisters
	inner join mscServiceType h on
		a.FK_mscServiceType =  h.PK_mscServiceType
	inner join vwRoomAndBedsMstrList i on
		c.FK_psRooms = i.PK_psRooms


where
	YEAR(convert(date,a.registrydate)) = 2021 and a.cancelflag = 0

	GROUP BY
	a.registryno,
	b.fullname,
	a.registrydate,
	a.FK_mscHospPlan ,
	dbo.udf_ConcatAllGuarantorsPerRegistry(a.PK_psPatRegisters) ,
	g.AdmissionSource,
	h.description ,
	c.FK_psRooms ,
	i.RoomType ,
	c.age2,
	d.gender,
	d.civilstatus,
    CAST(d.cpaddress AS NVARCHAR(100)),
	a.casetype,
	--e.CaseType,
	a.impression,
	a.dischdiagnosis,
	a.dischdate,
isnull(datediff(day, a.registrydate,a.dischdate),0),
	--e.DischargeDate,
	dbo.udf_ConcatAllAttendingDr(a.PK_psPatRegisters),
	dbo.udf_GetPrimaryAdmitDoctor(a.PK_psPatRegisters) ,
	--e.AdmittingDoctor,
	a.mrremarks,
	a.pattrantype,
	a.hospno
