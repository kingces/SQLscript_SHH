--select VendorName,ItemId,ItemDescription, UnitPrice, tinno, praddress 
---from vwReportPurchaseAnalysisNew  
--inner join dbo.psDatacenter on VendorName = fullname--inner join faVendors on PK_psDatacenter = PK_faVendors
--Where docdate between '2016-03-01' and '2016-06-30' and ItemDescription like '%stapler%' order by VendorName




Select * From vwReportPurchaseAnalysisNew Where ItemDescription like '%skin stapler%'

Select * From vwReportStockIssuance