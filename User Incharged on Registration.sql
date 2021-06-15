Select * From vwReportPatientProfile where patientfullname = 'PADUA, DAISY ROSE TORIO'


select dbo.udf_GetFullName(FK_emdPatients) [Patient],
dbo.udf_GetFullName(FK_ASURegistry) [Registered by] from pspatregisters where PK_psPatRegisters = '469433'