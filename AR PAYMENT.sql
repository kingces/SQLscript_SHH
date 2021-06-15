SELECT 
                docno	=	'''',
                particulars = CASE WHEN Particulars IS NULL THEN Remarks ELSE Particulars end, 
                hbamount = sum(HospitalBill), 
                pfamount = sum(ProfessionalFee), 
                others = SUM(Others),
                totalpayment = sum(TotalPayment), 
                paymentdate

                from 
                (SELECT 
                Particulars = case when b.FK_psPatRegisters is null or b.FK_psPatRegisters = ''0'' 
                                    then CONVERT(nvarchar,b.remarks) else
									dbo.udf_GetFullName(b.FK_emdpatients) + '' / Registry No. '' + 
									convert(varchar,c.registryno) + '' / Registry Date - '' + 
									convert(varchar,c.registrydate,101) + '' / '' + 
									case when c.pattrantype = ''I'' then ''IPD'' 
									     when c.pattrantype = ''O'' then ''OPD'' 
									     when c.pattrantype = ''E'' then ''ERD'' end  +  
								    isnull('' / Discharge Date - '' + Convert(nvarchar(10),c.dischdate,101),'''') end,
                HospitalBill = case when b.artype in (''IS'',''RB'',''MC'', ''PH'') then a.credit ELSE 0.00 end,
                ProfessionalFee = case when b.artype in (''PF'') then a.credit ELSE 0.00 end,
                Others = case when b.artype = ''OT'' then a.credit ELSE 0.00 end,
                TotalPayment = a.credit,
                PaymentDate = a.postdate,
                RegisterNo = b.FK_psPatRegisters,
                FK_faCustomers = a.FK_faCustomers,
                FK_TRXNO_CR = FK_TRXNO_CR,
                Remarks = convert(nvarchar,b.remarks)

            FROM faarledgers a
            INNER JOIN faArinv b ON a.FK_TRXNO = b.PK_TRXNO
            left outer join psPatRegisters as c on b.FK_psPatRegisters = c.PK_psPatRegisters
                    where a.artype NOT IN (''CM'',''OR'')
                    AND ((a.crtype is null and a.artype = ''PH'') or a.crtype in (''CM'',''OR''))
                    AND a.doctype IN (''OR'')
                    AND a.credit > 0.00
                    and a.cancelflag = 0
                    and a.deleteflag = 0
                    AND a.postflag = 1
                    --and a.FK_faCustomers = @customerid 
                    and (a.FK_TRXNO = @faCRMstrTrxno or a.FK_TRXNO_CR = @faCRMstrTrxno)) as ARListTable

            GROUP BY Particulars, PaymentDate,  RegisterNo, FK_faCustomers, FK_TRXNO_CR, Remarks