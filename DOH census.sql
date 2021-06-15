Select count(b.pk_pspatregisters) from vwReportPatientProfile 
a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters  where  convert(date, a.registrydate) between '2020-01-01' and '2020-12-31' and a.pattrantype = 'O'  and age2 between 0 and 200 and b.cancelflag = 0



Select pk_pspatregisters from vwReportPatientProfile a  where  convert(date, a.registrydate) between '2020-01-01' and '2020-12-31' and a.pattrantype = 'O'  and age2 between 0 and 200 


Select * from vwReportPatientProfile a  where  convert(date, a.registrydate) between '2020-01-01' and '2020-12-31' and a.pattrantype = 'O' and age2 is null

select cancelflag,* From psPatRegisters  where pk_pspatregisters = '441393'


  

