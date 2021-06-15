SELECT		
					f.PK_psPatRegisters [RegTracNo],
					f.registryno [RegistryNo],
					g.patid [PatientID],
					f.dischdate,
					d.fullname as 'PatientName',
					g.age2 [Age],
					g.Gender,
					x.AdmissionSource,
					xy.casetype,
					g.Dept,
					f.pattrantype as 'PatientRegistryType',
					f.registrydate as 'RegistryDate',
					f.dischdate as 'DischargeDate',
					g.FK_psRooms as 'RoomNo',
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters ) - (Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters and (FK_psRooms = 'ICU' OR FK_psRooms = 'IMCU') ) as 'Regular Room Days',
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters and (FK_psRooms = 'ICU (HI-INFECT)' OR FK_psRooms = 'ICU (REGULAR)') ) as 'ICU DAYS',
					(Select ISNULL(Sum(noofdays),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters) as 'ALOS',
					f.FK_mscHospPlan as 'HospitalPlan',
					h.priAttdngDoctor as 'AttendingDoctor',
					(select dbo.udf_ConcatAllAdmittingDr(f.PK_psPatRegisters)) 'AdmittingDoctor',
						
					
---DEPARMENT CHARGES 				
					 (Select ISNULL(Sum(room.price),0) from psPatRooms room Where room.FK_psPatRegisters = f.PK_psPatRegisters) as 'RoomCharge',

				     (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem PHMCY join mscWarehouse b on PHMCY.FK_mscWarehouse = b.PK_mscWarehouse Where 
														PHMCY.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Pharmacy') as 'PHARMACY',

					 (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem LAB join mscWarehouse b on LAB.FK_mscWarehouse = b.PK_mscWarehouse Where 
														LAB.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'LABORATORY') as 'LABORATORY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem XRY join mscWarehouse b on XRY.FK_mscWarehouse = b.PK_mscWarehouse Where 
														XRY.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'X-RAY') as 'X-RAY',

				    (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem CT join mscWarehouse b on CT.FK_mscWarehouse = b.PK_mscWarehouse Where 
														CT.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'CT-SCAN') as 'CT-SCAN',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem MAM join mscWarehouse b on MAM.FK_mscWarehouse = b.PK_mscWarehouse Where 
														MAM.FK_psPatRegisters = f.PK_psPatRegisters and description = 'MAMMOGRAPHY') as 'MAMMOGRAPHY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ORDR join mscWarehouse b on ORDR.FK_mscWarehouse = b.PK_mscWarehouse Where 
														ORDR.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'OR/DR') as 'OR/DR',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ER join mscWarehouse b on ER.FK_mscWarehouse = b.PK_mscWarehouse Where 
														ER.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Emergency') as EMERGENCY,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem RT join mscWarehouse b on rt.FK_mscWarehouse = b.PK_mscWarehouse  Where 
														RT.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Respiratory') as 'RESPIRATORY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem SHH join mscWarehouse b on SHH.FK_mscWarehouse = b.PK_mscWarehouse Where 
														SHH.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'SHH' ) as 'SHH',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem AMB join mscWarehouse b on AMB.FK_mscWarehouse = b.PK_mscWarehouse  Where 
												AMB.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Ambulance (NEW)') as 'Ambulance (NEW)',
					
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ECO join mscWarehouse b on ECO.FK_mscWarehouse = b.PK_mscWarehouse  Where 
														ECO.FK_psPatRegisters = f.PK_psPatRegisters and b.description like '%2D ECHO%') as '2DECHO',

				  	(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem TRD join mscWarehouse b on TRD.FK_mscWarehouse = b.PK_mscWarehouse Where 
												TRD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Treadmill Stress Test') as 'TREADMILL',
													
				    (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem OBG join mscWarehouse b on OBG.FK_mscWarehouse = b.PK_mscWarehouse Where 
														OBG.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'OB-Gyne') as 'OBGYNE',
				  
				    (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
														HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Hemodialysis') as 'HEMODIALYSIS',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
														HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'PULMONARY') as 'PULMONARY',
						(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
														HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'AUDIOMETRY') as 'AUDIOMETRY',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
										HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Chemotherapy UNit') as 'Chemotherapy UNit',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
										HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'EEG') as 'EEG',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
										HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Complex Wound Care Clinic') as 'Complex Wound Care Clinic',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
										HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'Rehabilitation Medicine') as 'Rehabilitation Medicine',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
									HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'TELEMEDICINE') as 'TELEMEDICINE',
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD join mscWarehouse b on HD.FK_mscWarehouse = b.PK_mscWarehouse Where 
									HD.FK_psPatRegisters = f.PK_psPatRegisters and b.description = 'On Line Consulta') as 'On Line Consulta',

