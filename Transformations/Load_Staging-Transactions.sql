 BULK INSERT staging.dbo.Transactions_staged
     from 'C:\Users\jadrummond\Documents\deliverables\recess\extract\Barnabas\BigSquid\Transactions.csv'
     with (
 		formatfile = 'C:\Users\jadrummond\Documents\deliverables\recess\extract\Barnabas\BigSquid\Transactions_format2.txt'
 		, firstrow = 2
 	);

insert into Transactions_transactions (
	transaction_id
    , account_id
	, transaction_amount
	, client_id
	, transaction_status
	, [login]
	, transaction_date
	, reporting_period
) 
select 
	transaction_id
	,account_id
    , transaction_amount
	, client_id
	, transaction_status
	, [login]
	, convert(date,convert(date, transaction_date, 101),102) as transaction_date
	, reporting_period
from Transactions_staged 
; 



