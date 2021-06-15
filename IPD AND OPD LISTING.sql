Select a.registryno [CaseNo], a.PK_psPatRegisters,b.PatientFullName,a.registrydate,a.dischdate,a.pattrantype [PatientType]
From psPatRegisters a join vwReportPatientProfile b on a.PK_psPatRegisters = b.pk_pspatregisters
Where Convert(date,a.registrydate) between '2020-12-03' and '2020-12-05' 