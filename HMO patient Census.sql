SELECT			
		pattrantype,COUNT(distinct payername),sum(amount) [Revenue]
					
		from pspatinv a	
		 Where
				
				  ((select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'ASIAN LIFE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'AYALA AON'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'AVEGA'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'BENLIFE CARE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'BULACAN MANILA WATER / BMDC'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'CENTRO ESCOLAR UINIVERSITY'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'CAREHEALTH'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'COCOLIFE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'EAST WEST'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'FLEXICARE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'FORTUNE CARE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'GENERALI PILIPINAS'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'HEALTH PLAN OF THE PHILIPPINES, INC. (HPPI)'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'HMI'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) LIKE '%INSULAR%'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'INTELLICARE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'LACSON & LACSON'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MAXICARE HEALTHCARE, CORPORATION'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDASIA PHILS.'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDICARD PHILS, INC.'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDICARE PLUS'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDILINK'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MEDOCARE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MERALCO DIRECT'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'METROCARE HEALTH SYSTEMS, INC.'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'MSGI'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'PACIFIC CROSS HEALTH CARE, INC.'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'PHILAM LIFE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'PHILCARE'
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'SUNLIFE GREPA'
				
				or (select(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters))) = 'VALUCARE') and 
				convert(date, a.rendate) between '2019-12-01' and '2019-12-31'

				group by pattrantype
			