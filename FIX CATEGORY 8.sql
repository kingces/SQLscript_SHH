select COUNT(FK_TRXNO),FK_TRXNO from psPatLedgers where fk_pspatregisters = 525940 and cancelflag = 0 group by FK_TRXNO

select billtrancode, debit, credit, docno, * from pspatledgers where FK_TRXNO = 7279552 and cancelflag = 0
--update pspatledgers set cancelflag = '1' where pk_pspatledgers = 4908241
select FK_mscWarehouse,* from psPatinv where pk_trxno = 7279552

select * from mscWarehouse where PK_mscWarehouse = 1010