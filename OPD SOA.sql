Select a.RegistryNo as 'SOANo',
	   a.PatientFullname as 'PatientFullName',
	   a.RegistryDate as 'RegistryDate',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'OR/DR' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'OR/DR',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'PHARMACY' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'PHARMACY',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'LABORATORY' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'LABORATORY',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'CT-SCAN' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'CT-SCAN',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'X-RAY' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'X-RAY',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'MAMMOGRAPHY' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'MAMMOGRAPHY',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description like '%2D ECHO%' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as '2D ECHO SHH',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'Treadmill Stress test' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'Treadmill Stress test',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'Ambulance (NEW)' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'Ambulance (NEW)',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'Emergency' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'Emergency',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'Respiratory' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'Respiratory',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'Hemodialysis' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'Hemodialysis',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'OB-GYNE' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'OB-GYNE',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'SHH' and c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'SHH',
	ISNULL((Select sum(renqty * renprice) from psPatitem x join mscWarehouse y on x.FK_mscWarehouse = y.PK_mscWarehouse Where y.description = 'Pulmonary' and c.FK_psPatRegisters = x.FK_psPatRegisters) ,'0.00')as 'SHH',
	ISNULL((Select sum(renqty * renprice) from psPatitem x Where c.FK_psPatRegisters = x.FK_psPatRegisters),'0.00') as 'HBAmount',
	ISNULL((SELECT ISNULL(Sum(pfamount + otheramount + instrumentfee),0) From psdctrledgers x Where x.FK_psPatRegisters = c.FK_psPatRegisters),'0.00') AS 'PFAmount',
	ISNULL((Select sum(renqty * renprice) from psPatitem x Where c.FK_psPatRegisters = x.FK_psPatRegisters) + (SELECT ISNULL(Sum(pfamount + otheramount + instrumentfee),0) From psdctrledgers x Where x.FK_psPatRegisters = c.FK_psPatRegisters),'0.00') as 'TotalAmount'

	
		    From vwOutPatientsMstrList a 
			left outer join psPatRegisters b on a.RegistryNo = b.registryno
			left outer join psPatitem c on b.PK_psPatRegisters = c.FK_psPatRegisters
			left outer join psPatinv d on c.FK_TRXNO = d.PK_TRXNO

			Where CONVERT(date, a.RegistryDate) between '2017-12-01' and '2017-12-31' and a.Status <> 'x'

			group by 
						a.RegistryNo,
						a.PatientFullname,
						c.FK_psPatRegisters,
						a.RegistryDate