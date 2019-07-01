CREATE VIEW staging.&client.vw_transactions
as 
select 
	d.account_id 
	-- 494 = patient, 495 = insurance, 497/498 = noncommission, 597 = charity, 598 = adjustment 
	-- 494, 498 = patient-responsible (commission, noncommission)
	, sum(case when transaction_status in ('494') and transaction_date < Day_18 then transaction_amount else 0.00 end) as paid_in_18 
	, sum(case when transaction_status in ('494') and transaction_date < Day_30 then transaction_amount else 0.00 end) as paid_in_30
    , sum(case when transaction_status in ('494') and transaction_date < Day_45 then transaction_amount else 0.00 end) as paid_in_45
	, sum(case when transaction_status in ('494') and transaction_date < Day_60 then transaction_amount else 0.00 end) as paid_in_60
	, sum(case when transaction_status in ('494') and transaction_date < Day_75 then transaction_amount else 0.00 end) as paid_in_75
	, sum(case when transaction_status in ('494') and transaction_date < Day_90 then transaction_amount else 0.00 end) as paid_in_90 
	, sum(case when transaction_status in ('494') and transaction_date < Day_105 then transaction_amount else 0.00 end) as paid_in_105
	, sum(case when transaction_status in ('494') and transaction_date < Day_120 then transaction_amount else 0.00 end) as paid_in_120
	, SUM(CASE WHEN transaction_status in ('494') and transaction_date >= Day_120 THEN transaction_amount ELSE 0.00 END) AS paid_over_120
	, COUNT(CASE WHEN transaction_date < Day_18 and transaction_status in ('494') THEN transaction_id END) AS trans_in_18
	, COUNT(CASE WHEN (transaction_date between Day_18 and Day_29) and transaction_status in ('494') THEN transaction_id END) AS trans_in_30
	, COUNT(CASE WHEN (transaction_date between Day_30 and Day_44) and transaction_status in ('494') THEN transaction_id END) AS trans_in_45
	, COUNT(CASE WHEN (transaction_date between Day_45 and Day_59) and transaction_status in ('494') THEN transaction_id END) AS trans_in_60
	, COUNT(CASE WHEN (transaction_date between Day_60 and Day_74) and transaction_status in ('494') THEN transaction_id END) AS trans_in_75
	, COUNT(CASE WHEN (transaction_date between Day_75 and Day_89) and transaction_status in ('494') THEN transaction_id END) AS trans_in_90
	, COUNT(CASE WHEN (transaction_date between Day_90 and Day_104) and transaction_status in ('494') THEN transaction_id END) AS trans_in_105
	, COUNT(CASE WHEN (transaction_date between Day_105 and Day_119) and transaction_status in ('494') THEN transaction_id END) AS trans_in_120
	, case when sum(case when transaction_status in ('494') then transaction_amount else 0 end) > max(initial_balance-9.99) then max(transaction_date) end as pifdate
from transactions t
inner join demographics d 
	 on d.account_id = t.account_id
group by d.account_id
; 
