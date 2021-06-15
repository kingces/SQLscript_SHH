


Select 
	   a.BuildingName as 'Building Name',
	   isnull(b.NurseStation,'---') as 'Nursing Station',
	   a.RoomNo,
	   isnull(a.RoomClass,'---') as 'Room Class',
	   isnull(b.bedno,'---') as 'Bed Number',
	   c.roomprice as 'Room Rates',
	   'to be done' as 'Remarks',
	   isnull(b.PatientFullname,'---') as 'Patient FullName',
	   b.RegistryDate as 'AdmissionDate',
	   isnull(b.HospPlan,'---') as 'Hospital Plan'
		From  vwRoomInquiry a
		left outer join vwInpatientMstrList b on a.RoomNo = b.FK_psRooms
		left outer join psRoomPrices c on a.RoomNo = c.FK_psRooms
		Where c.FK_mscRoomPriceSchemes = 'PRICING SCHEME1'

		group by 
	   a.BuildingName ,
	   b.NurseStation ,
	   a.RoomClass,
	   b.bedno ,
	   c.roomprice,
	   b.PatientFullname ,
	   b.RegistryDate ,
	   b.HospPlan,
	   a.RoomNo
	   
	   order by a.RoomNo 