Select x.PK_emdDoctors,DoctorName,posttitle From emdDoctors x join vwReportDoctorIndex y on x.PK_emdDoctors = y.FK_emdDoctors
group by x.PK_emdDoctors,DoctorName,posttitle

Select * from vwReportDoctorIndex


SElect * From emdDoctors