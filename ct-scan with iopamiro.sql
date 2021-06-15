Declare @YEAR VARCHAR(20) = 2016

Select 	
				DATENAME(MONTH, convert(date,a.rendate)),
				e.description,
				a.FK_psPatRegisters,
				g.PatientFullName,
				a.FK_iwItemsREN,
				c.itemdesc,
				isnull((Select sum(x.renqty) from pspatitem x left outer join pspatinv y on x.FK_trxno = y.PK_trxno left outer join iwitems z on x.FK_iwItemsREN = z.PK_iwItems left outer join mscWarehouse v on x.FK_mscWarehouse = v.PK_mscWarehouse left outer join psPatregisters w on x.FK_psPatregisters = w.PK_psPatregisters left outer join vwReportPatientProfile xx on w.PK_psPatRegisters = xx.pk_pspatregisters
				Where x.FK_psPatRegisters = a.FK_psPatRegisters and  MONTH(convert(date,a.rendate)) = MONTH(convert(date,x.rendate)) AND YEAR(convert(date,a.rendate)) = YEAR(convert(date,x.rendate)) and v.PK_mscWarehouse = e.PK_mscWarehouse and w.pattrantype <> 'I'),0) as 'OPD CENSUS',
				isnull((Select sum(x.renqty) from pspatitem x left outer join pspatinv y on x.FK_trxno = y.PK_trxno left outer join iwitems z on x.FK_iwItemsREN = z.PK_iwItems left outer join mscWarehouse v on x.FK_mscWarehouse = v.PK_mscWarehouse left outer join psPatregisters w on x.FK_psPatregisters = w.PK_psPatregisters left outer join vwReportPatientProfile xx on w.PK_psPatRegisters = xx.pk_pspatregisters
				Where x.FK_psPatRegisters = a.FK_psPatRegisters and  MONTH(convert(date,a.rendate)) = MONTH(convert(date,x.rendate)) AND YEAR(convert(date,a.rendate)) = YEAR(convert(date,x.rendate)) and v.PK_mscWarehouse = e.PK_mscWarehouse and w.pattrantype = 'I'),0) as 'IPD CENSUS',		
				isnull((Select sum(x.renqty) from pspatitem x left outer join pspatinv y on x.FK_trxno = y.PK_trxno left outer join iwitems z on x.FK_iwItemsREN = z.PK_iwItems left outer join mscWarehouse v on x.FK_mscWarehouse = v.PK_mscWarehouse left outer join psPatregisters w on x.FK_psPatregisters = w.PK_psPatregisters left outer join vwReportPatientProfile xx on w.PK_psPatRegisters = xx.pk_pspatregisters
				Where x.FK_psPatRegisters = a.FK_psPatRegisters and  MONTH(convert(date,a.rendate)) = MONTH(convert(date,x.rendate)) AND YEAR(convert(date,a.rendate)) = YEAR(convert(date,x.rendate)) and v.PK_mscWarehouse = e.PK_mscWarehouse ),0) as 'TOTAL CENSUS',

				isnull((Select sum(x.renqty * x.renprice) from pspatitem x left outer join pspatinv y on x.FK_trxno = y.PK_trxno left outer join iwitems z on x.FK_iwItemsREN = z.PK_iwItems left outer join mscWarehouse v on x.FK_mscWarehouse = v.PK_mscWarehouse left outer join psPatregisters w on x.FK_psPatregisters = w.PK_psPatregisters left outer join vwReportPatientProfile xx on x.FK_psPatRegisters = xx.pk_pspatregisters
				Where x.FK_psPatRegisters = a.FK_psPatRegisters and   MONTH(convert(date,a.rendate)) = MONTH(convert(date,x.rendate)) AND YEAR(convert(date,a.rendate)) = YEAR(convert(date,x.rendate)) and v.PK_mscWarehouse = e.PK_mscWarehouse and w.pattrantype <> 'I'),0) as 'OPD REVENUE',
				isnull((Select sum(x.renqty * x.renprice) from pspatitem x left outer join pspatinv y on x.FK_trxno = y.PK_trxno left outer join iwitems z on x.FK_iwItemsREN = z.PK_iwItems left outer join mscWarehouse v on x.FK_mscWarehouse = v.PK_mscWarehouse left outer join psPatregisters w on x.FK_psPatregisters = w.PK_psPatregisters left outer join vwReportPatientProfile xx on x.FK_psPatRegisters = xx.pk_pspatregisters
				Where x.FK_psPatRegisters = a.FK_psPatRegisters and  MONTH(convert(date,a.rendate)) = MONTH(convert(date,x.rendate)) AND YEAR(convert(date,a.rendate)) = YEAR(convert(date,x.rendate)) and v.PK_mscWarehouse = e.PK_mscWarehouse and w.pattrantype = 'I'),0) as 'IPD REVENEUE',		
				isnull((Select sum(x.renqty            * x.renprice) from pspatitem x left outer join pspatinv y on x.FK_trxno = y.PK_trxno left outer join iwitems z on x.FK_iwItemsREN = z.PK_iwItems left outer join mscWarehouse v on x.FK_mscWarehouse = v.PK_mscWarehouse left outer join psPatregisters w on x.FK_psPatregisters = w.PK_psPatregisters left outer join vwReportPatientProfile xx on x.FK_psPatRegisters = xx.pk_pspatregisters
				Where x.FK_psPatRegisters = a.FK_psPatRegisters and  MONTH(convert(date,a.rendate)) = MONTH(convert(date,x.rendate)) AND YEAR(convert(date,a.rendate)) = YEAR(convert(date,x.rendate)) and v.PK_mscWarehouse = e.PK_mscWarehouse ),0) as 'TOTAL REVENUE'
					
					from pspatitem a
					left outer join pspatinv b on a.FK_trxno = b.PK_trxno
					left outer join iwitems c on a.FK_iwItemsREN = c.PK_iwItems
					left outer join mscWarehouse e on a.FK_mscWarehouse = e.PK_mscWarehouse
					left outer join psPatregisters f on a.FK_psPatregisters = f.PK_psPatregisters
					left outer join vwReportPatientProfile g on a.FK_psPatRegisters = g.pk_pspatregisters Where
					
					YEAR(convert(date,a.rendate)) = @YEAR and (a.FK_iwItemsREN ='PHMEDIO0000000347' or a.FK_iwItemsREN = 'M13008609')

					group by 
								e.description,
								a.FK_psPatRegisters,
								c.itemdesc,
								a.FK_iwItemsREN,
								g.PatientFullName,
								MONTH(convert(date,a.rendate)),
								YEAR(convert(date,a.rendate)),
								DATENAME(MONTH, convert(date,a.rendate)),
								e.PK_mscWarehouse
								
								
							
								 
					order by MONTH(convert(date,a.rendate)),e.description


				