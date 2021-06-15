--Hospital Charges
declare
	@startdate date, @enddate date
--AS

set @startdate = '12/01/2020' -- Document Date
set @enddate = '1/20/2021'

select  *
from (
Select YEAR(A.docdate) as [Year],Datename(month,A.docdate) [bMonth]/*,month(A.docdate)MonthDate*/,A.CustomerType,
fullname = dbo.udf_GetFullName(a.FK_faCustomers)/*,A.Artype*/,SUM(A.debit) HBAmount/*,SUM(A.cramount) ORpayment,sum(A.cmamount) as CM*/
from
(
SELECT a.PK_faArledgers, a.FK_TRXNO, a.FK_TRXNO_CM, a.FK_TRXNO_CR, 
ARdate = CASE WHEN a.artype NOT IN ('OR', 'CM') THEN a.docdate ELSE NULL END, 
ledgerDate = a.docdate, a.docdate, a.artype, a.doctype, a.docno, a.FK_faCustomers,/*fullname = dbo.udf_GetFullName(a.FK_faCustomers),*/  a.debit, credit = 0.00, a.cramount, a.cmamount, a.aramount
,CONVERT(varchar,a.docdate,101)as Date,
a.FK_mscCustomerTypes,
Case when b.description in ('Government Social Insurance System (GSIS)','Indigent','Lifetime Member','Non-NHIP','Not Applicable','Overseas Filipino Workers (OFW)'
,'Overseas Workers Welfare  Administration (OWWA)','Self-Employed','Social Security System (SSS)','Sponsored','Informal Economy','Non-Paying') then 'Philhealth'   else description
End as CustomerType

FROM         faArledgers AS a
left outer join mscCustomerTypes b on a.FK_mscCustomerTypes = b.PK_mscCustomerTypes
WHERE     ((a.artype IN ('CM', 'OR') AND a.doctype IN ('OR', 'CM')) OR
                      (a.artype NOT IN ('CM', 'OR') AND a.doctype NOT IN ('OR', 'CM'))) AND a.cancelflag = 0 AND a.deleteflag = 0
                      and a.artype in ('IS','MC','RB','PH')
and Convert(date, a.docdate) between @startdate and @enddate --and FK_faCustomers = 1545--1461

)A
group by A.docdate,A.artype,A.FK_faCustomers,A.CustomerType
) S
PIVOT
(
sum(HBAmount)
for [bMonth]
 IN ([January],[February],[March],[April],[May],
    [June],[July],[August],[September],[October],[November],
    [December])
) as PVT1