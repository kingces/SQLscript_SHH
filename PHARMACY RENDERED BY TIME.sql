
SELECT CAST(RenDate as date) AS ForDate,
       DATEPART(hour, RenDate) AS OnHour,
       SUM(Qty) AS Totals
FROM vwOrderReport Where convert(date, RenDate) between '2018-07-1' and '2018-09-30' and Ancillary = 'PHARMACY'
GROUP BY CAST(RenDate as date),
       DATEPART(hour,RenDate)
	order by CAST(RenDate as date)

	SElect distinct(Ancillary) From vwOrderReport Where Ancillary = 'CASHIER' AND convert(date, RenDate) between '2016-01-1' and '2017-12-31'