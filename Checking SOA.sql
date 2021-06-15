select 
	sum(hbamount) as HB,
	sum(miscamount) as misc,
	sum(pfamount) as PF,
	sum(rmamount) as rmamount,
	sum(rfamount) as rfamount,
	sum(refundamount) as refund,
	sum(appliedamount) as app,
	sum(cashamount) as cAshamount,
	sum(otheramount) as others,
	sum(checkamount) as checkamount,
	sum(totalamount) as totalAmount

 from faCRMstr  where FK_psPatRegisters = '18871'
--doctor pf and discount
Select sum(pfamount) as totalcharge,
	   SUM(phicamount) as phicpf,
	   sum(gntramount) as HMO, 
	   sum(discount) as discount,
	   sum(netamount) as netamount, 
	   sum(oramount) oramount from psdctrledgers where FK_pspatregisters = 18871 

SElect sum(amount) as Amount,
	   sum(discamt) as discamt,
	   sum(oramount) as ORamount,
	   sum(balance) as balance,
	   Sum(Netdiscount) as Discount,
	   sum(netvat) as vat
		 From vwGuarantorChargesMstrList Where FK_psPatRegisters = 18871

select sum(debit - credit) as debit,
	   sum(oramount) as oramount,
	   sum(discount) as Discount,
	   sum(adjamount) as adj,
	   Sum(gntramount) as HMO,
	   sum(cnamount) as CN,
	   sum(phicamount) as phic

	
	 From psPatLedgers WHere FK_psPatRegisters = '18871'

	 


	 Select * From psPatRooms WHere FK_psPatRegisters = '18871'


	  Select 
	sum(phicamount) as phic , 
	sum(oramount) as Oramount, 
	sum(gntramount) as HMO, 
	sum(cnamount) as Cn, 
	sum(renprice *  renqty) as totalbill 
		From psPatitem 
		WHere 
		FK_psPatRegisters = '18871' 



