-- Model v1.2
-- dated 2.27.2019

create table Predicted (
	account_id varchar(8) 
	, client_id varchar(7)
	, patient_age varchar(3)
	, zip_code varchar(10)
	, city_name varchar(20) 
	, county_name varchar(20)
	, state_name varchar(20) 
	, population_estimate int
	, density_estimate decimal(13,2)
	, local_timezone varchar(100)
	, financial_class varchar(100)
	, patient_type varchar(100)
	, med_service varchar(100)
	, status_code varchar(3)
	, previous_status_code varchar(3)
	, employer_known bit
	, is_employed bit
	, assigned_date date
	, assigned_year varchar(4)
	, assigned_month varchar(2)
	, assigned_week varchar(2)
	, initial_balance decimal(13,2)
	, cancelled_balance decimal(13,2)
	, paid_in_30 decimal(13,2)
	, paid_in_60 decimal(13,2)
	, paid_in_90 decimal(13,2)
	, paid_in_120 decimal(13,2)
	, trans_in_30 bit
	, trans_in_60 bit
	, trans_in_90 bit
	, trans_in_120 bit
	, pif_in_120 varchar(10)
	, pif_in_120_predicted varchar(10)
	, pif_in_120_predicted_false decimal(2,1)
	, pif_in_120_predicted_true decimal(2,1)
)