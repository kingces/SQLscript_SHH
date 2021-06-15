select					b.PK_iwItems as ItemCode,
					    b.itemdesc as ItemDesc,
						a.purcprice as ItemCost,
						b.itemgroup as ItemGroup
                        
                    from 
                        iwItemLedgerDaily a
                            inner join iwItems b
                                on b.PK_iwItems = a.FK_iwItems 
                    where a.refdate between '2016-12-1' and '2017-1-01' and b.FK_faGLAcctCostIPD = '500020'

						GROUP BY b.PK_iwItems, 
								 b.itemdesc,
								 a.purcprice,
								 b.itemgroup

						order by b.itemgroup,b.PK_iwItems