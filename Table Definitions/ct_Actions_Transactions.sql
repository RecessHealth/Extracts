create table Transactions (
	account_id varchar(50)
	, trans_in_30 int
	, trans_in_60 int
	, trans_in_90 int
	, trans_in_120 int
	, paid_in_30 decimal(13,2)
	, paid_in_60 decimal(13,2)
	, paid_in_90 decimal(13,2)
	, paid_in_120 decimal(13,2)
) 