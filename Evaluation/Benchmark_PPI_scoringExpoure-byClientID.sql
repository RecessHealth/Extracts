with ppi_full as (
	select 
		count(account_id) as n_scores
		, client_id
	from tbl_Report_Data 
	where ppi is not null
	group by client_id
), 
ppi_null as (
	select 
		count(account_id) as null_scores
		, client_id
	from tbl_Report_Data 
	where ppi is null
	group by client_id
), 
account_total as (
	select 
		count(account_id) as total 
		, client_id 
	from tbl_Report_Data
	group by client_id
)
select 
	ppi_full.client_id
	, n_scores
	, null_scores
	, total
	, convert(decimal(5,2),(null_scores*100.00)/total) as missing_values
from ppi_full 
inner join ppi_null 
	on ppi_full.client_id = ppi_null.client_id
inner join account_total 
	on ppi_null.client_id = account_total.client_id 
order by client_id asc; 

