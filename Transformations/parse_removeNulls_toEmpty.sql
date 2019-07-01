update BigSquid..Features 
set 
	account_id = coalesce(account_id,'') 
	, client_id = coalesce(client_id, '')
	, patient_age = coalesce(patient_age,'') 
	, city_name = coalesce(city_name, '') 
	, density_estimate = coalesce(density_estimate,'')
	, financial_class = coalesce(financial_class,'') 
	, patient_type = case when patient_type in ('unknown') then '' else patient_type end
	, med_service = case when med_service in ('unknown') then '' else med_service end 
	, assigned_date = coalesce(assigned_date,'')  
	, assigned_year = coalesce(assigned_year,'')
	, assigned_month = coalesce(assigned_month,'') 
	, assigned_week = coalesce(assigned_week,'') 
	, initial_balance = coalesce(initial_balance,'') 
	, paid_in_18 = coalesce(paid_in_18,'0.00')
	, trans_in_18 = coalesce(trans_in_18,'0.00') 
	, insured = coalesce(insured,'') 
	, government_ins = coalesce(government_ins,'') 
	, assign_lag = coalesce(assign_lag,'') 
	, days_to_pif = coalesce(days_to_pif,'')
	, pif_in_18 = coalesce(pif_in_18,'')
	, pif_in_120 = coalesce(pif_in_120,'') 
from staging..Features
where ppa = 0;


