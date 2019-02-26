select 
	transaction_id, 
	account_id, 
    transaction_amount, 
	client_id,
	transaction_status, 
	[login], 
	transaction_date,
	reporting_period,
from vw_MonthEndTrans_With_CUArchive
