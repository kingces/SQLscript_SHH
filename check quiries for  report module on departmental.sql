SELECT	
		e.description as 'Department',
		  ReceiptNo = stuff(isnull((select ', '  ReceiptNo from vwCashReceiptsMstrList as aa inner join faCrmstrItems as     bb on aa.PK_TRXNO = bb.FK_TRXNO_faCRMstr where bb.FK_psPatitem = a.PK_psPatitem and aa.FK_psPatregisters = a.FK_psPatregisters and aa.cancelflag = 0 for XML path('')),','), 1,1,''),  
           b.doctype as 'Doctype',b.docno as 'DocNo',  
             a.FK_iwItemsREN as 'ItemCode',c.itemdesc as 'ItemDescription',a.renqty as 'Quantity',a.renprice as 'Price',  
                                                                        (a.renqty * a.renprice) as 'Amount',  
                                                                        (select isnull(sum(isnull(amount, 0)), 0) from pspatdiscountitems where FK_psPatitems = a.PK_psPatitem) as 'Discount', 
                                                                        (a.renqty * a.renprice) - (select isnull(sum(isnull(amount, 0)), 0) from pspatdiscountitems where FK_psPatitems = a.PK_psPatitem) as 'Net Amount', 
                                                                        f.registryno as 'RegistryNo',  
                                                                        Replace(d.fullname,'''','') as 'Patientname',  
                                                                        h.age2 as 'Age',Replace(h.SCCardno,'''','') as 'SCD ID',case when h.age2 < 19 then 'PEDIA' WHEN h.age2 between 19 and 59 then 'WORKING' ELSE 'SENIOR' END as 'Age Distribution',  
                                                                        g.pattrantype as 'RegistryType',g.HospitalPlan as 'Hospital Plan',  
                                                                        (select Replace(cast(dbo.udf_ConcatAllGuarantorsPerRegistry(a.FK_pspatregisters)AS nvarchar(MAX)), '''','')) as 'Guarantors',  
                                                                        g.rooms as 'RoomNo',h.TownCity as 'Location',  
                                                                        f.registrydate as 'Registry Date', f.dischdate as 'Discharge Date',  
                                                                        b.reqdate as 'Request Date',a.rendate as 'Rendate',  
                                                                        Replace(cast(dbo.udf_GetFullName(b.fk_asurequser) AS nvarchar(MAX)), '''','') as 'ReqUser',  
                                                                         Replace(cast(dbo.udf_GetFullName(b.fk_asurenuser) AS nvarchar(MAX)), '''','') as 'RenUser',  
                                                                        Replace(cast(dbo.udf_GetFullName(b.FK_emdDoctors) AS nvarchar(MAX)), '''','') as 'ReqDr',  
                                                                        (select Replace(cast(dbo.udf_ConcatAllAdmittingDr(f.PK_psPatRegisters) AS nvarchar(MAX)), '''','') as 'AdmittingDr',  
                                                                        (select Replace(cast(dbo.udf_ConcatAllAttendingDr(f.PK_psPatRegisters) AS nvarchar(MAX)), '''','') as 'AttendingDr',
                                                                        concat(Replace(CAST(b.renremarks AS nvarchar(MAX)),'''',''),'/ ',Replace(CAST(b.reqremarks AS nvarchar(MAX)),'''',''),'/ ',Replace(CAST(f.remarks AS nvarchar(MAX)),'''','')) as 'Remarks'
					from pspatitem a
					left outer join pspatinv b on a.FK_trxno = b.PK_trxno
					left outer join iwitems c on a.FK_iwItemsREN = c.PK_iwItems
					left outer join psDatacenter d on a.FK_emdPatients = d.PK_psDatacenter
					left outer join mscWarehouse e on a.FK_mscWarehouse = e.PK_mscWarehouse				
					left outer join psPatregisters f on a.FK_psPatregisters = f.PK_psPatregisters
					left outer join vwreportregistrationdetails g on g.PK_psPatRegisters = a.fk_psPatRegisters
					left outer join vwReportPatientProfile h on h.PK_psPatRegisters = a.fk_psPatRegisters

					where CONVERT(date,b.rendate) between '1/01/2015' and '1/31/2015' and E.description = 'pharmacy'
					