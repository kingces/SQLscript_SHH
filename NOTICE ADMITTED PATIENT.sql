SELECT  
				    f.registrydate AS RegistryDate,
					f.registryno as RegistryNo,
					a.FK_psPatRegisters as PatientID,
					g.FK_psRooms as Room,
					i.Department as NurseStation,
					d.fullname as PatientName,
					
					
---TOTAL HB					
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as 'HOSPITAL BILL',
--PF
					(SELECT ISNULL(Sum(pfamount + otheramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters)	-
			
					(SELECT ISNULL(Sum(discount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) 'PROFESSIONAL FEE',

---STATEMENT					
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(pfamount + otheramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) -			
					(SELECT ISNULL(Sum(discount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS 'STATEMENT',
---BALANCE				
		
		
				    (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(pfamount + otheramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT  ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters)  -
     				(SELECT ISNULL(Sum(discount * renqty),0) From psPatitem DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters and discount < 0) -
					(SELECT ISNULL(Sum(oramount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters)  -
					(SELECT ISNULL(Sum(gntramount),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(gntramount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters)  -
					(SELECT ISNULL(Sum(phicamount),0) From psPatitem PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters)  -
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(discount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(phicamount),0) From psPatRooms PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters)
														AS BALANCE,
						
--DISCOUNT
					
					(SELECT  ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters)  +
					 (SELECT ISNULL(Sum(discount * renqty),0) From psPatitem DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters and discount < 0) AS DISCOUNT,
		
---HMO
					(SELECT ISNULL(Sum(gntramount),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(gntramount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters)			as HMO,
-- PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatitem PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(phicamount),0) From psPatRooms PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters)	as PHIC,	

--Payment					
					(SELECT ISNULL(Sum(oramount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS PAYMENT


					from pspatitem a
					left outer join pspatinv b on a.FK_trxno = b.PK_trxno
					left outer join iwitems c on a.FK_iwItemsREN = c.PK_iwItems
					left outer join psDatacenter d on a.FK_emdPatients = d.PK_psDatacenter	
					left outer join mscWarehouse e on a.FK_mscWarehouse = e.PK_mscWarehouse				
					left outer join psPatregisters f on a.FK_psPatregisters = f.PK_psPatregisters
					left outer join vwReportPatientProfile g on a.FK_psPatregisters = g.PK_psPatregisters
					left outer join psAdmissions h on a.FK_psPatregisters = h.FK_psPatRegisters
					left outer join vwNursingServiceMstrList i on a.FK_psPatRegisters = i.PK_psPatRegisters
					WHERE f.registrydate between '2017-2-01' and '2017-3-1' and f.pattrantype = 'I' and 
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) +
					(SELECT ISNULL(Sum(pfamount + otheramount),0) From psdctrledgers PF Where 
														PF.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT  ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters)  -
     				(SELECT ISNULL(Sum(discount * renqty),0) From psPatitem DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters and discount < 0) -
					(SELECT ISNULL(Sum(oramount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters)  -
					(SELECT ISNULL(Sum(gntramount),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(gntramount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters)  -
					(SELECT ISNULL(Sum(phicamount),0) From psPatitem PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(gntramount),0) From psdctrledgers HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters)  -
					(SELECT ISNULL(Sum(phicamount),0) From psdctrledgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(discount),0) From psdctrledgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) -
					(SELECT ISNULL(Sum(phicamount),0) From psPatRooms PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) > 0 and 

					
					(SELECT ISNULL(Sum(oramount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) > 0
					


					group by
				    f.registrydate,
					f.registryno,
					a.FK_psPatRegisters,
					g.FK_psRooms,
					i.Department,
					d.fullname
					,f.PK_psPatRegisters
					
				

					
