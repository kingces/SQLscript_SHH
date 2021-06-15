declare @startdate date = '2017-08-25',
	    @enddate date = '2017-08-25'

select 
	b.TownCity,
	a.PatientFullname,ISNULL(Sum(noofdays),0) as RoomALOS,
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
 where convert(varchar, a.RegistryDate, 101) between @startDate and @endDate and a.cancelflag <> 1

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
		e.PK_psPatRegisters