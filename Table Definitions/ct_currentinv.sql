create table Demographics_currentInventory.csv (
	medical_record varchar(7), 
	account_id varchar(8), 
	account_phone varchar(10), 
	invoice_group varchar(20),
	provider_patientID varchar(16),
	client_id varchar(10),
	[login] varchar(10),
	patient_age_exported varchar(3),
	export_date datetime,
	account_zip varchar(9), 
	financial_class varchar(50),
	patient_type varchar(100),
	[med_service] varchar(50),
	status_code varchar(3),
	previous_status_code varchar(3),
	employer varchar(150),
	employed = (case when Emp1_Name is NULL then 0 else 1 end) tinyint,
	assigned_date datetime,
	stmt_1_date datetime,
	last_call datetime,
	last_action_date datetime,
	last_pay_date datetime,
	last_xcso_date datetime, 
	status_change_date datetime,			
	final_statment_date datetime,
	num_ltrs_snt int,
	initialload_balance float(17,2),
	total_balance float(17,2),
	ttl_pt_pmt float(17,2),
	cancelled_amount float(17,2)
)
