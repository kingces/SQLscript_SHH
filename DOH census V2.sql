Declare  @FromDate Date = '2020-01-01',
		@ToDate Date = '2020-12-31'



Select COUNT(x.PK_psPatRegisters) [TOTAL_IPD], 
(Select COUNT(a.PK_psPatRegisters) From psPatRegisters a where a.isDiedIn48Hours = '0' AND convert(date, a.registrydate) between @FromDate and @ToDate AND a.pattrantype = 'I') [TOTAL_ALIVE],
(Select SUM(a.noofdays) From psPatRooms a where  convert(date, a.refdate) between @FromDate and @ToDate) [ROOM_DAYS],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and a.pattrantype = 'O' and age2 is not null and b.cancelflag = 0) [TOTAL_OPD],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and a.pattrantype = 'O' and age2 is not null and age2 <= 19 and b.cancelflag = 0) [OPD_ADULT],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and a.pattrantype = 'O' and age2 is not null and age2 > 19 and b.cancelflag = 0) [OPD_PEDIA],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and a.pattrantype = 'E' and age2 is not null and b.cancelflag = 0) [TOTAL_ERD],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and a.pattrantype = 'E' and age2 is not null and age2 <= 19 and b.cancelflag = 0) [ERD_ADULT],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and a.pattrantype = 'E' and age2 is not null and age2 > 19 and b.cancelflag = 0) [ERD_PEDIA],
(Select COUNT(a.pk_pspatregisters) From vwReportPatientProfile a join psPatRegisters b on a.pk_pspatregisters = b.PK_psPatRegisters where convert(date, a.registrydate) between @FromDate and @ToDate and age2 is not null and b.cancelflag = 0) [OVERALL]
From psPatRegisters x join vwReportPatientProfile y on x.PK_psPatRegisters = y.pk_pspatregisters
Where x.cancelflag = '0' AND convert(date, x.registrydate) between @FromDate and @ToDate AND x.pattrantype = 'I'