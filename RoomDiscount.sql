Select b.PatientFullName,a.glpostdate,PK_TRXNO,a.FK_psRooms,a.noofdays,a.oramount,discount, sum(oramount - discount) [Total]
From psPatRooms a join vwReportPatientProfile b on a.FK_emdPatients = b.PK_emdpatients

Where convert(date,a.glpostdate) between '2018-06-01' and '2018-07-31' and

(a.FK_emdPatients = '7355' or  
a.FK_emdPatients = '114736' or 
a.FK_emdPatients = '2902' or 
a.FK_emdPatients = '44294' or 
a.FK_emdPatients = '18641' or 
a.FK_emdPatients = '67685' or 
a.FK_emdPatients = '16809' or 
a.FK_emdPatients = '46173' or 
a.FK_emdPatients = '4840' or 
a.FK_emdPatients = '24795' or 
a.FK_emdPatients = '57860' or 
a.FK_emdPatients = '79386' or 
a.FK_emdPatients = '75216' or 
a.FK_emdPatients = '111805' or 
a.FK_emdPatients = '57926' or 
a.FK_emdPatients = '97850' or 
a.FK_emdPatients = '5131' or 
a.FK_emdPatients = '115430' or 
a.FK_emdPatients = '33299' or 
a.FK_emdPatients = '24332' or 
a.FK_emdPatients = '115470' or 
a.FK_emdPatients = '78823' or 
a.FK_emdPatients = '108991' or 
a.FK_emdPatients = '115549' )



group by b.PatientFullName,a.glpostdate,PK_TRXNO,a.FK_psRooms,a.noofdays,a.oramount,discount

order by b.PatientFullName