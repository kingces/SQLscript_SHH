--Script pangcheck nung mga inapplyan na AR ng OR
/*PLEASE FILL UP THE TRXNO IN THE LOWER PORTION OF THE SCRIPT. THE TRXNO CAN BE DERIVED FROM CASH RECEIPTS -> VIEW OR -> 
JOURNAL ACCOUNT ENTRIES - TRACKING NO*/


SELECT * 
FROM
(
Select YEAR(A.ARdate) as [Year],Datename(month,A.ardate) [bMonth],A.orno,A.ORdate,CustomerType,Fullname,SUM(hbamount) as HC/*, A.PaymentDate*/,A.ARDate,A.Particulars from
(

SELECT               
    ORdate,
    orno = Orno,
    CustomerType,
    (select dbo.udf_GetFullName(FK_faCustomers)) as Fullname,
     particulars = CASE WHEN Particulars IS NULL THEN Remarks ELSE Particulars end, 
     hbamount = sum(HospitalBill), 
     pfamount = sum(ProfessionalFee), 
     others = SUM(Others),
    totalpayment = sum(TotalPayment), 
    paymentdate,
	                   
    ARDate
       from 
                (SELECT 
                Particulars = case when b.FK_psPatRegisters is null or b.FK_psPatRegisters = '0' 
                                    then CONVERT(nvarchar,b.remarks) else
         dbo.udf_GetFullName(b.FK_emdpatients) + ' / Registry No. ' + 
         convert(varchar,c.registryno) + ' / Registry Date - ' + 
         convert(varchar,c.registrydate,101) + ' / ' + 
         case when c.pattrantype = 'I' then 'IPD' 
              when c.pattrantype = 'O' then 'OPD' 
              when c.pattrantype = 'E' then 'ERD' end  +  
            isnull(' / Discharge Date - ' + Convert(nvarchar(10),c.dischdate,101),'') end,
                HospitalBill = case when b.artype in ('IS','RB','MC', 'PH') then a.credit ELSE 0.00 end,
                ProfessionalFee = case when b.artype in ('PF') then a.credit ELSE 0.00 end,
                Others = case when b.artype = 'OT' then a.credit ELSE 0.00 end,
                TotalPayment = a.credit,
                membership = d.description,
                PaymentDate = a.postdate,
                RegisterNo = b.FK_psPatRegisters,
                FK_faCustomers = a.FK_faCustomers,
                FK_TRXNO_CR = FK_TRXNO_CR,
                Remarks = convert(nvarchar,b.remarks),
    --e.FK_mscPHICEntities,
    Orno = aa.orno,
    b.docdate as ARDate,
    ORdate = aa.ordate,
    Case when f.description in ('Government Social Insurance System (GSIS)','Indigent','Lifetime Member','Non-NHIP','Not Applicable','Overseas Filipino Workers (OFW)'
,'Overseas Workers Welfare  Administration (OWWA)','Self-Employed','Social Security System (SSS)','Sponsored','Informal Economy','Formal Economy','Non-Paying','PHIC') then 'Philhealth'   else f.description
End as CustomerType
  
            FROM faarledgers a
            left join facrmstr aa ON a.FK_TRXNO_CR = aa.PK_TRXNO
            INNER JOIN faArinv b ON a.FK_TRXNO = b.PK_TRXNO
            left outer join psPatRegisters as c on b.FK_psPatRegisters = c.PK_psPatRegisters
            left outer join mscPHICMemberships as d on c.FK_mscPHICMemberships = d. PK_mscPHICMemberships
          --left outer join psPHICLedgers as e on c.PK_psPatRegisters = e.FK_psPatRegisters
            left outer join mscCustomerTypes f on a.FK_mscCustomerTypes = f.PK_mscCustomerTypes

                    where a.artype NOT IN ('CM','OR')
                    AND ((a.crtype is null and a.artype = 'PH') or a.crtype in ('CM','OR'))
                    AND a.doctype IN ('OR')
                    AND a.credit > 0.00
                    and a.cancelflag = 0
                    and a.deleteflag = 0
                    AND a.postflag = 1
                    --and a.FK_faCustomers = 1487--@customerid --for checking
                    --and (a.FK_TRXNO = '8360914' or a.FK_TRXNO_CR = '8360914')
					and ORdate between '12/01/2020' 
									and '1/18/2021' --Input OR Date range
					and aa.cancelflag <> 1
                    ) as ARListTable

                    
            GROUP BY Particulars, PaymentDate,  RegisterNo, FK_faCustomers, FK_TRXNO_CR, Remarks,membership/*, FK_mscPHICEntities*/, Orno,ARDate,ORdate,CustomerType
            

         )A  
         

         group by A.orno,A.ORdate,CustomerType,Fullname,A.PaymentDate,A.ARDate,A.Particulars
         
         ) S
PIVOT
(
sum(HC)
for [bMonth]
 IN ([January],[February],[March],[April],[May],
    [June],[July],[August],[September],[October],[November],
    [December])
) as PVT1

   order by ORNO--membership