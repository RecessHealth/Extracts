insert into transactions (
	account_id
	, transaction_id 
	, client_id
	, transaction_amount
	, transaction_status
	, transaction_date 
)
select 
	try_to_number(account_id)
	, transaction_id
	, client_id
	, try_to_number(transaction_amount,13,2)
	, try_to_number(transaction_code) 
	, try_to_date(transaction_date) 
from transactions_staging;