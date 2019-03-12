with d as ( 
	select
		account_id
		,assigned_date
		, Day_30
		, Day_31
		, Day_60
		, Day_61
		, Day_90
		, Day_91
		, Day_120
	from staging..Demographics
)
insert into Transactions (
	account_id
	, trans_in_30
	, trans_in_60
	, trans_in_90
	, trans_in_120
	, paid_in_30
	, paid_in_60
	, paid_in_90
	, paid_in_120
)
select 
	d.account_id
	, COUNT(DISTINCT CASE WHEN transaction_date <= Day_30 THEN y.transaction_id END) AS trans_in_30 
	, COUNT(DISTINCT CASE WHEN transaction_date between Day_31 and Day_60 THEN y.transaction_id END) AS trans_in_60 
	, COUNT(DISTINCT CASE WHEN transaction_date between Day_61 and Day_90 THEN y.transaction_id END) AS trans_in_90 
	, COUNT(DISTINCT CASE WHEN transaction_date between Day_91 and Day_120 THEN y.transaction_id END) AS trans_in_120 
	, SUM(CASE WHEN transaction_date <= Day_30 THEN y.transaction_amount ELSE 0.00 END) AS paid_in_30 
	, SUM(CASE WHEN transaction_date <= Day_60 THEN transaction_amount ELSE 0.00 END) AS paid_in_60 
	, SUM(CASE WHEN transaction_date <= Day_90 THEN transaction_amount ELSE 0.00 END) AS paid_in_90 
	, SUM(CASE WHEN transaction_date <= Day_120 THEN transaction_amount ELSE 0.00 END) AS paid_in_120 
from staging..Transactions_transactions y
inner join d 
	 on d.account_id = y.account_id
group by d.account_id

