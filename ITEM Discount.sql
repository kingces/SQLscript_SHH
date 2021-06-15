Select b.payername,a.rendate,CONCAT(doctype,'-',docno)[Docno],c.itemdesc,a.renqty,sum(a.renqty * renprice) [Amount],a.discount,sum(a.renqty * renprice) - a.discount [Total] 
From  psPatitem a join psPatinv b on a.FK_TRXNO = b.PK_TRXNO join iwItems c on a.FK_iwItemsREN = c.PK_iwItems join psPatRegisters d on b.FK_psPatRegisters = d.PK_psPatRegisters
Where convert(date,a.rendate) between '2018-05-01' and '2018-07-31' --and

---( d.registryno= '22535' or  d.registryno = '22577' or d.registryno = '22597' or d.registryno = '22679' or d.registryno = '22708' or d.registryno = '22712' or d.registryno = '22722' or d.registryno = '22723' or d.registryno = '22725' or 
---d.registryno = '22728' or d.registryno = '22729' or d.registryno = '22732' or d.registryno = '22734' or d.registryno = '22745' or d.registryno = '22746' or d.registryno = '22747' or d.registryno = '22749' or d.registryno = '22751' or 
---d.registryno = '22756' or d.registryno = '22757' or d.registryno = '22758' or d.registryno = '22762' or d.registryno = '22764' or d.registryno = '22766' or d.registryno = '22770' or d.registryno = '22771' or d.registryno = '22773' or d.registryno = '22774' )---



group by b.payername,CONCAT(doctype,'-',docno),c.itemdesc,a.renqty,a.discount,a.rendate
order by b.payername
