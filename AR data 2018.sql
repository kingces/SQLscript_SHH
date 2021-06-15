declare @Datefrom datetime = '8/01/2018'
declare @Dateto datetime = '08/31/2018'

select 
		dbo.udf_GetGLACode(a.PK_faGLA) as [acctcode],
		dbo.udf_GetGLADescription(a.PK_faGLA) as [acctdescription],
		b.glperiod as [RefDate], 
		b.doctype + '-' + convert(varchar, b.docno) as [refNo],
		dbo.udf_GetFullName(b.FK_psDatacenter) as [EntityName],
		sum(b.debit) as [periodDebit],
		sum(b.credit) as [periodCredit],
		b.glbook as [Book],
			[Remarks] = 
	                                -- Payables
			                                Case when b.trangroup = 'AP' and b.doctype = 'JV' 
			                                then (dbo.udf_GetFullName(b.fk_psdatacenter) + ', ' + b.doctype + convert(varchar,b.docno) + ', ' + convert(varchar,b.glperiod,101))
				                                 when b.trangroup = 'AP' and b.doctype = 'AP' then
			                                (select 
			                                isnull(replace(convert(varchar,remarks),'"',''), dbo.udf_getfullname(FK_psDatacenter) + ', ' + aptype + convert(varchar,docno) + ', ' + convert(varchar,docdate))  from faVPMstr where PK_TRXNO = b.FK_TRXNO)
	                                -- Asset Management
				                                 when b.trangroup  = 'AM' then (select top 1 bb.glremarks from iwItemAssetsDPRC aa inner join faJVMstr bb on aa.FK_TRXNO_JV = bb.PK_TRXNO
											                                where bb.PK_TRXNO = b.FK_TRXNO)
	                                -- Cash Receipts
				                                when b.trangroup  = 'CR' and b.doctype  = 'JV' and b.glbook = 'JB' then (select dbo.udf_GetFullName(FK_psDatacenter) +',' + description from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'CR' and b.doctype  = 'OR' and b.glbook = 'CB' then (select payername + ', ' + type + convert(varchar,orno) + ', ' + convert(varchar,ordate,101) from faCRMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup = 'CR' and b.doctype  = 'OR' and b.glbook = 'JB' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + description from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												 
	                                -- Deliveries Receiving
				                                when b.trangroup  = 'RR' and b.doctype  = 'JV' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup  = 'RR' and b.doctype = 'RR' then (select dbo.udf_GetFullName(FK_faVendors) +', ' + 'RR' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwApinv where PK_TRXNO = b.FK_TRXNO)
	                                -- Disbursement Voucher
				                                when b.trangroup  = 'DB' and b.doctype = 'CK' then (select convert(varchar(MAX),remarks)  from faCVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup  = 'DB' and b.doctype  = 'JV' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar(MAX),jvno) +', '+ convert(varchar(MAX),docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
	                                -- Expense Issuance
				                                when b.trangroup = 'EI' and b.doctype = 'JV' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'EI' and b.doctype = 'EI' then (select 'Expense Issuance of ' + dbo.udf_GetDepartmentName(fk_mscwarehouseDST) +', '+ 'EI' + convert(varchar,docno) +', '+ convert(varchar,docdate,101) from iwIssinv where PK_TRXNO = b.FK_TRXNO)
	                                -- Journal Vouchers
				                                --when b.trangroup = 'JV' and b.doctype = 'AC' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                --when b.trangroup = 'JV' and b.doctype = 'JV' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup = 'JV' and b.doctype in ('JV','AC') then (select glremarks from faJVMstr where PK_TRXNO = b.FK_TRXNO)
	                                -- Patient Adjustment
				                                when b.trangroup  = 'AJ' and b.doctype  = 'AJ' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'AJ' and b.doctype = 'JV' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
	                                -- PayerCreditMemos
				                                when b.trangroup  = 'CM' and b.doctype  = 'JV' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'CM' and b.doctype  = 'CM' then (select dbo.udf_GetFullName(fk_facustomers) + ', ' + doctype + convert(varchar,dmcmno) + ' , '+ convert(varchar,remarks) from faDMCMPayer where PK_TRXNO = b.FK_TRXNO)
	                                -- PayeeDebitMemos
				                                when b.trangroup  = 'DM' and b.doctype  = 'JV' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'DM' and b.doctype  = 'DM' then (select dbo.udf_GetFullName(FK_faVendors) + ', ' +doctype + convert(varchar,dmcmno) + ' , '+ convert(varchar,remarks) from faDMCMPayee where PK_TRXNO = b.FK_TRXNO)
	                                --Sales Discount
				                                when b.trangroup = 'SD' and b.doctype  = 'DS' then (select 'Discount transactions' + ', ' +  dbo.udf_GetFullName(FK_emdPatients) + ', ' + convert(varchar,refdate,101)from psPatDiscounts where PK_TRXNO = b.FK_TRXNO)
	                                --Room Discount
				                                when b.trangroup  = 'RD' and b.doctype = 'DS' then (select 'Discount transactions' + ', ' +  dbo.udf_GetFullName(FK_emdPatients) + ', ' + convert(varchar,docdate,101)from psPatDiscountRooms where PK_TRXNO = b.FK_TRXNO)
	                                --Adjustment Discount
				                                when b.trangroup  = 'AD' and b.doctype = 'DS' then (select 'Discount transactions' + ', ' +  dbo.udf_GetFullName(FK_emdPatients) + ', ' + convert(varchar,docdate,101)from psPatDiscountAdj where PK_TRXNO = b.FK_TRXNO)
	                                --PatientRefunds
				                                when b.trangroup = 'PR' and b.doctype  = 'AP' then (select (dbo.udf_getfullname(FK_psDatacenter) + ', ' + isnull(convert(varchar,remarks),'') + ', ' + aptype + convert(varchar,docno) + ', ' + convert(varchar,docdate))  from faVPMstr where PK_TRXNO = b.FK_TRXNO)
	                                --Patient Room Sales
				                                when b.doctype = 'RM' then (select dbo.udf_GetFullName(aaa.FK_emdPatients)
										                                 +', ' + 'Admno ' + Convert(varchar,isnull(bbb.registryno,' ')) 
										                                 +', '+ 'Rm ' + Convert(varchar,aaa.FK_psRooms) +', '+ Convert(varchar,aaa.glpostdate,101)
										                                 from psPatRooms aaa 
										                                 inner join psAdmissions bbb on aaa.FK_psPatRegisters = bbb.FK_psPatRegisters
										                                where aaa.PK_TRXNO = b.FK_TRXNO)
                                -- Petty Cash
				                                when b.doctype  = 'PC'then (select 
												                                (Payeename + ', ' + 'PC' + convert(varchar,Docno) + ', ' + Convert(varchar,remarks) + convert(varchar,docdate,101))
												                                from faPetty 
												                                where (FK_TRXNO_psPatRefund is null or FK_TRXNO_psPatRefund = '') and
												                                PK_TRXNO = 	b.FK_TRXNO	
												                                Union all
												                                select 
												                                (ax.Payeename + ', ' + 'PC' + convert(varchar,ax.Docno) + ', '+ Convert(varchar,ax.remarks) + convert(varchar,ax.docdate,101))
												                                from faPetty ax inner join psPatRefund ab on ax.FK_TRXNO_psPatRefund = ab.PK_TRXNO and
												                                ax.FK_TRXNO_psPatRefund = b.FK_TRXNO)
                                --Purchase Return
			                                when b.trangroup = 'RT' and b.doctype  = 'RT' then (select dbo.udf_GetFullName(FK_faVendors) + 'RT' + convert(varchar,docno) + ', ' + convert(varchar,docdate,101) +' ' + isnull(convert(varchar,remarks),'')
												                                from iwApretinv where PK_TRXNO = b.FK_TRXNO)
			                                when b.trangroup  = 'RT' and b.doctype  = 'JV' then (select dbo.udf_GetFullName(fk_psdatacenter) + ', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO =  b.FK_TRXNO)

                                --Patient Sales
			                                when b.trangroup = 'SA' and b.glbook = 'SB' then (select	dbo.udf_GetFullName(ac.FK_emdPatients) + ', ' 
																						                                   + case when ac.pattrantype = 'O' then 'OPD'
																									                                 when ac.pattrantype = 'E' then 'ERD'
																									                                 else 'IPD' End
																								                                + Convert(varchar,ac.registryno)
																								                                + ', '
																								                                + case when ac.pattrantype = 'I' then
																										                                (select 'Rm' + isnull(convert(varchar,FK_psRooms),'') from psAdmissions where FK_psPatRegisters = ac.PK_psPatRegisters)
																									                                else ''
																																+ Convert(varchar,ac.registrydate,101)
																								                                End		
										                                from psPatRegisters ac inner join psPatLedgers ad on ac.PK_psPatRegisters = ad.FK_psPatRegisters and ad.FK_TRXNO = b.FK_TRXNO)
			                                when b.trangroup  = 'SA' and b.glbook = 'JB' then (select isnull(description,'') + ', ' + isnull(docid,'') + isnull(convert(varchar,jvno),'') + ', '+ isnull(convert(varchar,docdate),'')  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
                                -- Production Assemblies
			                                when b.trangroup = 'PA' and b.doctype = 'JV' then (select  isnull(description,'Production Assembly') + ', ' + docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101)  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
			                                when b.trangroup  = 'PA' and b.doctype  = 'PA' then (select  isnull(convert(varchar,remarks),'Production Assembly')+ ', ' + 'PA' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwProdinv where PK_TRXNO = b.FK_TRXNO)
                                -- Stock Issuances
			                                when b.trangroup  = 'SI' and b.doctype  = 'JV' then (select isnull(description,'Stock Issuances') + ', ' + docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101)  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
			                                when b.trangroup = 'SI' and b.doctype  = 'SI' then (select  isnull(convert(varchar,remarks),'Stock Issuances')+ ', ' + 'SI' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwWhinv where PK_TRXNO = b.FK_TRXNO)
                                -- Quantity Adjustment

			                                when b.trangroup = 'QA' then (select 'Stock Issuances' + ', '+ isnull(convert(varchar,remarks),'')+ ', ' + 'SI' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwAdjinv where PK_TRXNO = b.FK_TRXNO)
								-- Receivables = 
											when b.trangroup = 'AR' and b.glbook = 'JB' then
											(select	
											case when ad.FK_emdPatients = 0 then isnull(ad.remarks,'') 
											else 
											dbo.udf_GetFullName(ac.FK_emdPatients) + ', ' 
																			+ case when ac.pattrantype = 'O' then 'OPD'
																						when ac.pattrantype = 'E' then 'ERD'
																						else 'IPD' End
																				+ Convert(varchar,ac.registryno)
																				+ ', '
																				+ case when ac.pattrantype = 'I' then
																						(select 'Rm' + isnull(convert(varchar,FK_psRooms),'') from psAdmissions where FK_psPatRegisters = ac.PK_psPatRegisters)
																						else ''
																				+ Convert(varchar,ac.registrydate,101)
																				End	
End	
from faArinv ad left outer join psPatRegisters ac on ad.FK_psPatRegisters = ac.PK_psPatRegisters
where ad.PK_TRXNO = b.FK_TRXNO) 

                                else '' End
from faGLA a
		inner join faGL b on b.FK_faGLA = a.PK_faGLA

--and a.FK_faGLAcct in ('22101-020') --insert account codes for extraction
and convert(date,a.glperiod) between @datefrom and @Dateto AND (doctype = 'AP' OR doctype = 'CK') AND dbo.udf_GetFullName(b.FK_psDatacenter) = 'MERCURY DRUG CORP - MALOLOS HIGHWAY'

group by	dbo.udf_GetGLACode(a.PK_faGLA), 
			dbo.udf_GetGLADescription(a.PK_faGLA),
			b.glperiod, b.doctype, 
			b.docno, b.FK_psDatacenter, 
			b.debit, b.credit,
			b.cancelflag, b.postflag, 
			b.auditflag, a.ispostclosing,
			a.isMonthlyClosedFlag,
			a.isAdjustment,
			b.FK_TRXNO,
			b.trangroup,
			b.glbook

order by acctdescription, RefDate



