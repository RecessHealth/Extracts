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
	, employer_known varchar(1)
	, is_employed varchar(1)
	, assigned_date datetime
	, assigend_year varchar(50)
	, assigned_month varchar(50)
	, assigned_week varchar(50)
	, initial_balance int
	, cancelled_amount int
	, calls_by_acctID int
	, calls_by_telephone int
	, status_change_date datetime
	, inventory_age int
	, days_since_discharge int
	, insured varchar(1)
	, governemnt_ins varchar(1) 
	, Day_30 datetime
	, Day_31 datetime 
	, Day_60 datetime
	, Day_61 datetime
	, Day_90 datetime
	, Day_91 datetime
	, Day_120 datetime
	, Day_121 datetime
	, ATB_bucket varchar(50)
	, PPA varchar(1)
)
