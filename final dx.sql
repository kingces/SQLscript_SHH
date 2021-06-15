Select b.PatientFullName, a.finaldiagnosis,a.dischdiagnosis,a.registrydate,dischdate,(select dbo.udf_ConcatAllAttendingDr(a.PK_psPatRegisters)) [AttyPhy],b.patid,b.PK_emdpatients,a.PK_psPatRegisters,c.description [Disposition]
From psPatRegisters a join vwReportPatientProfile b on a.PK_psPatRegisters = b.pk_pspatregisters join mscDispositions c on a.FK_mscDispositions = c.PK_mscDispositions 
Where convert(Date,a.registrydate) between '2019-07-1' and '2019-07-31' and a.pattrantype = 'I'
order by registrydate desc