---TOTAL HB
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ALLD Where 
														ALLD.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as 'TOTAL HB',
---TOTAL PF
					(SELECT ISNULL(Sum(pfamount + otheramount + instrumentfee),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) AS 'GROSS PF',
---ACTUAL CHARGES
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ALLD Where 
														ALLD.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(pfamount + otheramount + instrumentfee),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) AS 'ACTUAL CHARGES' ,
---PHIC HB			
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
														PHI.FK_psPatRegisters = b.FK_psPatRegisters AND billtrancode <> 'PF') as 'PHIC HB',
---PHIC PF			
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) AS 'PHIC PF',
---TOTAL PHIC					
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
														PHI.FK_psPatRegisters = b.FK_psPatRegisters AND billtrancode <> 'PF') +								
														
				    (SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) AS 'TOTAL PHIC',									
---HMO HB
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
														HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') AS 'HMO HB',
---HMO PF			
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) AS 'HMO PF',
---TOTAL HMO
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
														HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') +
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) AS 'TOTAL HMO',
---DISCOUNT HB
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = a.FK_psPatRegisters) AS 'DISCOUNT HB',
---DISCOUNT PF			
					(SELECT ISNULL(Sum(discount + scamount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS 'DISCOUNT PF',
---TOTAL DISCOUNT				
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = a.FK_psPatRegisters) +
					(SELECT ISNULL(Sum(discount + scamount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS 'TOTAL DISCOUNT',
---HB NET AMOUNT
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
													   room.FK_psPatRegisters = f.PK_psPatRegisters) -
---PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
								PHI.FK_psPatRegisters = b.FK_psPatRegisters AND billtrancode <> 'PF') -	
---hmo														
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
														HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') -
---DISCOUNT
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = a.FK_psPatRegisters and billtrancode <> 'PF') AS 'NetAmount HB',
---PF net amount			
					(SELECT ISNULL(Sum(pfamount + instrumentfee + otheramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) - 
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(discount + scamount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) as 'PF NET AMOUNT',												
---TOTAL Net Amount
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
													HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
												   room.FK_psPatRegisters = f.PK_psPatRegisters) +
---PF NET												   					
					(SELECT ISNULL(Sum(pfamount + instrumentfee + otheramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) - 
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(discount + scamount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) -
-- PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
						    PHI.FK_psPatRegisters = f.PK_psPatRegisters AND billtrancode <> 'PF') -	
--hmo														
					(SELECT ISNULL(Sum(gntramount),0) From psPatLedgers HMO Where 
							HMO.FK_psPatRegisters =b.FK_psPatRegisters AND billtrancode <> 'PF') -	
--DISCOUNT
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
													DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS 'NETAMOUNT'	,
--Refund			
			        (SELECT ISNULL(Sum(refundamount),0) From faCRMstr Ref Where 
														Ref.FK_psPatRegisters = f.PK_psPatRegisters)  AS 'Refund',																
					f.dischdiagnosis,
					f.finaldiagnosis,
					f.impression,
					abc.description [Disposition],
					g.Service [ServiceType],
					g.TownCity,
					(select(dbo.udf_ConcatAllGuarantorsPerRegistry(b.FK_psPatRegisters))) [Guarantor] 
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
					left outer join vwNursingServiceMstrList x on f.PK_psPatRegisters = x.PK_psPatRegisters
					left outer join mscDispositions abc on abc.PK_mscDispositions = f.FK_mscDispositions
					left outer join vwReportRegistrationDetails xy on f.PK_psPatregisters = xy.PK_psPatRegisters

					WHERE convert(date,f.dischdate) between '2014-01-01' and '2020-12-31' and f.pattrantype = 'I' and b.docno = 19
					group by
			    
				f.registryno,
				g.patid,
				d.fullname,
			    f.pattrantype,
				f.registrydate,
				f.dischdate,
				g.FK_psRooms,
				f.FK_mscHospPlan,
				h.priAttdngDoctor,
				a.FK_psPatRegisters,
				b.FK_psPatRegisters,
				f.PK_psPatRegisters,
				f.dischdate,
				g.age2,
				f.dischdiagnosis,
				f.finaldiagnosis,
				f.impression,
				g.Service,
				g.TownCity,
				g.Gender,
				x.AdmissionSource,
				g.Dept,
				abc.description,
				xy.casetype
				order by
				f.registryno

