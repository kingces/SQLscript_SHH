declare @startDate date = '2017-01-01',
		@enddate date = '2017-01-31'


select b.TownCity,a.PatientFullname,a.Age,case when a.age between 0 and 18 then 'pedia' when a.age between 19 and 59 then 'working' else 'Senior Citizen' end as AgeDis ,a.Sex,a.RegistryDate,a.PatientCode,a.OSCAid,a.HospPlan,a.Guarantor,a.AdmissionSource,a.RegistryCode,a.FK_psRooms,a.PHIC,a.ServiceType,a.priAdmitDoctor,a.priAttdngDoctor,a.Address,a.impression
 from vwReportInpatientMstrList_sa a 
 left outer join vwReportPatientProfile b on a.PK_psPatRegisters = b.pk_pspatregisters 
 where convert(varchar, a.RegistryDate, 101) between @startDate and @endDate and cancelflag <> 1