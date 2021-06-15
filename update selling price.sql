---Select * from mscPriceSchemes

update iwItemPrices set price = 5668.93
Where FK_iwItems = 'PHMED0000000749'  
and FK_mscWarehouse = '1010' and FK_mscPriceSchemes <> '1003'

Select FK_iwItems,price From iwItemPrices Where  FK_mscWarehouse = '1010' and FK_mscPriceSchemes <> '1003' group by FK_iwItems,price