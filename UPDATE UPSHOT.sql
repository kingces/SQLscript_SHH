update x set isViewable = 1, isTrade = 1
 from iwWareitem x
inner join iwitems as y on y.PK_iwItems = x.FK_iwItems
where y.PK_iwItems like ('E%')
and x.FK_mscWarehouse='1060'

select * from mscWarehouse

