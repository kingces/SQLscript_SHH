SELECT			  --k.postdate,
				  --j.FK_mscDiscounts,
					f.PK_psPatRegisters as PatientRegistry,
		          --f.FK_emdPatients as PatientID,
					f.registryno as SOAno,
					d.fullname as PatientName,
					f.pattrantype as PatientRegistryType,
					g.age2,
					f.registrydate AS RegistryDate,
					f.dischdate as DischargeDate,
					g.FK_psRooms,
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters ) - 
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters and (FK_psRooms = 'ICU' OR FK_psRooms = 'IMCU') ) as 'Regular Room Days',
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters and (FK_psRooms = 'ICU' OR FK_psRooms = 'IMCU') ) as 'ICU DAYS',
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters) as 'TOTAL ROOM DAYS',
					f.FK_mscHospPlan,
					h.AdmissionSource,
					
---DEPARMENT CHARGES 				
					 (Select ISNULL(Sum(room.price),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters) as 'RoomCharge',
				     
					 (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem RT join mscWarehouse b on rt.FK_mscWarehouse = b.PK_mscWarehouse  Where 
														RT.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Respiratory') as 'RESPIRATORY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem CT join mscWarehouse b on CT.FK_mscWarehouse = b.PK_mscWarehouse Where 
														CT.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'CT-SCAN') as 'CT-SCAN',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ER join mscWarehouse b on ER.FK_mscWarehouse = b.PK_mscWarehouse Where 
														ER.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Emergency') as EMERGENCY,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
														HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Hemodialysis') as 'HEMODIALYSIS',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem LAB join mscWarehouse b on LAB.FK_mscWarehouse = b.PK_mscWarehouse Where 
														LAB.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'LABORATORY') as 'LABORATORY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem MAM join mscWarehouse b on MAM.FK_mscWarehouse = b.PK_mscWarehouse Where 
														MAM.FK_psPatRegisters = f.PK_psPatRegisters and description = 'MAMMOGRAPHY') as 'MAMMOGRAPHY',

				    (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem OBG join mscWarehouse b on OBG.FK_mscWarehouse = b.PK_mscWarehouse Where 
														OBG.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'OB-Gyne') as 'OBGYNE',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ORDR join mscWarehouse b on ORDR.FK_mscWarehouse = b.PK_mscWarehouse Where 
														ORDR.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'OR/DR') as 'OR/DR',
													
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem PHMCY join mscWarehouse b on PHMCY.FK_mscWarehouse = b.PK_mscWarehouse Where 
														PHMCY.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Pharmacy') as 'PHARMACY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem SHH join mscWarehouse b on SHH.FK_mscWarehouse = b.PK_mscWarehouse Where 
														SHH.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'SHH' ) as 'SHH',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem TRD join mscWarehouse b on TRD.FK_mscWarehouse = b.PK_mscWarehouse Where 
														TRD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Treadmill Stress Test') as 'TREADMILL',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem XRY join mscWarehouse b on XRY.FK_mscWarehouse = b.PK_mscWarehouse Where 
														XRY.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'X-RAY') as 'X-RAY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ECO join mscWarehouse b on ECO.FK_mscWarehouse = b.PK_mscWarehouse  Where 
														ECO.FK_psPatRegisters = f.PK_psPatRegisters and b.description like '%2D ECHO%') as '2DECHO',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem AMB join mscWarehouse b on AMB.FK_mscWarehouse = b.PK_mscWarehouse  Where 
														AMB.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Ambulance (NEW)') as 'Ambulance (NEW)',
--- TOTAL ROOM + CHARGES
				(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ALLD Where 
														ALLD.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as 'TOTAL HB',
-- PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
														PHI.FK_psPatRegisters = b.FK_psPatRegisters AND billtrancode <> 'PF') as 'PHIC HB',			
---HMO
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
														HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') AS 'HMO HB',
--DISCOUNT
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = a.FK_psPatRegisters) AS DISCOUNT,

---net amount
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
													   room.FK_psPatRegisters = f.PK_psPatRegisters) -
-- PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
								PHI.FK_psPatRegisters = b.FK_psPatRegisters AND billtrancode <> 'PF') -	
--hmo														
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
														HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') -
--DISCOUNT
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = a.FK_psPatRegisters and billtrancode <> 'PF') AS 'NetAmount HB',
--PF GROSS
					(SELECT ISNULL(Sum(pfamount + otheramount + instrumentfee),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) AS 'GROSS PF',
--PF PHIC			
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) AS 'PHIC PF',
--PF HMO			
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) AS 'HMO PF',
--PF DISCOUNT			
					(SELECT ISNULL(Sum(discount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS 'DISCOUNT PF',
--PF net amount			
				
					(SELECT ISNULL(Sum(oramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) as 'PF NET AMOUNT',
					
---Refund
					(SELECT ISNULL(Sum(refundamount),0) From faCRMstr Ref Where 
														Ref.FK_psPatRegisters = f.PK_psPatRegisters) AS Refund,					
														
---TOTAL Net Amount
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
													HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
												   room.FK_psPatRegisters = f.PK_psPatRegisters) +
					
					(SELECT ISNULL(Sum(oramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) -
-- PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
						    PHI.FK_psPatRegisters = f.PK_psPatRegisters AND billtrancode <> 'PF') -	
--hmo														
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
							HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') -	
--DISCOUNT
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
													DCT.FK_psPatRegisters = f.PK_psPatRegisters) -
--PF DISCOUNT			
			        (SELECT ISNULL(Sum(refundamount),0) From faCRMstr Ref Where 
														Ref.FK_psPatRegisters = f.PK_psPatRegisters) AS 'NETAMOUNT'																	

					from pspatitem a
					left outer join pspatinv b on a.FK_trxno = b.PK_trxno
					left outer join iwitems c on a.FK_iwItemsREN = c.PK_iwItems
					left outer join psDatacenter d on a.FK_emdPatients = d.PK_psDatacenter	
					left outer join mscWarehouse e on a.FK_mscWarehouse = e.PK_mscWarehouse				
					left outer join psPatregisters f on a.FK_psPatregisters = f.PK_psPatregisters
					left outer join vwReportPatientProfile g on a.FK_psPatregisters = g.PK_psPatregisters
					left outer join vwReportInpatientMstrList_sa h on a.FK_psPatRegisters = h.PK_psPatRegisters 
					left outer join psPatRooms i on a.FK_psPatRegisters = i.FK_psPatRegisters
					left outer join psPatDiscounts j on a.FK_psPatRegisters = j.FK_psPatRegisters
					left outer join psGntrLedgers k on a.FK_psPatRegisters  = k.FK_psPatRegisters

					WHERE convert(date,f.dischdate) between '2017-7-01' and '2017-7-31' and f.registryno = '12892'
					group by
			  --j.FK_mscDiscounts,
			  --k.postdate,
				f.PK_psPatRegisters,
				g.age2,
			  --f.FK_emdPatients,
				f.registryno ,
			   f.pattrantype,
			  --h.registryno,
				d.fullname,
				f.registrydate,
				f.dischdate,
				g.FK_psRooms,
				f.FK_mscHospPlan,
				h.AdmissionSource,
				a.FK_psPatRegisters,
				b.FK_psPatRegisters

				order by 
				f.registryno

					
				

					
