declare @full_batch date = cast(dateadd(day,-121,getdate()) as varchar);

; with d as ( 
	select
		account_id
		, cast(assigned_date as date) as assigned_date
		, cast(Day_30 as date) as Day_30
		, cast(Day_60 as date) as Day_60
		, convert(Day_90,101) as Day_90
		, convert(date,Day_120,101) as Day_120
	from staging..Demographics
),
select 
	x.account_id
	, COUNT(DISTINCT CASE WHEN convert(date,y.transaction_date,101) <= x.Day_30 THEN y.transaction_id END) AS trans_in_30 
	, COUNT(DISTINCT CASE WHEN convert(date,y.transaction_date,101) between x.Day_31 and x.Day_60 THEN y.transaction_id END) AS trans_in_60 
	, COUNT(DISTINCT CASE WHEN convert(date,y.transaction_date,101) between x.Day_61 and x.Day_90 THEN y.transaction_id END) AS trans_in_90 
	, COUNT(DISTINCT CASE WHEN convert(date,y.transaction_date,101) between x.Day_91 and x.Day_120 THEN y.transaction_id END) AS trans_in_120 
	, SUM(CASE WHEN convert(date,y.transaction_date,101) <= x.Day_30 THEN y.transaction_amount ELSE 0.00 END) AS paid_in_30 
	, SUM(CASE WHEN convert(date,y.transaction_date,101) between x.Day_31 and x.Day_60 THEN y.transaction_amount ELSE 0.00 END) AS paid_in_60 
	, SUM(CASE WHEN convert(date,y.transaction_date,101) between x.Day_61 and x.Day_90 THEN y.transaction_amount ELSE 0.00 END) AS paid_in_90 
	, SUM(CASE WHEN convert(date,y.transaction_date,101) between x.Day_91 and x.Day_120 THEN y.transaction_amount ELSE 0.00 END) AS paid_in_120 
into #BarnTransactions
from staging..Transactions y
inner join x 
	 on x.account_id = y.account_id
group by x.account_id




--select top 1000 * from staging.."Actions_Transaction-allTime_NE"
--select top 1000 * from staging..Demographics