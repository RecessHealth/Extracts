-- Project Theta extract 
-- Action timeline only 
-- grouping fields: transcation period >> dataset by ATB 
-- grouping field: unique_trans_id only unique within each [login]

select 
	unique_trans_id as transaction_id, 
	account_number as account_id, 
    transaction_amount, 
	client_number as client_id,
	transaction_code as transaction_status, 
	[login], 
	transaction_date,
	transaction_period as reporting_period,
from vw_MonthEndTrans_With_CUArchive
;