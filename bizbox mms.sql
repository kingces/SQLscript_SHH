select* from psPatLedgers where FK_psPatRegisters=158152

select * from mscDiscounts

INSERT into	iwItemPriceDiscounts (FK_mscWarehouse, FK_iwItems, FK_mscDiscounts, discountrate)
select 
	a.FK_mscWarehouse,
	a.FK_iwItems,
	b.PK_mscDiscounts,
	case
		when c.itemgroup = 'MED' then b.meddiscount
		when c.itemgroup = 'SUP' then b.supdiscount
		when c.itemgroup = 'EXM' then b.exmdiscount
		when c.itemgroup = 'PRC' then b.prcdiscount
		when c.itemgroup = 'OTH' then b.othdiscount
	end as discountrate
		from iwWareitem a
			inner join iwitems c on a.FK_iwItems = c.PK_iwItems
			cross join mscDiscounts b
				where b.PK_mscDiscounts = 1001
					and a.isTrade = 1
					and c.isactive = 1 
					and c.isallowdiscount = 1
					and cast(a.FK_mscWarehouse as varchar) + a.FK_iwItems + cast(b.PK_mscDiscounts as varchar)
					not in (select cast(a.FK_mscWarehouse as varchar) + a.FK_iwItems + cast(a.FK_mscDiscounts as varchar) 
						from iwItemPriceDiscounts a 
							where FK_mscDiscounts = 1001)