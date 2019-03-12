declare @full_batch date = cast(dateadd(day,-121,getdate()) as varchar);

insert into BigSquid..Features (
	account_id
	, client_id
	, patient_age
	, d.zip_code
	, city_name
	, county_name
	, state_name
	, population_estimate
	, density_estimate
	, local_timezone
	, financial_class
	, patient_type
	, med_service
	, status_code
	, previous_status_code
    , status_change_date
	, employer_known
	, is_employed
	, assigned_date
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, cancelled_amount
	, paid_in_30
	, paid_in_60
	, paid_in_90
	, paid_in_120
	, trans_in_30
	, trans_in_60
	, trans_in_90
	, trans_in_120
	, insured
	, government_ins
	, dialer_in_30
	, dialer_in_60
	, dialer_in_90
	, dialer_in_120
	, outbound_in_30
	, outbound_in_60
	, outbound_in_90
	, outbound_in_120
	, pickup_in_30
	, pickup_in_60
	, pickup_in_90
	, pickup_in_120
	, inbound_in_30
	, inbound_in_60
	, inbound_in_90
	, inbound_in_120
	, phonepay_in_30
	, phonepay_in_60
	, phonepay_in_90
	, phonepay_in_120
	, inventory_age
	, days_since_discharge
	, ATB_bucket
	, pif_in_120
)
select 
	d.account_id
	, client_id
	, patient_age
	, d.zip_code
	, city_name
	, county_name
	, state_name
	, convert(int,[population]) as population_estimate
	, convert(float,[density]) as density_estimate
	, timezone as local_timezone
	, financial_class
	, patient_type
	, med_service
	, status_code
	, previous_status_code
    , status_change_date
	, employer_known
	, is_employed
	, assigned_date
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, cancelled_amount
	, paid_in_30
	, paid_in_60
	, paid_in_90
	, paid_in_120
	, trans_in_30
	, trans_in_60
	, trans_in_90
	, trans_in_120
	, insured
	, government_ins
	, dialer_in_30
	, dialer_in_60
	, dialer_in_90
	, dialer_in_120
	, outbound_in_30
	, outbound_in_60
	, outbound_in_90
	, outbound_in_120
	, pickup_in_30
	, pickup_in_60
	, pickup_in_90
	, pickup_in_120
	, inbound_in_30
	, inbound_in_60
	, inbound_in_90
	, inbound_in_120
	, phonepay_in_30
	, phonepay_in_60
	, phonepay_in_90
	, phonepay_in_120
	, inventory_age
	, days_since_discharge
	, ATB_bucket
	, CASE 
		WHEN (getdate() < [Day_121]) AND (paid_in_120 < initial_balance) THEN NULL					-- ignore if still on conveyor and haven't paid full balance
		ELSE CASE 
			WHEN initial_balance = 0 THEN 'false'													-- ignore if balance paid by assignment
			ELSE
				-- CASE WHEN (paid_in_120 / initial_balance) >= 0.9 THEN 'true' ELSE 'false' END	-- ?? BUSINESS LOGIC: write-off last 10% ??
				CASE WHEN paid_in_120 >= initial_balance THEN 'true' ELSE 'false' END
		   END
		END AS pif_in_120
from staging..Demographics d
left join staging..Calls c
	on d.account_id = c.account_id
left join staging..Transactions t 
	on d.account_id = t.account_id
left join staging..Zipcodes z 
	on d.zip_code = z.zip_code
where 
	assigned_date < @full_batch
	and
	PPA = 0 
; 
