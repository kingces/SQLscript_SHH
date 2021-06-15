Select a.registryno, a.PatientFullName,(SElect sum(b.price) from psPatRooms b where b.FK_psPatRegisters = a.pk_pspatregisters ) [RoomCharges],sum(c.amount) [AncillaryCharges],d.registrydate,d.dischdate

from vwReportPatientProfile a
join psPatinv c on a.pk_pspatregisters = c.FK_psPatRegisters
join psPatRegisters  d on a.pk_pspatregisters = d.PK_psPatRegisters 
 where  a.pattrantype = 'I' and 
 
 (a.registryno = 28707 or 
	a.registryno = 28684 or
a.registryno = 28727 or
a.registryno = 28722 or
a.registryno = 28693 or
a.registryno = 28713 or
a.registryno = 28682 or
a.registryno = 28692 or
a.registryno = 28724 or
a.registryno = 28731 or
a.registryno = 28685 or
a.registryno = 28473 or
a.registryno = 28690 or
a.registryno = 28734 or
a.registryno = 28719 or
a.registryno = 28735 or
a.registryno = 28687 or
a.registryno = 28728 or
a.registryno = 28710 or
a.registryno = 28699 or
a.registryno = 28691 or
a.registryno = 28708 or
a.registryno = 28730 or
a.registryno = 28679 or
a.registryno = 28729 or 
a.registryno = 28620 or
a.registryno = 28661 or
a.registryno = 28732 or
a.registryno = 28736 or
a.registryno = 28677 or
a.registryno = 28723 or
a.registryno = 28725 or
a.registryno = 28726 or
a.registryno = 28721 or
a.registryno = 28718)

 group by 
 a.registryno, a.PatientFullName,d.registrydate,d.dischdate,a.pk_pspatregisters
