UPDATE x SET isViewable = 1, isTrade = 0
 FROM iwWareitem x 
 INNER JOIN iwitems AS y ON y.PK_iwItems = x.FK_iwItems
 WHERE y.itemgroup in ('MED')
 AND x.FK_mscWarehouse = '1021'

change niyo na lang po yung ('MED') depends sa item group nung item then yung x.FK_mscWarehouse = naman is yun  code ng dept sa Manage Warehouse Accessibility