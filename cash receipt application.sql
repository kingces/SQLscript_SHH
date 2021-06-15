--Script to select user who applied OR (for deposit only or indirect application)
select postdate,  postdate,dbo.udf_getfullname(fk_asupost) as userpost,  * from fajvmstr where PK_TRXNO = 178058

--Script to trace user who post / apply OR (for direct application)
select postdate,dbo.udf_getfullname(fk_asupost) as userpost, * from facrmstr where PK_TRXNO = 178058
