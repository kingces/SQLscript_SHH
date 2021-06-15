Select 
		concat(b.PatientLastName,', ',b.PatientFirstName) 'ForCheck',
		a.FK_psPatRegisters as RegistryNo,
		g.OSCAid as OSCAID,
		a.rendate,
		b.PatientFullName as FullName,
		b.age2 as Age,
		b.pattrantype,
		a.FK_iwItemsREN as ItemCode,
		f.itemdesc,
		sum(a.renqty)as Quantity,
		sum(a.renprice * a.renqty)as Amount,
		sum(a.discount) as Discount,
		a.rendate as Rendate
		

		From 

		psPatitem a 
		inner join vwReportPatientProfile b on a.FK_psPatRegisters = b.pk_pspatregisters
		inner join iwItems f on a.FK_iwItemsREN = f.PK_iwItems
		inner join emdPatients g on b.PK_emdpatients = g.PK_emdPatients
		Where convert(date, a.rendate) between '2017-11-01' and '2017-12-31' and  b.age2 > 59 and f.itemgroup = 'MED'

		group by 
		concat(b.PatientLastName,', ',b.PatientFirstName),
		a.FK_psPatRegisters,
		b.PatientFullName,
		b.age2,
		a.FK_iwItemsREN,
		f.itemdesc,
		a.rendate,
		b.pattrantype,
		g.PK_emdPatients
				
				
				seLECT FK_psPatRegisters,orno FROM faCRMstr
				SElect PK_emdPatients,OSCAid from emdPatients

				Select * From emdPatients



