SELECT				DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) [month],
					(select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) as [Guarantor],
					(Select COUNT(distinct x.payername) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate)) and x.pattrantype = 'I') [IPD],
					(Select COUNT(distinct x.payername) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate)) and x.pattrantype = 'O') [OPD],
					(Select COUNT(distinct x.payername) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate)) and x.pattrantype = 'E') [ERD],
					(Select COUNT(distinct x.payername) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate))) [TOTAL CENSUS],
					(Select SUM(x.amount) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate)) and x.pattrantype = 'I') [IPD REV],
					(Select SUM(x.amount) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate)) and x.pattrantype = 'O') [OPD REV],
					(Select SUM(x.amount) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate)) and x.pattrantype = 'E') [ERD REV],
					(Select SUM(x.amount) From  psPatinv x Where (dbo.udf_ConcatAllGuarantorsPerRegistry(X.FK_pspatregisters)) = (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)) and convert(date, x.rendate) between '2018-01-01' and '2018-05-31' AND DATENAME(MONTH, CONVERT(DATE, A.glpostdate)) = DATENAME(MONTH, CONVERT(DATE, X.glpostdate))) [TOTAL REV]	
		from pspatinv a	
		 Where
				
				  ((select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'ASIAN LIFE'
		---		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'AYALA AON'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'AVEGA'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'BENLIFE CARE'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'BULACAN MANILA WATER / BMDC'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'CENTRO ESCOLAR UINIVERSITY'
				
			--	or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'CAREHEALTH'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'COCOLIFE'
			--or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'EAST WEST'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'FLEXICARE'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'FORTUNE CARE'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'GENERALI PILIPINAS'
				
			--	or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'HEALTH PLAN OF THE PHILIPPINES, INC. (HPPI)'
			--  or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'HMI'
	---			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) LIKE '%INSULAR%'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'INTELLICARE'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'LACSON & LACSON'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MAXICARE HEALTHCARE, CORPORATION'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDASIA PHILS.'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDICARD PHILS, INC.'
---				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDICARE PLUS'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDILINK'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDOCARE'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MERALCO DIRECT'
				
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'METROCARE HEALTH SYSTEMS, INC.'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MSGI'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'PACIFIC CROSS HEALTH CARE, INC.'
	--			or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'PHILAM LIFE'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'PHILCARE'
		--		or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'SUNLIFE GREPA'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'VALUCARE') and 
				convert(date, a.rendate) between '2018-01-01' and '2018-05-31'
				group by (dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)),
						 DATENAME(MONTH, CONVERT(DATE, A.glpostdate))