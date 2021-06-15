select  
	a.registryno,
	a.pattrantype,
	b.fullname2,
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
	a.pattrantype = 'E' and (a.registrydate between '01/01/2017' and '12/31/2017 ') and a.cancelflag = 0