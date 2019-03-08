select 
	unique_trans_id as transaction_id, 
	account_number as account_id, 
    transaction_amount, 
	client_number as client_id,
	transaction_code as transaction_status, 
	[login], 
	transaction_date,
	transaction_period as reporting_period
from vw_MonthEndTrans_With_CUArchive
where client_number like 'BH%'
;