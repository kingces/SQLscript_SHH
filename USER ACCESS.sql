Select CONCAT(Lastname,', ',Firstname,' ',Middlename) [NAME],y.Position,z.description [Access],isallowed From 

appsysDeptAccess x 
left join vwDmsHs8Users y on  y.Id = x.FK_appsysUsers
left join mscWarehouse z on x.FK_mscWarehouse = z.PK_mscWarehouse

 where z.description = 'or/dr' and isallowed = 1
 order by Position




 