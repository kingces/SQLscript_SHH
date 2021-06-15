Select DATENAME(MONTH, convert(date,x.glpostdate)) as 'MonthName',
	   y.pk_pspatregisters as RegistryNo,
	   y.PatientFullName as FullName,
	   y.TownCity,
	  
	   sum(x.price) as Price

From psPatRooms x
inner join vwReportPatientProfile y on x.FK_psPatRegisters = y.pk_pspatregisters 


Where YEAR(convert(date,glpostdate)) = 2017 and  MONTH(convert(date,x.glpostdate))  = 12

group by 
		  DATENAME(MONTH, convert(date,x.glpostdate)),
		  MONTH(convert(date,x.glpostdate)),
		  y.pk_pspatregisters,
	      y.PatientFullName,
		  y.TownCity
order by MONTH(convert(date,x.glpostdate))

