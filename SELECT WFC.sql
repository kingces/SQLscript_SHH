Select FK_iwItems,y.itemdesc,y.itemgroup,Inventory,ThreeMonths,OneMonth,TwoWeeks,
ROUND(ThreeMonths/13.14,2) [AWMB3MSALES],ROUND(OneMonth/4.43,2) [AWMB1MSALES],ROUND(TwoWeeks/2,2) [AWMB2WSALES],
case when ROUND(ThreeMonths/13.14,2) != 0 then ROUND(Inventory/(ThreeMonths/13.14),2) else 0 end [WFCB3MSALES],
case when ROUND(OneMonth/4.43,2) != 0 then ROUND(Inventory/(OneMonth/4.43),2) else 0 end [WFCB1MSALES],
case when ROUND(TwoWeeks/2,2) != 0 then ROUND(Inventory/(TwoWeeks/2),2) else 0 end [WFCB2WSALES]
From WFC  x left join LiveDB_shhbizbox8live.dbo.iwItems y on  x.FK_iwItems collate Latin1_General_CI_AS = y.PK_iwItems order by Inventory  desc