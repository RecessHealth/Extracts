----------------------------------------
-- clean up manual query to file 
-- delete affected record count appended to file
---------------------------------------

-- delete from Demographics_staged 
-- where 
-- 	account_id = '' 
-- 	or 
-- 	account_id like '%row(s) affected)'

-----------------------------------
-- datetime debugging 
-----------------------------------
-- select 
-- 	account_id
-- 	, export_date
-- from Demographics_staged
-- where isdate(export_date) = 0 

 insert into Demographics (
 	account_id
 	, account_phone
 	, client_id
 	, patient_age
 	, export_date
 	, zip_code
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
 	, cancelled_amount
 	, calls_by_acctID
 	, calls_by_telephone
 	, status_change_date
 	, inventory_age
 	, days_since_discharge
 	, insured
 	, government_ins
 	, Day_30
 	, Day_31
 	, Day_60
 	, Day_61
 	, Day_90
 	, Day_91
 	, Day_120
 	, Day_121
 	, ATB_bucket
 	, PPA
 )
	select 
		account_id
		, account_phone
		, client_id
		, patient_age
		, case 
			when export_date = 'NULL' then convert(datetime2,getdate(), 102) 
			when len(export_date) < 23 then convert(datetime2,getdate(),102) 
			else convert(date,export_date,102) 
			end as export_date
		, zip_code
		, financial_class
		, patient_type
		, med_service
		, status_code
		, previous_status_code
		, employer_known 
		, case when 
			is_employed = 'NULL' then null
			else is_employed
			end as is_employed
		, case 
			when assigned_date = 'NULL' then null
			when len(assigned_date) < 23 then null
			else convert(date,left(assigned_date,10),102) 
			end as assigned_date 
		, assigned_year
		, assigned_month
		, assigned_week
		, case
			when initial_balance = 'NULL' then null
			else initial_balance 
			end as initial_balance
		, case	
			when cancelled_amount = 'NULL' then null
			else cancelled_amount 
			end as cancelled_amount
		, case
			when calls_by_acctID = 'NULL' then null
			else calls_by_acctID 
			end as calls_by_acctID
		, case 
			when calls_by_telephone = 'NULL' then null
			else calls_by_telephone 
			end as calls_by_telephone
		, case 
			when status_change_date = 'NULL' then null
			else convert(date,left(status_change_date,10),102)
			end as status_change_date 
		, case 
			when inventory_age = 'NULL' then null
			else inventory_age 
			end as inventory_age 
		, case 
			when days_since_discharge = 'NULL' then null
			else days_since_discharge 
			end as days_since_discharge
		, insured
		, government_ins
		, case
			when Day_30 = 'NULL' then null
			when len(Day_30) < 23 then null
			else convert(date,left(Day_30,10),102)
			end as Day_30
		, case
			when Day_31 = 'NULL' then null
			when len(Day_31) < 23 then null
			else convert(date,left(Day_31,10),102)
			end as Day_31
		, case
			when Day_60 = 'NULL' then null
			when len(Day_60) < 23 then null
			else convert(date,left(Day_60,10),102) 
			end as Day_60
		, case
			when Day_61 = 'NULL' then null
			when len(Day_61) < 23 then null
			else convert(date,Day_61,102)
			end as Day_61
		, case
			when Day_90 = 'NULL' then null
			when len(Day_90) < 23 then null
			else convert(date,Day_90,102) 
			end as Day_90
		, case
			when Day_91 = 'NULL' then null
			when len(Day_91) < 23 then null
			else convert(date,Day_91,102) 
			end as Day_91
		, case
			when Day_120 = 'NULL' then null
			when len(Day_120) < 23 then null
			else convert(date,Day_120,102) 
			end as Day_120
		, case
			when Day_121 = 'NULL' then null 
			when len(Day_121) < 23 then null
			else convert(date,Day_121,102)
			end as Day_121
		, ATB_bucket
		, PPA 
	from Demographics_staged



 
