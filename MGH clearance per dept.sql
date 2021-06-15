SElect dbo.udf_GetFullName (FK_emdPatients), * From psPatRegisters Where PK_psPatRegisters = '335824'

select dbo.udf_GetFullName(FK_ASUmghc),FK_ASUmgh,fk_asumghc,FK_ASUuntagmgh,FK_ASUuntagmghc, * from psPatRegisters where PK_psPatRegisters = 335824
select * from psPatMGHClearance where FK_psPatRegisters ='335824'

select  dbo.udf_GetFullName(clearfpduser),dbo.udf_GetDepartmentName(FK_mscWarehouse), * from psNotifyDeptFPD where FK_psPatRegisters = 335824