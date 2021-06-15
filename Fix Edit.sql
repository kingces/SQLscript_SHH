select * from psAdmissions where withstillbirth is null
select * from psAdmissions where stillbirth is null

update psAdmissions  set withstillbirth = '0'  where withstillbirth is null
update psAdmissions  set stillbirth = '0'  where stillbirth is null