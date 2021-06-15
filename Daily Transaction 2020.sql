select [DEPARTMENT],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],
							[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31] from
(

Select  b.description [Department],(select renqty from psPatitem X join psPatRegisters y on x.FK_psPatRegisters = y.PK_psPatRegisters where a.FK_TRXNO = x.FK_TRXNO and y.pattrantype = 'I' AND DATENAME(MONTH, rendate) = 'july' and YEAR(rendate) = 2020 ) [QTY],
 (select  DAY(CONVERT(DATE, rendate)) from psPatitem X join psPatRegisters y on x.FK_psPatRegisters = y.PK_psPatRegisters where a.FK_TRXNO = x.FK_TRXNO AND Y.pattrantype  = 'I' AND DATENAME(MONTH, rendate) = 'july' and YEAR(rendate) = 2020 ) [MONTHDATE] from psPatitem a 
left join mscWarehouse b on a.FK_mscWarehouse = b.PK_mscWarehouse 
WHERE DATENAME(MONTH, rendate) = 'july' and YEAR(rendate) = 2020 


) AS Src
PIVOT
(
sum(QTY) for MONTHDATE IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],
							[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])
) AS PVT




