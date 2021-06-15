Declare @startDate date = '2018-01-01',
		@endDate date  = '2018-01-31',
		@Dept varchar(MAX) = 'csr'


select 
			c.docdate as [Document Date],
			c.docno as [Document No], 
			a.FK_iwItems as [Item Id], 
			b.itemdesc as [Item Descripton],
			a.unit as [Unit],
			a.qty as [Quantity],
			a.landcost as [Unit Cost],
			a.landamt as [Balance],
			d.description[Receiving Department],
			dbo.udf_GetFullName(c.FK_favendors) as [Vendor Name]
		from iwapitem a
			inner join iwitems b on a.FK_iwItems = b.PK_iwitems
			inner join iwApinv c on a.FK_TRXNO = c.PK_TRXNO
			inner join mscwarehouse d on c.fk_mscwarehouse = d.pk_mscwarehouse
		where
			convert(varchar,c.docdate,101) between @startDate and @endDate
			and d.description = @Dept
			and c.postflag = 1
			and c.deleteflag = 0
			and c.cancelflag = 0