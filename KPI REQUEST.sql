---ipd


select distinct
	b.registryno as CaseNo,
	a.DischargeDate,
	dbo.udf_CaseType(c.PK_psPatRegisters) as CaseType,
	--d.roomrate,
	dbo.udf_GetDisposition(b.fk_mscdispositions) as Disposition,
	dbo.udf_Getfullname(c.FK_ASURegistry) as admclerk,
	c.impression,
	
	b.TownCity,
	a.PatientFullname,
	isnull(datediff(day, c.registrydate,c.dischdate),0) as RoomALOS,
	--ISNULL(Sum(noofdays),0) as RoomALOS,
	a.Age,
	case when a.age between 0 and 18 then 'Pedia' when a.age between 19 and 59 then 'Working' else 'Senior Citizen' end as AgeDis,
	a.Sex,a.RegistryDate,
	a.PatientCode,
	e.OSCAid,
	a.HospPlan,

STUFF((SELECT '; ' + yyy.Guarantor 
    FROM vwReportInpatientMstrList_sa yyy
    WHERE yyy.PK_psPatRegisters = e.PK_psPatRegisters
    FOR XML PATH('')), 1, 1, '') [guarantor],
e.AdmissionSource,
	a.RegistryCode,
	a.FK_psRooms,
	a.PHIC,
	a.ServiceType,
	a.priAdmitDoctor,
	a.priAttdngDoctor,
	a.impression
 from vwReportInpatientMstrList a 
 left outer join vwReportPatientProfile b on a.PK_psPatRegisters = b.pk_pspatregisters 
 left outer join psPatRooms d on a.PK_psPatRegisters = d.FK_psPatRegisters
 left outer join vwReportInpatientMstrList_sa e on a.PK_psPatRegisters = e.PK_psPatRegisters
 left outer join pspatregisters c on c.PK_psPatRegisters = b.PK_pspatregisters
 where convert(date, a.RegistryDate, 101) between '2021-01-01' and '2021-5-31' and a.cancelflag <> 1 and 	dbo.udf_GetDisposition(b.fk_mscdispositions)  = 'THOC'

 group by 
		b.TownCity,
		a.PatientFullname,
		a.Age,
		a.Sex,
		a.RegistryDate,
		a.PatientCode,
		e.OSCAid,
		a.HospPlan,
		e.AdmissionSource,
		a.RegistryCode,
		a.FK_psRooms,
		a.PHIC,
		a.ServiceType,
		a.priAdmitDoctor,
		a.priAttdngDoctor,
		a.impression,
		e.PK_psPatRegisters,
		b.registryno,
		a.DischargeDate,
		b.pattrantype,
		d.roomrate,
		b.fk_mscdispositions,
		c.FK_ASURegistry,
		c.impression,
		c.PK_psPatRegisters,
		c.dischdate,c.registrydate



---opd and er
select  
	a.registryno,
	a.pattrantype,
	b.fullname,
	a.registrydate,
	b.praddress,
	c.age2,
	d.gender,
	d.civilstatus,
	dbo.udf_CaseType(a.PK_psPatRegisters) AS CaseType,
	dbo.udf_ConcatAllGuarantorsPerRegistry(a.PK_psPatRegisters) as GuarantorName,
	a.impression,
	dbo.udf_ConcatAllAttendingDr(a.PK_psPatRegisters) as AttendingDoctor,
	dbo.udf_ConcatAllAdmittingDr(a.PK_psPatRegisters) as AdmittingDoctor,
	a.mrremarks,
	a.FK_mscHospTranTypes,
	f.description as HospTranTypes,
	a.hospno
from 
	psPatRegisters a
	inner join psDatacenter b on a.FK_emdPatients = b.PK_psDatacenter
	inner join vwReportPatientProfile c on a.PK_psPatRegisters = c.pk_pspatregisters
	inner join psPersonaldata d on a.FK_emdPatients = d.PK_psPersonalData	
	inner join mscHospTranTypes f on a.FK_mscHospTranTypes = f.PK_mscHospTranTypes
where
	a.pattrantype <> 'i' and convert(date, a.RegistryDate, 101) between '2021-01-01' and '2021-5-31' and a.cancelflag <> 1 and 	dbo.udf_GetDisposition(b.fk_mscdispositions)  = 'THOC'