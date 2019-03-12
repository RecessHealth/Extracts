create table Demographics (
	account_id varchar(50)
	, account_phone varchar(50)
	, client_id varchar(50)
	, patient_age varchar(50)
	, export_date datetime
	, zip_code varchar(50)
	, financial_class varchar(50)
	, patient_type varchar(50)
	, med_service varchar(50)
	, status_code varchar(50)
	, previous_status_code varchar(50)
	, employer_known varchar(4)
	, is_employed varchar(4)
	, assigned_date date
	, assigned_year varchar(50)
	, assigned_month varchar(50)
	, assigned_week varchar(50)
	, initial_balance int
	, cancelled_amount int
	, calls_by_acctID int
	, calls_by_telephone int
	, status_change_date date
	, inventory_age int
	, days_since_discharge int
	, insured varchar(4)
	, government_ins varchar(4) 
	, Day_30 date
	, Day_31 date 
	, Day_60 date
	, Day_61 date
	, Day_90 date
	, Day_91 date
	, Day_120 date
	, Day_121 date
	, ATB_bucket varchar(50)
	, PPA varchar(4)
)