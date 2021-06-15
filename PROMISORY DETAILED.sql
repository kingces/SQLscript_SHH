Select 
	   f.PK_psPatRegisters,
	   a.PatientFullName,
	   a.FK_psRooms as RoomNO	,
	   f.registrydate as AdmissionDate,
	   f.dischdate as DischargeDate	,
	   f.FK_mscHospPlan as HospitalPlan, 
	   
--- TOTAL ROOM + CHARGES
					(SELECT ISNULL(Sum(credit),0) From psPatLedgers PAT	 Where 
														PAT.FK_psPatRegisters = f.PK_psPatRegisters) AS pn,
					
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem RT Where 
														RT.FK_psPatRegisters = f.PK_psPatRegisters and 
														RT.fk_mscitemcategory = 1035) as RESPIRATORY,
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as 'GROSS TOTAL'
	   
	   
From 
vwReportPatientProfile a 
left outer join psPatRegisters f on  a.pk_pspatregisters = f.PK_psPatRegisters
left outer join psPatLedgers g on  a.pk_pspatregisters = g.FK_psPatRegisters
Where (billtrancode = 'PNHB'or billtrancode = 'GAHB' or billtrancode = 'PNPR' or billtrancode = 'PNPR') and g.pattrantype = 'I' 

GROUP BY  a.PatientFullName,
	   a.FK_psRooms ,
	   f.registrydate ,
	   f.dischdate,
	   f.FK_mscHospPlan 
	   ,f.PK_psPatRegisters
---sELECT * fROM psPatRegisters Where PK_psPatRegisters = 26856


--Select * From psPatitem Where FK_psPatRegisters =  26856