-- Project Theta extract from tbl_Report_Data
-- Demographic purposes only 
-- snapshot, pulled from CUBS previous night (check [export_date])

select 
	med_rec_num as medical_record, 
	account_id, 
	account_phone, 
	packet_id as invoice_group,
	patient_number as provider_patientID,
	client_id,
	logon as [login],
	datediff(year, pt_dob,getdate()) as patient_age_exported,
	getdate() as export_date,
	account_zip, 
	curr_fc as financial_class,
	pat_type as patient_type,
	serv_type as [med_service],
	status_code,
	previous_status_code,
	Emp1_Name as employer,
	employed = (case when Emp1_Name is NULL then 0 else 1 end),
	assigned_date,
	first_stm_dt as stmt_1_date,
	last_call,
	last_action_date,
	last_pay_date,
	ccpymt_date as last_xcso_date, 
	status_change_date,			
	fn_snt_dt as final_statment_date,
	num_ltrs_snt,
	assn_bal as initialload_balance,
	total_balance,
	ttl_pt_pmt,
	cancelled_amount
from tbl_Report_Data;





