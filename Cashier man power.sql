sELECT a.orno,
	   a.PayorName, 
	   Isnull((Select case when b.pattrantype = 'I' THEN 'Inpatient' When b.pattrantype = 'O' THEN 'Outpatient' When b.pattrantype = 'E' THEN 'Emergency'  end From psPatRegisters b Where a.FK_psPatRegisters = b.PK_psPatRegisters),'Others') as RegistryType,
	   a.ordate,
	   a.postdate,
	   CashierName,
	   ORAmount,
	   ORNos
			fROM vwReportCashiersSummary a 
			 Where convert(date,ordate) between '2016-07-1' and '2016-08-31'
ORDER BY orno