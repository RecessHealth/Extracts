
## Source SQL query

select 
	medical_record, 
	account_id, 
	account_phone, 
	invoice_group,
	provider_patientID,
	client_id,
	[login],
	patient_age_exported,
	export_date,
	account_zip, 
	financial_class,
	patient_type,
	[med_service],
	status_code,
	previous_status_code,
	employer,
	employed = (case when Emp1_Name is NULL then 0 else 1 end),
	assigned_date,
	stmt_1_date,
	last_call,
	last_action_date,
	last_pay_date,
	last_xcso_date, 
	status_change_date,			
	final_statment_date,
	num_ltrs_snt,
	initialload_balance,
	total_balance,
	ttl_pt_pmt,
	cancelled_amount
from tbl_Report_Data;

