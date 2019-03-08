---------------------------------------------
-- Features.csv: export >> feed into ML model 
---------------------------------------------
select 
	d.account_id
	, d.client_id
	, d.patient_age
	, zip_code
	, z.city_name
	, z.county_name
	, z.state_name
	, z.population_estimate
	, z.density_estimate
	, z.local_timezone
	, d.financial_class
	, d.patient_type
	, d.med_service
	, d.status_code
	, d.previous_status_code
    , d.status_change_date
	, d.employer_known
	, d.is_employed
	, d.assigned_date
	, d.assigned_year
	, d.assigned_month
	, d.assigned_week
	, d.initial_balance
	, d.cancelled_balance
	, t.paid_in_30
	, t.paid_in_60
	, t.paid_in_90
	, t.paid_in_120
	, t.trans_in_30
	, t.trans_in_60
	, t.trans_in_90
	, t.trans_in_120
	, d.insured
	, d.government_ins
	, c.calls_in_30
	, c.calls_in_60
	, c.calls_in_90
	, c.calls_in_120
	, c.calls_placed
	, c.calls_by_acctID
	, c.calls_by_telephone
	, d.inventory_age
	, d.days_since_discharge
	, d.ATB_bucket
	, d.PPA
	, CASE 
		WHEN (getdate() < [Day_+120]) AND (t.paid_in_120 < d.initial_balance) THEN NULL 
		ELSE CASE 
			WHEN d.initial_balance = 0 THEN 'false' 
			ELSE
				-- CASE WHEN (t.paid_in_120 / d.initial_balance) >= 0.9 THEN 'true' ELSE 'false' END	-- ?? BUSINESS LOGIC: write-off last 10% ??
				CASE WHEN t.paid_in_120 >= d.initial_balance THEN 'true' ELSE 'false' END
		   END
		END AS pif_in_120
from staging..Demographics d
left join staging..Calls c
	on d.account_id = c.account_id
left join staging..Transactions t 
	on d.account_id = t.account_id 
left join zipcodes z
	on d.zip_code = z.zip_code
where assigned_date < @full_batch