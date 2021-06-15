Select * From ERpatient order by CaseNo


Delete from ERpatient Where CaseNo = '13418' and VacantNo = '13418'

Update ERpatient set VacantNo = (Case When VacantNo = CaseNo Then '0' END), CaseNo =  Where CaseNo = 13429

Update ERpatient set VacantNo = 13429, CaseNo = 0 Where CaseNo = 13429