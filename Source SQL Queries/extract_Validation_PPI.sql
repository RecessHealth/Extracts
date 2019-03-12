select 
	account_id
	, case
		when cancelled_date is null then abs(datediff(day, getdate()-1, assigned_date))
		else abs(datediff(day, cancelled_date, assigned_date))
		end as days_in_inventory
	, getdate() as date_modified 
	, ppi
from tbl_Report_Data 
where client_id like 'BH%'
;
