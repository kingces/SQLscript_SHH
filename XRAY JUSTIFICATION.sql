 Select C.description,FORMAT(rendate, 'MM/dd')[DATE],FORMAT(rendate,'hh tt' ) [TIME],sum(a.renqty) [Census] 
 From psPatitem a
 join mscWarehouse c on a.FK_mscWarehouse = c.PK_mscWarehouse
 Where (c.description = 'X-RAY' or c.description = 'CT-SCAN') and CONVERT(date, a.rendate) between '2018-07-05' and '2018-07-19'
 group by C.description,rendate
 order by c.description,FORMAT(rendate,'hh:mm tt'),FORMAT(rendate, 'MM/dd')