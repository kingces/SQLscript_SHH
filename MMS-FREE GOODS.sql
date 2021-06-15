select 
(select dbo.udf_GetFullName(FK_faVendors) from iwApinv where PK_TRXNO = iwapitem.FK_TRXNO)[SUPPLIER],
FK_iwItems[Item Code], dbo.udf_GetItemDescription(FK_iwItems),dbo.udf_GetDepartmentName(FK_mscWarehouse)[Item Description],
(select docno from iwApinv where PK_TRXNO = iwapitem.FK_TRXNO)[Doc No],
(select docdate from iwApinv where PK_TRXNO = iwapitem.FK_TRXNO)[Doc Date],
qty,
conversion,
qty*
conversion[Total] from iwapitem 
where isfreegoods = 1
and FK_TRXNO in (select PK_TRXNO from iwApinv where convert(date,docdate) between 
'01/01/2016'
and
'01/31/2016')