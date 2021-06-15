declare @Datefrom datetime = '12/01/2020'
declare @Dateto datetime = '12/31/2020'

select 
		
	dbo.udf_GetGLACode(a.PK_faGLA) as [acctcode],
		dbo.udf_GetGLADescription(a.PK_faGLA) as [acctdescription],
		b.glperiod as [RefDate], 
		b.doctype + '-' + convert(NVARCHAR(MAX), b.docno) as [refNo],
		dbo.udf_GetFullName(b.FK_psDatacenter) as [EntityName],
		sum(b.debit) as [periodDebit],
		sum(b.credit) as [periodCredit],
		b.glbook as [Book],
			[JE Description] = dbo.RemoveAllSpaces(
	                                -- Payables
			                                --Case when b.trangroup = 'AP' and b.doctype = 'JV' 
			                                --then (dbo.udf_GetFullName(b.fk_psdatacenter) + ', ' + b.doctype + convert(varchar,b.docno) + ', ' + convert(varchar,b.glperiod,101))
				                               -- when b.trangroup = 'AP' and b.doctype = 'AP' then
			                                --(select 
			                                --isnull(remarks, dbo.udf_getfullname(FK_psDatacenter) + ', ' + aptype + convert(varchar,docno) + ', ' + convert(varchar,docdate))  from faVPMstr where PK_TRXNO = b.FK_TRXNO)

											Case when b.glbook='JB' and b.trangroup = 'AP' and b.doctype = 'JV' then
							

											(select  isnull(dbo.udf_getfullname(y.FK_psDatacenter) + ', ' + 'Cancelled Transaction, ' + y.aptype +  convert(varchar,y.docno) + ', ' + convert(varchar,y.docdate), 'Cancelled Transaction ,'+ x.glremarks)  from faJVMstr x left join faVPMstr y on x.FK_TRXNO_CancelTran=y.PK_TRXNO where x.PK_TRXNO = b.FK_TRXNO)
												 when b.glbook='PB' and  b.trangroup = 'AP' and b.doctype = 'AP' then
			                                (select 
			                               Convert(varchar,isnull((remarks),'')) +'' + dbo.udf_getfullname(FK_psDatacenter) + ', ' + aptype + convert(varchar,docno) + ', ' + convert(varchar,docdate)  from faVPMstr where PK_TRXNO = b.FK_TRXNO)

	                                -- Asset Management
				                                --when b.trangroup  = 'AM' then (select top 1 bb.glremarks from iwItemAssetsDPRC aa inner join faJVMstr bb on aa.FK_TRXNO_JV = bb.PK_TRXNO
											 --                        --       where bb.PK_TRXNO = b.FK_TRXNO)
												--when b.glbook='JB' and b.trangroup = 'AM' and b.doctype = 'AM' and b.FK_TRXNO not in (select top 1 x.FK_TRXNO_JV from iwItemAssetsDPRC x ) 
												--and b.FK_TRXNO in (select FK_TRXNO_JV from (select  FK_TRXNO_JV,count(FK_TRXNO_JV) over (partition by FK_TRXNO_JV) as aaa  from iwItemAssets cc where  cc.isPostedfromRR=1  group by FK_TRXNO_JV) aa)
												--then 'Posted From Asset Management Module' 


												--when b.glbook='JB' and b.trangroup = 'AM' and b.doctype = 'AM' and b.FK_TRXNO in (select top 1 x.FK_TRXNO_JV from iwItemAssetsDPRC x ) then 
												--	(select  top 1  bb.glremarks from iwItemAssetsDPRC  aa inner join faJVMstr bb on aa.FK_TRXNO_JV = bb.PK_TRXNO where bb.PK_TRXNO = b.FK_TRXNO)

												when b.glbook='JB' and b.trangroup = 'AM' and b.doctype = 'AM' then (select case when x.PK_TRXNO in (select distinct y.FK_TRXNO_JV from iwItemAssets y where x.PK_TRXNO= y.FK_TRXNO_JV) then x.glremarks
																																 when x.PK_TRXNO in (select distinct y.FK_TRXNO_JVCancel from iwItemAssets y where x.PK_TRXNO= y.FK_TRXNO_JVCancel) then x.glremarks
																																 when x.PK_TRXNO in (select distinct y.FK_TRXNO_JV from iwItemAssetsDPRC y where x.PK_TRXNO= y.FK_TRXNO_JV) then x.glremarks + ', Reference No: ' + (SELECT STUFF((SELECT ',' + cast(a.refno as nvarchar) FROM iwItemAssetsDPRC a where a.FK_TRXNO_JV=b.FK_TRXNO FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, ''))
																																 end from faJVMstr x where x.PK_TRXNO=b.FK_TRXNO)


	                                -- Cash Receipts
				                                --when b.trangroup  = 'CR' and b.doctype  = 'JV' and b.glbook = 'JB' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + description from faJVMstr  where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup  = 'CR' and b.doctype  = 'JV' and b.glbook = 'JB' then (select dbo.udf_GetFullName(FK_psDatacenter) +', '+ case when TranGroup_Cancel is not null then 'Canceled Transaction : ' + glremarks else glremarks end from faJVMstr  where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'CR' and b.doctype  = 'OR' and b.glbook = 'CB' then (select payername + ', ' + type + convert(varchar,orno) + ', ' + convert(varchar,ordate,101) from faCRMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup = 'CR' and b.doctype  = 'OR' and b.glbook = 'JB' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + description from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup = 'CR' and b.doctype  = 'CM' and b.glbook = 'JB' then (select top 1 dbo.udf_GetFullName(FK_psDatacenter) +', ' + cast(remarks as nvarchar) from faDMCMPayer where PK_TRXNO = b.FK_TRXNO)
												
	                                -- Deliveries Receiving
				                                --when b.trangroup  = 'RR' and b.doctype  = 'JV' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup  = 'RR' and b.doctype  = 'JV'  then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) +', Canceled Transaction : ' + glremarks  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup  = 'RR' and b.doctype = 'RR' then (select dbo.udf_GetFullName(FK_faVendors) +', ' + 'RR' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwApinv where PK_TRXNO = b.FK_TRXNO)
	                                -- Disbursement Voucher
				                                --when b.trangroup  = 'DB' and b.doctype = 'CK' then (select convert(varchar,payeename) +', ' + convert(varchar,remarks) +', ' + cvtype + convert(varchar,cvno) +', ' + convert(varchar,cvdate,101)  from faCVMstr where PK_TRXNO = b.FK_TRXNO)
				                                --when b.trangroup  = 'DB' and b.doctype  = 'JV' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)

												when b.trangroup  = 'DB' and b.doctype = 'CK' and b.glbook = 'DB' then (select convert(varchar,payeename) +', ' + convert(varchar,remarks) +', ' + cvtype + convert(varchar,cvno) +', ' + convert(varchar,cvdate,101)  from faCVMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup  = 'DB' and b.doctype = 'CS' and b.glbook = 'DB' then (select convert(varchar,payeename) +', ' + convert(varchar,remarks) +', ' + cvtype + convert(varchar,cvno) +', ' + convert(varchar,cvdate,101)  from faCVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup  = 'DB' and b.doctype  = 'JV' and b.glbook = 'DB' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												when concat(glbook,trangroup,doctype)in ('JBDBCK','JBDBCS') then (select x.glremarks  from faJVMstr x  where x.PK_TRXNO=b.FK_TRXNO)
												when concat(glbook,trangroup,doctype)in ('JBDBJV','JBDBJV') then (select 'Canceled Transaction :' + x.glremarks  from faJVMstr x  where x.PK_TRXNO=b.FK_TRXNO)

	                                -- Expense Issuance
				                                --when b.trangroup = 'EI' and b.doctype = 'JV' then (select  dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'EI' and b.doctype = 'JV' then (select   docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101) + ', ' + isnull(description,'Canceled Transaction') + ', '+ glremarks +  ', '+  (select dbo.udf_GetDepartmentName(FK_mscWarehouseSRC) from iwIssinv where FK_TRXNO_CancelTran=PK_TRXNO)  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup = 'EI' and b.doctype = 'EI' then (select 'Expense Issuance of ' + dbo.udf_GetDepartmentName(fk_mscwarehouseDST) +', '+ 'EI' + convert(varchar,docno) +', '+ convert(varchar,docdate,101) from iwIssinv where PK_TRXNO = b.FK_TRXNO)
	                                -- Journal Vouchers
				                                when b.trangroup = 'JV' and b.doctype = 'AC' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'JV' and b.doctype = 'JV' then (select dbo.udf_GetFullName(FK_psDatacenter) +', ' + isnull((description),'') +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
	                                -- Patient Adjustment
				                                when b.trangroup  = 'AJ' and b.doctype  = 'AJ' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup = 'AJ' and b.doctype = 'JV' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
	                                -- PayerCreditMemos
				                                --when b.trangroup  = 'CM' and b.doctype  = 'JV' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup  = 'CM' and b.doctype  = 'JV' then (select dbo.udf_GetFullName(FK_psDatacenter) +  docid + convert(varchar,jvno) +', Canceled Transaction : '+glremarks from faJVMstr where PK_TRXNO = b.FK_TRXNO)
												when b.trangroup = 'CM' and b.doctype  = 'CM' then (select dbo.udf_GetFullName(fk_facustomers) + ', ' + doctype + convert(varchar,dmcmno) + ' , '+ convert(varchar,remarks) from faDMCMPayer where PK_TRXNO = b.FK_TRXNO)
	                                -- PayeeDebitMemos
				                                --when b.trangroup  = 'DM' and b.doctype  = 'JV' then (select description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
				                                when b.trangroup  = 'DM' and b.doctype  = 'JV' then (select dbo.udf_GetFullName(FK_psDatacenter) + ', ' + docid + convert(varchar,jvno) +', Canceled Transaction : '+ glremarks from faJVMstr where PK_TRXNO = b.FK_TRXNO)
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
				                                --when b.doctype  = 'PC' then (select 
												                        --        (Payeename + ', ' + 'PC' + convert(varchar,Docno) + ', ' + Convert(varchar,remarks) + convert(varchar,docdate,101))
												                        --        from faPetty 
												                        --        where (FK_TRXNO_psPatRefund is null or FK_TRXNO_psPatRefund = '') and
												                        --        PK_TRXNO = 	b.FK_TRXNO	
												                        --        Union all
												                        --        select 
												                        --        (ax.Payeename + ', ' + 'PC' + convert(varchar,ax.Docno) + ', '+ Convert(varchar,ax.remarks) + convert(varchar,ax.docdate,101))
												                        --        from faPetty ax inner join psPatRefund ab on ax.FK_TRXNO_psPatRefund = ab.PK_TRXNO and
												                        --        ax.FK_TRXNO_psPatRefund = b.FK_TRXNO)

				                                when b.trangroup='PC' and b.doctype  = 'PC' then (select 
												                                (Payeename + ', ' + 'PC' + convert(varchar,Docno) + ', ' + Convert(varchar,remarks) + convert(varchar,docdate,101))
												                                from faPetty 
												                                where (FK_TRXNO_psPatRefund is null or FK_TRXNO_psPatRefund = '') and
												                                PK_TRXNO = 	b.FK_TRXNO	
												                                Union all
												                                select 
												                                (ax.Payeename + ', ' + 'PC' + convert(varchar,ax.Docno) + ', '+ Convert(varchar,ax.remarks) + convert(varchar,ax.docdate,101))
												                                from faPetty ax inner join psPatRefund ab on ax.FK_TRXNO_psPatRefund = ab.PK_TRXNO and
												                                ax.FK_TRXNO_psPatRefund = b.FK_TRXNO)
				                                when b.trangroup='PC' and b.doctype  = 'JV' then (select x.glremarks from faJVMstr x where x.TranGroup_Cancel='PC' and x.PK_TRXNO=b.FK_TRXNO)
																				                                
								--Purchase Return
			                                --when b.trangroup = 'RT' and b.doctype  = 'RT' then (select dbo.udf_GetFullName(FK_faVendors) + 'RT' + convert(varchar,docno) + ', ' + convert(varchar,docdate,101) +' ' + isnull(convert(varchar,remarks),'')  from iwApretinv where PK_TRXNO = b.FK_TRXNO)
			                                when b.trangroup = 'RT' and b.doctype  = 'RT' then (select 'Purchase Return of ' + dbo.udf_GetDepartmentName(FK_mscWarehouse) + ', '  + dbo.udf_GetFullName(FK_faVendors) + ', ' +'RT' + convert(varchar,docno) + ', ' + convert(varchar,docdate,101) +' ' + isnull(convert(varchar,remarks),'')  from iwApretinv where PK_TRXNO = b.FK_TRXNO)
											--when b.trangroup  = 'RT' and b.doctype  = 'JV' then (select dbo.udf_GetFullName(fk_psdatacenter) + ', ' + description +', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) from faJVMstr where PK_TRXNO =  b.FK_TRXNO)
											when b.trangroup  = 'RT' and b.doctype  = 'JV' then (select dbo.udf_GetFullName(fk_psdatacenter) + ', ' +  docid + convert(varchar,jvno) +', '+ convert(varchar,docdate,101) + ', ' + description +', ' + glremarks + ', ' + (select dbo.udf_GetDepartmentName(y.FK_mscWarehouse) from iwApretinv y where x.FK_TRXNO_CancelTran=y.PK_TRXNO)  from faJVMstr x where x.PK_TRXNO =  b.FK_TRXNO)

                                --Patient Sales
			                                when b.trangroup = 'SA' and b.glbook = 'SB' then (select distinct	dbo.udf_GetFullName(ac.FK_emdPatients) + ', ' 
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
			                                --when b.trangroup = 'PA' and b.doctype = 'JV' then (select  isnull(description,'Production Assembly') + ', ' + docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101)  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
											when b.trangroup = 'PA' and b.doctype = 'JV' then (select  docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101) + ', '+ isnull(description,'Production Assembly') + ', ' + glremarks +  ', '+  (select dbo.udf_GetDepartmentName(FK_mscWarehouse) from iwProdinv where FK_TRXNO_CancelTran=PK_TRXNO) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
			                                --when b.trangroup  = 'PA' and b.doctype  = 'PA' then (select  isnull(convert(varchar,remarks),'Production Assembly')+ ', ' + 'PA' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwProdinv where PK_TRXNO = b.FK_TRXNO)
											when b.trangroup  = 'PA' and b.doctype  = 'PA' then (select 'Production Assembly of ' + dbo.udf_GetDepartmentName(FK_mscWarehouse)  +  isnull(convert(varchar,remarks),'')+ ', ' + 'PA' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwProdinv where PK_TRXNO = b.FK_TRXNO)
                                -- Stock Issuances
			                                --when b.trangroup  = 'SI' and b.doctype  = 'JV' then (select isnull(description,'Stock Issuances') + ', ' + docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101)  from faJVMstr where PK_TRXNO = b.FK_TRXNO)
											when b.trangroup  = 'SI' and b.doctype  = 'JV' then (select docid + convert(varchar,jvno) + ', '+convert(varchar,docdate,101) + ', ' + isnull(description,'Canceled Transaction') + ', '+ glremarks +  ', '+  (select dbo.udf_GetDepartmentName(FK_mscWarehouseSRC) from iwWhinv where FK_TRXNO_CancelTran=PK_TRXNO) from faJVMstr where PK_TRXNO = b.FK_TRXNO)
			                                --when b.trangroup = 'SI' and b.doctype  = 'SI' then (select  isnull(convert(varchar,remarks),'Stock Issuances')+ ', ' + 'SI' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwWhinv where PK_TRXNO = b.FK_TRXNO)
											when b.trangroup = 'SI' and b.doctype  = 'SI' then (select 'Stock Issuance of ' + dbo.udf_GetDepartmentName(FK_mscWarehouseSRC) + ', ' + 'SI' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwWhinv where PK_TRXNO = b.FK_TRXNO)
                                -- Quantity Adjustment

			                                --when b.trangroup = 'QA' then (select 'Stock Issuances' + ', '+ isnull(convert(varchar,remarks),'')+ ', ' + 'SI' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwAdjinv where PK_TRXNO = b.FK_TRXNO)
											when b.trangroup = 'QA' then (select 'Quantity Adjustment' + ', '+ isnull(convert(varchar,remarks),'')+ ', ' + 'QA' + convert(varchar,docno) +', ' + convert(varchar,docdate,101)  from iwAdjinv where PK_TRXNO = b.FK_TRXNO)
								-- Receivables = 
											when b.trangroup = 'AR' and b.glbook = 'JB' and doctype in ('CH','OT','PF') then
											(select	
																				case when ad.FK_emdPatients = 0 then isnull(ad.remarks,'Manual Creation of AR') 
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
																				End	End
														 
																				from faArinv ad left outer join psPatRegisters ac on ad.FK_psPatRegisters = ac.PK_psPatRegisters
																				where ad.PK_TRXNO = b.FK_TRXNO)
											when concat(glbook,trangroup,doctype)='JBARJV' then (select top 1 y.glremarks from faArinv x left join faJVMstr y on x.PK_TRXNO=y.FK_TRXNO_CancelTran where y.PK_TRXNO=b.FK_TRXNO)

																												else '' End )
		

from faGLA a
		inner join faGL b on b.FK_faGLA = a.PK_faGLA
where auditflag = 1 and cancelflag = 0 and postflag = 1 and FK_faGLA <> 0
and convert(date,a.glperiod) between @datefrom and @Dateto 
--and concat(b.glbook,trangroup,doctype) ='JBCROR'

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