SElect a.itemid,a.ItemDescription,b.itemgroup,a.DepartmentName,a.VendorName
	  from vwReportPurchaseAnalysisNew a
		   inner join iwItems b on a.ItemId = b.PK_iwItems
	  group by a.itemid,a.ItemDescription,b.itemgroup,a.DepartmentName,a.VendorName
	  
	  order by DepartmentName
	  
	 
