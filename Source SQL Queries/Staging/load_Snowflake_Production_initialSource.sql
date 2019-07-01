insert into production.&client.pif30_source 
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_18
	, pickup_in_18
	, inbound_in_18
	, phonepay_in_18
	, paid_in_ 18
	, trans_in_18
	, pif_in_30
from staging.&client.vw_features 
where 
	pif_in_30 is not null 
	and pif_in_18 = false 
limit 1000000
;

insert into production.&client.pif45_source
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_30
	, pickup_in_30
	, inbound_in_30
	, phonepay_in_30
	, paid_in_ 30
	, trans_in_30
	, pif_in_45
from staging.&client.vw_features 
where 
	pif_in_45 is not null 
	and pif_in_30 = false 
limit 1000000
;

insert into production.&client.pif60_source 
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_45
	, pickup_in_45
	, inbound_in_45
	, phonepay_in_45
	, paid_in_45
	, trans_in_45
	, pif_in_60
from staging.&client.vw_features 
where 
	pif_in_60 is not null 
	and pif_in_45 = false 
limit 1000000
;

insert into production.&client.pif75_source 
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_60
	, pickup_in_60
	, inbound_in_60
	, phonepay_in_60
	, paid_in_60 
	, trans_in_60
	, pif_in_75
from staging.&client.vw_features 
where 
	pif_in_75 is not null 
	and pif_in_60 = false 
limit 1000000
;

insert into production.&client.pif90_source 
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_75
	, pickup_in_75
	, inbound_in_75
	, phonepay_in_75
	, paid_in_75 
	, trans_in_75
	, pif_in_90
from staging.&client.vw_features 
where 
	pif_in_90 is not null 
	and pif_in_75 = false 
limit 1000000
;

insert into production.&client.pif105_source 
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_90
	, pickup_in_90
	, inbound_in_90
	, phonepay_in_90
	, paid_in_90
	, trans_in_90
	, pif_in_105
from staging.&client.vw_features 
where 
	pif_in_105 is not null 
	and pif_in_90 = false 
limit 1000000
;

insert into production.&client.pif120_source 
select 
	account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_105
	, pickup_in_105
	, inbound_in_105
	, phonepay_in_105
	, paid_in_105 
	, trans_in_105
	, pif_in_120
from staging.&client.vw_features 
where 
	pif_in_120 is not null 
	and pif_in_105 = false 
limit 1000000
;