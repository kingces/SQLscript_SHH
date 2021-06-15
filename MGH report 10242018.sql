SELECT a.PK_psPatRegisters,PatientFullname,a.registrydate,a.dischdate,mghdatetime,c.FK_psRooms,b.NurseStation 
FROM psPatRegisters a join vwReportInpatientMstrList_sa b on a.PK_psPatRegisters = b.PK_psPatRegisters join psPatRooms c on a.PK_psPatRegisters = c.FK_psPatRegisters
Where CONVERT(DATE, a.dischdate) between '2018-09-01' and '2018-10-26' and C.FK_psRooms <> 'ER'
group by a.PK_psPatRegisters,PatientFullname,a.registrydate,a.dischdate,mghdatetime,c.FK_psRooms,b.NurseStation  