 declare 
@startdate varchar(10) ='01/01/2018',    -- set start date
@enddate varchar(10) ='02/28/2018'        -- set end date

	declare @sql nvarchar(max)
	declare @where varchar(max)
	-- and a.FK_mscWarehouse = '''+ @department +'''
	set @where = 'a.pattrantype = ''O'' and a.reqdate between ''' + @startdate + ''' and ''' + @enddate + ''''
	
 
    -- Insert statements for procedure here
	SELECT @sql = 'select	a.reqno,
							a.reqdate, 
							dbo.udf_GetFullName(a.FK_emdPatients) as [PatientName], 
							dbo.udf_GetFullName(a.FK_ASUReqUser) as [RequestedBy],
							b.reqqty as [qty],
							d.description as [GenericName], 
							x.FK_mscNrstation,
							dbo.udf_GetItemDescription(b.FK_iwItemsREQ) as [BrandName],
							dbo.udf_NurseStation(x.FK_psPatRegisters) as [NursingStation],
							reqdate,e.description as FK_mscWarehouse,(b.reqprice*b.reqqty) as amount,z.registryno,
							dbo.udf_GetDepartmentName(y.FK_mscWarehouse) as ReqDepartment,
							z.pattrantype from psPatInv a
							
					inner join psPatItem b
					on b.FK_TRXNO = a.PK_TRXNO

					inner join mscWarehouse e
					on a.FK_mscWarehouse = e.PK_mscWarehouse

					left join iwItemMedicines c
					on b.FK_iwItemsREQ = c.FK_iwItems

					left join mscGenerics d
					on c.FK_mscGenerics = d.PK_mscGenerics

					left join psPatregisters z
					on a.FK_psPatregisters = z.PK_psPatRegisters

					left join psAdmissions x
					on a.FK_psPatRegisters = x.FK_psPatRegisters 

					inner join appsysUsers y 
					on a.FK_ASUReqUser=y.PK_appsysUsers

					where a.status not in (''R'', ''C'') and a.cancelflag <> 1 and b.reqqty > 0 and ' + @where + ''

print @sql	
exec sp_executesql @sql




