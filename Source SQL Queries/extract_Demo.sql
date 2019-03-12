select
	account_id	-- unique ID 
	, client_id
	, patient_age
	, zip_code
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
	, employer_known
	, is_employed
	, assigned_date
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, cancelled_balance
	, paid_in_30
	, paid_in_60
	, paid_in_90
	, paid_in_120
	, trans_in_30
	, trans_in_60
	, trans_in_90
	, trans_in_120
	, pif_in_120		-- target
 from BigSquid..Predicted
 ;
