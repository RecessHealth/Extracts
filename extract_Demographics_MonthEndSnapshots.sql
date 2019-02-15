-- Project Theta extract from vw_MonthEndDFWTotalBalance_With_CUArchive
-- Demographic purposes only 
-- snapshot, added to CUBS once per month at Month End reporting (check [export_date])

select 
	account_number as account_id, 
	[login], 
	client_number as client_id, 
	financial_class, 
	status_code, 
	previous_status_code, 
	payment_plan_number as ppa_id, 
	assignment_balance as initialload_balance, 
	totalbalance as total_balance, 
	assign_date as assigned_date, 
	payment_plan_date as initialppa_date,
	final_bill_date, 
	cancelled_date,
	getdate() as export_date 
from vw_MonthEndDFWTotalBalance_With_CUArchive
	