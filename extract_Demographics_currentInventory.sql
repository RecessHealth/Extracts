-- account_id is invoice not actual individual 
-- possible groupings to true individual (rather than invoices): group by medical_record or account_phone 


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
	employed = case when Emp1_Name in ('unemployed', 'not employed') then 0 when Emp1_Name <> '' THEN 1 else null end,
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
from tbl_Report_Data
where client_id like 'BH%'


