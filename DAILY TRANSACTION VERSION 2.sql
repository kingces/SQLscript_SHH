declare @From date = '2020-10-01',
@To date = '2020-10-31', 
@PAt NVARCHAR(MAX) = 'ALL'




IF (@Pat = 'INPATIENT')


WITH tab (Department, DOM, QTY) AS
(
    SELECT  b.description,
            DAY(CAST(c.rendate AS DATE)) AS DOM,
            isnull(sum(renqty),0) AS QTY
    FROM    psPatitem a 
	left join mscWarehouse  b on a.FK_mscWarehouse = b.PK_mscWarehouse 
	join psPatinv c on a.FK_TRXNO = c.PK_TRXNO
	where convert(date,c.rendate) between @From and @To and c.pattrantype = 'I'
	group by b.description,c.rendate
	
)
SELECT  *
FROM    tab 
PIVOT 
(
    SUM (QTY) 
    FOR DOM IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],
                [12],[13],[14],[15],[16],[17],[18],[19],[20],[21],
                [22],[23],[24],[25],[26],[27],[28],[29],[30],[31] ) 
	
) AS pvt order by Department


else if (@Pat = 'OUTPATIENT')


WITH tab (Department, DOM, QTY) AS
(
    SELECT  b.description,
            DAY(CAST(c.rendate AS DATE)) AS DOM,
            isnull(sum(renqty),0) AS QTY
    FROM    psPatitem a 
	left join mscWarehouse  b on a.FK_mscWarehouse = b.PK_mscWarehouse 
	join psPatinv c on a.FK_TRXNO = c.PK_TRXNO
	where convert(date,c.rendate) between @From and @To and c.pattrantype = 'O'
	group by b.description,c.rendate
	
)
SELECT  *
FROM    tab 
PIVOT 
(
    SUM (QTY) 
    FOR DOM IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],
                [12],[13],[14],[15],[16],[17],[18],[19],[20],[21],
                [22],[23],[24],[25],[26],[27],[28],[29],[30],[31] ) 
	
) AS pvt order by Department

else

WITH tab (Department, DOM, QTY) AS
(
    SELECT  b.description,
            DAY(CAST(c.rendate AS DATE)) AS DOM,
            isnull(sum(renqty),0) AS QTY
    FROM    psPatitem a 
	left join mscWarehouse  b on a.FK_mscWarehouse = b.PK_mscWarehouse 
	join psPatinv c on a.FK_TRXNO = c.PK_TRXNO
	where convert(date,c.rendate) between @From and @To 
	group by b.description,c.rendate
	
)
SELECT  *
FROM    tab 
PIVOT 
(
    SUM (QTY) 
    FOR DOM IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],
                [12],[13],[14],[15],[16],[17],[18],[19],[20],[21],
                [22],[23],[24],[25],[26],[27],[28],[29],[30],[31] ) 
	
) AS pvt order by Department