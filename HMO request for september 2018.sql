declare @where nvarchar(max),
		@sql nvarchar(max)


	
set @where = ' where  b.registrydate between ''' + @DateFrom + ''' and ''' + @DateTo + ''' and a.deleteflag = 0  and a.amount > 0 and e.billtrancode not like ''PN%'''
		
if (@chkPattrantype = 'True')
begin
	set @where = @where + ' and b.pattrantype = ''' + @RegistryType + ''''
end

if (@chkServiceType = 'True')
begin
	set @where = @where + ' and b.FK_mscServiceType = ''' + @ServiceType + ''''
end

if (@chkGuarantor = 'True')
begin
	set @where = @where + ' and a.FK_faCustomers = ''' + @faCustomers + ''''
end

if (@chkAttending = 'True')
begin
	set @where = @where + ' and a.FK_psPatRegisters in (select FK_psPatRegisters from faArinv where FK_emdDoctors = ''' + @emdDoctors + ''')'
end

set @sql =
'select FK_emdDoctors, caseno, patientid,patientname, registrationdate, dischargedate, pattrantype, doctor, ServiceType, 
Guarantors, GuarantorsAll, guaranteedhosp, guaranteedhosppaid, guaranteedPF, guaranteedPFpaid, amount, oramount, registryno, 
isnull((select sum(guaranteedPF) where FK_emdDoctors = ''' + @emdDoctors + '''), '''') as total, 
isnull((select sum(guaranteedPFpaid) where FK_emdDoctors = ''' + @emdDoctors + '''), '''') as total2 
 from (

select
FK_emdDoctors,
caseno,
patientid,
patientname,
registrationdate,
dischargedate,
pattrantype,
doctor,
ServiceType,
Guarantors,
GuarantorsAll,
SUM(guaranteedhosp) as guaranteedhosp,
SUM(guaranteedhosppaid) as guaranteedhosppaid,
SUM(guaranteedPF) as guaranteedPF,
SUM(guaranteedPFpaid) as guaranteedPFpaid,
SUM(amount) as amount,
SUM(oramount) as oramount
,registryno
from(
select 
convert(varchar(10),a.FK_emdDoctors) as FK_emdDoctors,
a.FK_psPatRegisters as caseno,
c.patid as patientid,
d.fullname as patientname, 
b.registrydate as registrationdate, 
b.dischdate as dischargedate, 
b.pattrantype,
isnull((select dbo.udf_GetFullName(a.fk_emdDoctors)), '''')as doctor,
(select dbo.udf_GetServiceType(b.FK_mscServiceType)) as ServiceType,
(select(dbo.udf_GetFullName(a.FK_faCustomers))) as Guarantors,
(select(dbo.udf_ConcatAllGuarantorsPerRegistry(b.PK_psPatRegisters))) as GuarantorsAll,
isnull((select Sum(a.amount) where artype in (''IS'', ''MC'', ''RB'')), '''') as guaranteedhosp,
isnull((select Sum(a.oramount + a.cnamount) where artype not in (''PF'', ''PH'', ''OT'')), '''') as guaranteedhosppaid,
isnull((select Sum(a.amount) where artype = ''PF''), '''') as guaranteedPF,
isnull((select Sum(a.oramount + a.cnamount) where artype = ''PF''), '''') as guaranteedPFpaid,

sum(a.amount) as amount,
sum(a.oramount + a.cnamount) as oramount,
b.registryno


 from faarinv a
inner join psPatRegisters b on a.FK_psPatRegisters = b.PK_psPatRegisters
inner join emdPatients c on b.FK_emdPatients = c.PK_emdPatients
inner join psdatacenter d on b.FK_emdPatients = d.PK_psDatacenter
left outer join psPatLedgers e on a.PK_TRXNO = e.FK_TRXNO 
inner join  

		' + @where +'

group by a.FK_psPatRegisters, b.registryno, b.pattrantype,  a.FK_emdDoctors, c.patid, d.fullname,b.registrydate, b.dischdate,b.PK_psPatRegisters, b.FK_mscServiceType, a.artype, a.amount, a.oramount,a.FK_faCustomers


) as aa
group by aa.caseno, aa.registryno, aa.patientid, aa.patientname, aa.registrationdate, aa.dischargedate, aa.pattrantype, aa.doctor, aa.ServiceType, aa.Guarantors, aa.FK_emdDoctors, aa.GuarantorsAll
) as bb
group by bb.FK_emdDoctors, bb.caseno, bb.patientid,bb.patientname,bb.registrationdate,bb.dischargedate,bb.pattrantype,bb.doctor, bb.ServiceType, bb.Guarantors, bb.guaranteedhosp,
bb.guaranteedhosppaid, bb.guaranteedPF, bb.guaranteedPFpaid, bb.amount, bb.oramount, bb.registryno,  bb.GuarantorsAll
'

exec (@sql)