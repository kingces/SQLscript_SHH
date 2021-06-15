Select B.itemdesc,sum(renqty) [qty],sum(renqty * renprice) [Amount],DATENAME(month, rendate) AS 'Month Name' From pspatitem a 
join iwitems b on a.FK_iwItemsREN = b.PK_iwItems
join psPatRegisters c on a.FK_psPatRegisters = c.PK_psPatRegisters
join mscWarehouse d on a.FK_mscWarehouse = d.PK_mscWarehouse
Where convert(date,rendate) between '2019-1-01' and '2019-10-31' and d.description = 'LABORATORY'
group by B.itemdesc,renqty,DATENAME(month, rendate)