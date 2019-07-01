  delete from model..Day18;
  
  insert into model..Day18 (
  	account_id
  	, client_id
  	, patient_age
  	, density_estimate
  	, financial_class
  	, med_service
  	, assigned_year
  	, assigned_month
  	, assigned_week
  	, initial_balance
  	, dialer_in_18
  	, outbound_in_18
  	, pickup_in_18
  	, inbound_in_18
  	, phonepay_in_18
  	, paid_in_18
  	, trans_in_18 
  	, actual
  	, predicted
 )
select
	account_id
	, case when client_id = '' then null else client_id end as client_id 
 	, case when patient_age = '' then null else left(patient_age,len(patient_age)-2) end as patient_age
 	, case when density_estimate = '' then null else try_convert(float,density_estimate) end as density_estimate
 	, case when financial_class = '' then null else financial_class end as financial_class
 	, case when med_service = '' then null else med_service end as med_service
 	, case when assigned_year = '' then null else left(assigned_year,4) end as assigned_year
 	, case when assigned_month = '' then null else cast(try_convert(float,assigned_month) as int) end as assigned_month
	, case when assigned_week = '' then null else cast(try_convert(float,assigned_week) as int) end as assigned_week
 	, case when initial_balance = '' then null else cast(left(initial_balance,len(initial_balance)-2) as int) end as initial_balance
	, case when dialer_in_18 = '' then null else cast(try_convert(float,dialer_in_18) as int) end as dialer_in_18
	, case when outbound_in_18 = '' then null else cast(try_convert(float,outbound_in_18) as int) end as outbound_in_18
	, case when pickup_in_18 = '' then null else cast(try_convert(float,pickup_in_18) as int) end as pickup_in_18
	, case when inbound_in_18 = '' then null else cast(try_convert(float,inbound_in_18) as int) end as inbound_in_18
	, case when phonepay_in_18 = '' then null else cast(try_convert(float,phonepay_in_18) as int) end  as phonepay_in_18
	, try_convert(decimal(13,2),paid_in_18) as paid_in_18
	, case when trans_in_18 = '' then null else cast(try_convert(float,trans_in_18) as int) end as trans_in_18
	, case when pif_in_30 = '' then null else pif_in_30 end as actual 
	, try_convert(float,pif_in_30_true) as predicted
from openrowset (
	bulk 'C:\Users\jadrummond\Downloads\Features_pif30-Day18_appliedset-20190328_PREDICTED.csv'
	--bulk '\\pfs-fps\home\jadrummond\My Documents\deliverables\Recess\solution\validation\Kraken\Features_pif30-Day18_appliedset-20190326_PREDICTED.csv'
--	, format = 'csv'
	, formatfile = 'C:\Users\jadrummond\Downloads\Features_pif30-Day18_format.txt'
	--, formatfile = '\\pfs-fps\home\jadrummond\My Documents\deliverables\Recess\solution\Kraken\validation\Features_pif30-Day18_format.txt'
	, firstrow = 2
) as predicted ; 


---------------------------------------------------
-- model accuracy 
---------------------------------------------------
-- declare @ValidationSample int = (select count(*) from Predicted)
-- declare @OperationalSample int = (select count(*) from Incumbent)
-- 
-- select 
-- 	Predicted.account_id
-- 	, predicted 
-- 	, actual 
-- 	, case when 
-- into #ValidationSet
-- from Predicted
-- inner join Incumbent
-- 	on Predicted.account_id = Incumbent.account_id 
-- ; 
-- 
-- select 
-- 	(sum(case when predicted = actual then 1 else 0 end)*100.00)/@ValidationSample as model_points
-- 	, (sum(case when incumbent_prediction = [target] then 1 else 0 end)*100.00)/@ValidationSample  as incumbent_points 
-- from #ValidationSet

--------------------------------------------------------------
-- sample accounts 

select 
	m.account_id
	, f.initial_balance
	, coalesce(paid_in_30 ,0) as paid_in_30 
	, actual
	, predicted
	, cast((predicted * m.initial_balance) as decimal(13,2)) as expected_value
from model..Day18 m
inner join staging..Features_staged f
 	on m.account_id = f.account_id 
	and actual is not null 
order by predicted desc, expected_value desc; 



------------------------------------------------------
-- call list 
------------------------------------------------------
declare @opcapacity int = 5000

select top (@opcapacity) 
	account_phone			-- need to group by telephone (one call per guarantor) 
	, m.account_id			-- need to verify sorting by account-level data 
from model..Day18 m 
inner join staging..Demographics d
	on m.account_id = d.account_id
where predicted < .5						-- set business case threshold (guaranteed pif, marginal payers, unlikely payers) 
	and account_phone is not null 
order by predicted desc, (d.initial_balance * predicted) desc


