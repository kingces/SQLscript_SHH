SElect ItemId,ItemDescription,VendorName From vwReportPurchaseAnalysisNew WHere convert(date, docdate) between '2018-01-01' and '2018-5-31'
and (VendorName = 'METRO DRUG, INC.' OR VendorName = 'ZUELLIG PHARMA CORPORATION' OR VendorName = 'UNILAB, INC.') 
GROUP BY ItemId,ItemDescription,VendorName