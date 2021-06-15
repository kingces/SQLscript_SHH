SElect dbo.udf_GetFullName(FK_ASUPost),* From vwReportDischPatient_1 a join psPatRegisters b on a.PK_psPatRegisters = b.PK_psPatRegisters whERE a.PK_psPatRegisters = '283527'

Select dbo.udf_GetFullName(FK_ASUPost),* From faVPMstr Where remarks like '%CABRERA, ANDRES CAPARAS%'

Select * From vwReportDischPatient_1 whERE PK_psPatRegisters = '283527'

Select * From faDMCMPayer WHere  remarks like '%283527%'

SElect dbo.udf_GetFullName(FK_ASUPost),* From vwPsGntrLedger Where FK_psPatRegisters = '283527'