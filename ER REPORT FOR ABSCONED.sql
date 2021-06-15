SElect registrydate,* From vwReportPatientProfile Where CONVERT(date,registrydate) between '2018-12-25' and '2018-12-25' and pattrantype = 'e'

SElect registrydate,* From vwReportPatientProfile Where CONVERT(date,registrydate) between '2018-12-31' and '2018-12-31' and pattrantype = 'e'


Select b.PatientFullName,a.registrydate,mghcdatetime,a.dischdiagnosis,a.isDiedIn48Hours From psPatRegisters a join vwReportPatientProfile b on a.PK_psPatRegisters = b.pk_pspatregisters 
Where CONVERT(date,a.registrydate) between '2018-12-1' and '2019-1-5' and b.pattrantype = 'e'
order by a.registrydate