declare @Datefrom datetime = '11/01/2019'
declare @Dateto datetime = '11/30/2019'

select 
		
		sum(b.debit) as [periodDebit],
		sum(b.credit) as [periodCredit]
		

from faGLA a
		inner join faGL b on b.FK_faGLA = a.PK_faGLA
where auditflag = 1 and cancelflag = 0 and postflag = 1 and FK_faGLA <> 0
and convert(date,a.glperiod) between @datefrom and @Dateto 
