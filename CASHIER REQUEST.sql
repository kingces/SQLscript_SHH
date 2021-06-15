Select 
  DATENAME(MONTH, CONVERT(DATE, a.ordate)) [date],reverse(stuff(reverse(case when cashamount > 0 then 'Cash/' else '' end + case when checkamount > 0 then 'Check/' else '' end + case when cardamount > 0 then 'Card/' else '' end), 1,1,'')) [PAYMENT_TYPE],
			[ormaount] = SUM(a.cashamount + a.checkamount + a.cardamount),
			[accommodation] = ISNULL((select SUM(amount) from faCRMstrRooms where FK_TRXNO_faCRMstr = a.PK_TRXNO),0),
			[PF]= ISNULL((select SUM(amount) from faCRMstrPF where FK_TRXNO_faCRMstr = a.PK_TRXNO),0),
			case when b.pattrantype = 'O' OR b.pattrantype = 'E' THEN 'OUTPATIENT' else 'INPATIENT' end [PATIENT_TYPE]
			 From faCRMstr a join psPatRegisters b on a.FK_psPatRegisters = b.PK_psPatRegisters Where CONVERT(DATE,a.ordate) BETWEEN '2019-01-01' and '2019-06-30'
			 GROUP BY a.ordate,a.PK_TRXNO,a.cashamount,a.checkamount,a.cardamount,b.pattrantype