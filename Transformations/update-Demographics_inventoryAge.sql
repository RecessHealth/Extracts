----------------------------------------------
-- keep inventory_age current
----------------------------------------------

update staging..Demographics 
set inventory_age = abs(datediff(day,getdate(),export_date)) + inventory_age 
	where export_date < getdate() 