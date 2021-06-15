select
				                                            fk_faCustomers, 
                                                            Doctype, 
															docdate,
                                                            Refno, 
                                                            Description, 
                                                            Debit = sum(Debit), 
                                                            Credit = Sum(Credit), 
                                                            CrHB = sum(CrHB),
                                                            CrPF = sum(CrPF), 
                                                            CrOthers = sum(CrOthers), 
                                                            OutstandingBalance = Sum(OutstandingBalance), 
                                                            orcancelamount = sum(orcancelamount), 
                                                            arcancelamount = sum(arcancelamount), 
                                                            cmcancelamount = sum(cmcancelamount), 
                                                            cmamount = sum(cmamount), 
                                                            aramount = sum(aramount),
                                                            cramount = sum(cramount),
                                                            postflag,
                                                            cancelflag,
                                                            deleteflag,
                                                            hospbillcancelcr,
                                                            proffeecancelcr,
                                                            otherscancelcr

                                            from
                                           (select   fk_faCustomers, 
                                                    Doctype, 
													docdate,
                                                    Refno, 
                                                    convert(nvarchar(max),Remarks) as Description, 
                                                    Debit = sum(Debit), 
                                                    Credit = Sum(Credit), 
                                                    CrHB = sum(CrHB),
                                                    CrPF = sum(CrPF), 
                                                    CrOthers = sum(CrOthers), 
                                                    OutstandingBalance = Sum(OutstandingBalance), 
                                                    orcancelamount = sum(orcancelamount), 
                                                    arcancelamount = sum(arcancelamount), 
                                                    cmcancelamount = sum(cmcancelamount), 
                                                    cmamount = sum(cmamount), 
                                                    aramount = sum(aramount),
                                                    cramount = sum(cramount),
                                                    postflag,
                                                    cancelflag,
                                                    deleteflag,
                                                    artype,
                                                    hospbillcancelcr,
                                                    proffeecancelcr,
                                                    otherscancelcr
                                                        
                                            from
                                                                    (select  a.FK_TRXNO,
                                                                            a.fk_facustomers,
                                                                            a.artype,
																			a.docdate
                                                                            ,[Doctype] = replace(a.doctype, 'CH', 'AR')
                                                                            ,[RefNo] =	case when a.doctype <> 'CH' then a.docno else
                                                                                            case when b.FK_psPatRegisters > '0' then c.registryno else a.docno  end end
                                                                            ,[Remarks] = case when a.doctype = 'OR' then d.remarks
                                                                                                when a.doctype = 'CM' then e.remarks 
                                                                                                    when a.doctype = 'OT' then b.remarks else
                                                                                            case when b.FK_psPatRegisters is null or b.FK_psPatRegisters = '0' then b.remarks else
                                                                            dbo.udf_GetFullName(c.FK_emdpatients) + '/' + 'Registry No. - ' + convert(varchar,c.registryno) + ' / ' + 'Registry Date - ' 
																			+ convert(varchar,c.registrydate,101) + '/' 
																			+ case when c.pattrantype = 'I' then 'IPD' when c.pattrantype = 'O' then 'OPD' when c.pattrantype = 'E' then 'ERD' end  
																			+  isnull(' / Discharge Date - ' + Convert(nvarchar(10),c.dischdate,101),'') 
																			+ case when dbo.udf_getBillNoBillingSchedSum(b.FK_psPatRegisters) = '' then '' else isnull(' / Bill No. - ' + dbo.udf_getBillNoBillingSchedSum(b.FK_psPatRegisters), '') end end end
                                                                            ,Debit = isnull(a.debit,'') + isnull(a.orcancelamount,'') + isnull(a.cmcancelamount,'')
                                                                            ,Credit = isnull(a.cramount,'') + isnull(a.cmamount,'')+ isnull(a.arcancelamount,'')
                                                                            ,CrHB = isnull(a.hospbillcr,'')
                                                                            ,CrPF = isnull(a.proffeecr,'')
                                                                            ,CrOthers = isnull(a.otherscr,'')
                                                                            ,OutstandingBalance =case when a.doctype = 'CH'  then
                                                                                    isnull(b.amount,'') - (isnull(b.oramount,'')+isnull(b.cnamount,''))
                                                                                    when a.doctype = 'CM' then isnull(e.amount,'') - (isnull(e.HospBillCr,'')+isnull(e.ProfFeeCr,'')+isnull(e.OthersCr,''))
                                                                                    else isnull(d.totalamount,'')-isnull(appliedamount,'') end,
                                                                                    a.orcancelamount,
                                                                                    a.arcancelamount, 
                                                                                    a.cmcancelamount, 
                                                                                    a.cmamount, 
                                                                                    a.aramount, 
                                                                                    a.cramount,
					                                                                a.postflag,
					                                                                a.cancelflag,
					                                                                a.deleteflag,
                                                                                    a.hospbillcancelcr,
                                                                                    a.proffeecancelcr,
                                                                                    a.otherscancelcr
                                                                    from 
                                                                                    faarledgers as a
                                                                                    left outer join faArinv as b on a.FK_TRXNO = b.PK_TRXNO
                                                                                    left outer join psPatRegisters as c on b.FK_psPatRegisters = c.PK_psPatRegisters
                                                                                    left outer join faCRMstr as d on a.FK_TRXNO = d.PK_TRXNO
                                                                                    left outer join faDMCMPayer as e on a.FK_TRXNO = e.PK_TRXNO
                                                                    				
                                                                    where
                                                                        a.postflag = 1 
                                                                        and a.deleteflag = 0  and a.credit = 0
                                                                  
                                                                        and a.docdate between  '2014-1-1' and '2019-1-31'  
                                                                         and ((a.artype in ('IS', 'MC', 'RB', 'PH') and a.debit > 0) or (a.artype = 'OR' and a.hospbillcr > 0) or (a.artype = 'CM' and a.hospbillcr > 0))
                                                                        )as a
                                                                        group by 
                                                                                fk_faCustomers, 
                                                                                Doctype, 
                                                                                Refno, 
																				docdate,
                                                                                convert(nvarchar(max),Remarks),
                                                                                postflag,
                                                                                cancelflag,
                                                                                deleteflag,
                                                                                artype,
                                                                                hospbillcancelcr,
                                                                                proffeecancelcr,
                                                                                otherscancelcr) as A
                                                                 group by
                                                                 fk_faCustomers, 
                                                                        Doctype, 
																		docdate,
                                                                        Refno, 
                                                                        Description,
                                                                        postflag,
                                                                        cancelflag,
                                                                        deleteflag,
                                                                        hospbillcancelcr,
                                                                        proffeecancelcr,
                                                                        otherscancelcr