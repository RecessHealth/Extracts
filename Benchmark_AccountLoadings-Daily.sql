; with x as (
	select account_id, assigned_date from tbl_Report_Data
	where client_id like 'BH%'
)
select convert(date, assigned_date, 101) as assigned_date, count(account_id) 
from x
group by assigned_date 
order by assigned_date desc; 