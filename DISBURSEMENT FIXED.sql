select * from faCVMstr where evatamt is null
and convert(date,cvdate) between '02/01/2021' and '02/23/2021'
--update facvmstr set evatamt = 0 where evatamt is null 
and convert (date,cvdate) between '08/01/2020' and '02/23/2021'