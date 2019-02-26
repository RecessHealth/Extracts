select 
	account_id, 
	[login], 
	client_id, 
	financial_class, 
	status_code, 
	previous_status_code, 
	ppa_id, 
	initialload_balance, 
	total_balance, 
	assigned_date, 
	initialppa_date,
	final_bill_date, 
	cancelled_date,
	export_date 
from vw_MonthEndDFWTotalBalance_With_CUArchive
	
