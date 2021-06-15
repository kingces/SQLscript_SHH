SELECT  
				
					f.PK_psPatRegisters as PatientRegistry,
					f.FK_emdPatients as PatientID,
					f.registryno as SOAno,
					d.fullname as PatientName,
					f.registrydate AS RegistryDate,
---DEPARMENT CHARGES				
					(Select ISNULL(Sum(room.price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as RoomCharge,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem CT Where 
														CT.FK_psPatRegisters = f.PK_psPatRegisters and 
														CT.fk_mscitemcategory = 1005) as 'CT-SCAN',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ER Where 
														ER.FK_psPatRegisters = f.PK_psPatRegisters and 
														ER.fk_mscitemcategory = 1034) as EMERGENCY,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HD Where 
														HD.FK_psPatRegisters = f.PK_psPatRegisters and 
														(HD.fk_mscitemcategory = 1015 OR
														 HD.fk_mscitemcategory = 1033)) as HEMODIALYSIS,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem LAB Where 
														LAB.FK_psPatRegisters = f.PK_psPatRegisters and 
														LAB.fk_mscitemcategory = 1017) as LABORATORY,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem MAM Where 
														MAM.FK_psPatRegisters = f.PK_psPatRegisters and 
														MAM.fk_mscitemcategory = 1003) as MAMMOGRAPHY,

				    (SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem OBG Where 
														OBG.FK_psPatRegisters = f.PK_psPatRegisters and 
														OBG.fk_mscitemcategory = 1043) as OBGYNE,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem ORDR Where 
														ORDR.FK_psPatRegisters = f.PK_psPatRegisters and 
														ORDR.fk_mscitemcategory = 1009) as 'OR/DR',
													
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem PHMCY Where 
														PHMCY.FK_psPatRegisters = f.PK_psPatRegisters and 
														(PHMCY.fk_mscitemcategory = 1001 or 
														 PHMCY.fk_mscitemcategory = 1002 or
														 PHMCY.fk_mscitemcategory = 1013 or
														 PHMCY.fk_mscitemcategory = 1025 or 
														 PHMCY.fk_mscitemcategory = 1038 )) as PHARMACY,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem RT Where 
														RT.FK_psPatRegisters = f.PK_psPatRegisters and 
														RT.fk_mscitemcategory = 1035) as RESPIRATORY,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem SHH Where 
														SHH.FK_psPatRegisters = f.PK_psPatRegisters and 
														(SHH.fk_mscitemcategory = 1011 or 
														 SHH.fk_mscitemcategory = 1022 or
														 SHH.fk_mscitemcategory = 1023 or
														 SHH.fk_mscitemcategory = 1024 or 
														 SHH.fk_mscitemcategory = 1026 or
														 SHH.fk_mscitemcategory = 1029 or
														 SHH.fk_mscitemcategory = 1030 or
														 SHH.fk_mscitemcategory = 1032 or 
														 SHH.fk_mscitemcategory = 1036 )) as SHH,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem TRD Where 
														TRD.FK_psPatRegisters = f.PK_psPatRegisters and 
														TRD.fk_mscitemcategory = 1008) as TREADMILL,

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem XRY Where 
														XRY.FK_psPatRegisters = f.PK_psPatRegisters and 
														(XRY.fk_mscitemcategory = 1004 OR
														XRY.fk_mscitemcategory = 1019)) as 'X-RAY',

					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem TRD Where 
														TRD.FK_psPatRegisters = f.PK_psPatRegisters and 
														TRD.fk_mscitemcategory = 1042) as '2DECHO',
--- TOTAL ROOM + CHARGES
					(SELECT ISNULL(Sum(renprice * renqty),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(price),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as 'GROSS TOTAL',
-- PHIC				
					(SELECT ISNULL(Sum(phicamount),0) From psPatLedgers PHI Where 
														PHI.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(phicamount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as PHIC,			

---HMO ROOM + CHARGES
					(SELECT ISNULL(Sum(gntramount),0) From psPatitem HMO Where 
														HMO.FK_psPatRegisters = f.PK_psPatRegisters) +
					(Select ISNULL(Sum(gntramount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as HMO,

--DISCOUNT
					(SELECT ISNULL(Sum(discount),0) From psPatLedgers DCT Where 
														DCT.FK_psPatRegisters = f.PK_psPatRegisters) AS DISCOUNT,

---TOTAL HB - ROOM CN
					(SELECT  ISNULL(Sum(hbamount),0) From faCRMstr HB Where 
												HB.FK_psPatRegisters = f.PK_psPatRegisters) - 
					(Select ISNULL(Sum(cnamount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters) as 'TOTAL HB',

--PF GROSS
					(SELECT ISNULL(Sum(pfamount),0) From psdctrledgers PF Where 
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
--PF ORAMOUNT			
					(SELECT ISNULL(Sum(oramount),0) From psdctrledgers ORA Where 
														ORA.FK_psPatRegisters = f.PK_psPatRegisters) AS 'TOTAL PF',
														
---TOTAL HB - ROOM CN
				 (SELECT  ISNULL(Sum(hbamount),0) From faCRMstr HB Where 
												HB.FK_psPatRegisters = f.PK_psPatRegisters) - 
					(Select ISNULL(Sum(cnamount),0) from psPatRooms room Where 
															room.FK_psPatRegisters = f.PK_psPatRegisters)+
			        (SELECT ISNULL(Sum(oramount),0) From psdctrledgers ORA Where 
														ORA.FK_psPatRegisters = f.PK_psPatRegisters) AS NETAMOUNT																	

					from pspatitem a
					left outer join pspatinv b on a.FK_trxno = b.PK_trxno
					left outer join iwitems c on a.FK_iwItemsREN = c.PK_iwItems
					left outer join psDatacenter d on a.FK_emdPatients = d.PK_psDatacenter	
					left outer join mscWarehouse e on a.FK_mscWarehouse = e.PK_mscWarehouse				
					left outer join psPatregisters f on a.FK_psPatregisters = f.PK_psPatregisters
								
					WHERE f.registrydate between '2016-12-01' and '2017-6-1' AND f.pattrantype = 'I' and e.description = 'OB-GYNE' 

					group by
					f.PK_psPatRegisters ,
					f.FK_emdPatients ,
					f.registryno ,
					d.fullname,
					f.registrydate

					order by f.PK_psPatRegisters
				

					
