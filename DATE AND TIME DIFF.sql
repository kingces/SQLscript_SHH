Select 
RequestNo, 
CONVERT(VARCHAR(10), ReqDate, 101) [REQDATE], CONVERT(varchar(15),CAST(ReqDate AS TIME),100) [REQTIME],
CONVERT(VARCHAR(10), RenDate, 101) [RENDATE], CONVERT(varchar(15),CAST(RenDate AS TIME),100) [RENTIME],
 CONCAT(DATEDIFF(HOUR, CONVERT(time, ReqDate), CONVERT(time, RenDate)),':', DATEDIFF(minute, CONVERT(time, ReqDate), CONVERT(time, RenDate))) [HOUR:MINUTE DIFF],

Qty 
From vwOrderReport Where convert(date, ReqDate)  between '2017-07-01' and '2017-07-31' AND Ancillary = 'laboratory'