Select a.FK_emdPatients,Department,a.discount,description From vwReportsCashSlip a join psPatDiscounts b on a.FK_emdPatients = b.FK_emdPatients join mscDiscounts c on b.FK_mscDiscounts = c.PK_mscDiscounts
Where convert(date,rendate) between '2018-01-01' and '2018-01-31' and Department = 'PHARMACY'


Select b.description,docno,amount,c.description From psPatDiscounts a join mscWarehouse b on a.FK_mscWarehouse =  b.PK_mscWarehouse join mscDiscounts c on c.PK_mscDiscounts = a.FK_mscDiscounts
Where CONVERT(date, glpostdate) between '2018-01-01' and '2018-01-31' and b.description = 'PHARMACY'


sELECT * FROM psPatDiscounts