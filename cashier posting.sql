--FOR DEPOSIT ONLY THEN REAPPLY
select dbo.udf_getfullname(fk_asupost) as userreapply, * from faJVMstr where glremarks like '%17515%'
--FOR DIRECT OR
select dbo.udf_getfullname(fk_asupost) as userpost, *from faCRMstr where orno = '17515'