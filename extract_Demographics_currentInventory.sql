--; declare @date date = (select getdate()-1) -- date filter = yesterday
--select cast(@date as datetime) -- format to match [assigned_date] datetime type at 00:00:00 

select 
--	med_rec_num as medical_record, 
	account_id, 
	account_phone, 
	client_id,
	datediff(year, pt_dob,getdate()) as patient_age_exported,
	getdate() as export_date,
	case
		when cancelled_date is null then abs(datediff(day, getdate(), assigned_date))
		else abs(datediff(day, cancelled_date, assigned_date)) end 
		as inventory_age, 
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
into #TempBarnInventoryDems
from tbl_Report_Data 
where 
	client_id like 'BH%' 
--	and 
--	assigned_date = @date
;

