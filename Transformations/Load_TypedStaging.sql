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
		, convert(datetime,export_date,101)
		, zip_code
		, financial_class
		, patient_type
		, med_service
		, status_code
		, previous_status_code
		, employer_known 
		, is_employed
		, case 
			when assigned_date = 'NULL' then getdate()
			when len(assigned_date) < 23 then getdate()
			else convert(datetime,assigned_date,101) 
			end as assigned_date 
		, assigned_year
		, assigned_month
		, assigned_week
		, case
			when initial_balance = 'NULL' then 0
			else initial_balance 
			end as initial_balance
		, case	
			when cancelled_amount = 'NULL' then 0
			else cancelled_amount 
			end as cancelled_amount
		, case
			when calls_by_acctID = 'NULL' then 0
			else calls_by_acctID 
			end as calls_by_acctID
		, case 
			when calls_by_telephone = 'NULL' then 0
			else calls_by_telephone 
			end as calls_by_telephone
		, case 
			when status_change_date = 'NULL' then ''
			else status_change_date 
			end as status_change_date 
		, case 
			when inventory_age = 'NULL' then 0
			else inventory_age 
			end as inventory_age 
		, case 
			when days_since_discharge = 'NULL' then 0
			else days_since_discharge 
			end as days_since_discharge
		, insured
		, government_ins
		, case
			when Day_30 = 'NULL' then ''
			else convert(datetime,Day_30,101)
			end as Day_30
		, case
			when Day_31 = 'NULL' then ''
			else convert(datetime,Day_31,101)
			end as Day_31
		, case
			when Day_60 = 'NULL' then ''
			else convert(datetime,Day_60,101) 
			end as Day_60
		, case
			when Day_61 = 'NULL' then ''
			else convert(datetime,Day_61,101)
			end as Day_60
		, case
			when Day_90 = 'NULL' then ''
			else convert(datetime,Day_90,101) 
			end as Day_90
		, case
			when Day_91 = 'NULL' then ''
			else convert(datetime,Day_91,101) 
			end as Day_91
		, case
			when Day_120 = 'NULL' then ''
			else convert(datetime,Day_120,101) 
			end as Day_120
		, case
			when Day_121 = 'NULL' then '' 
			else convert(datetime,Day_121,101)
			end as Day_121
		, ATB_bucket
		, PPA 
	from Demographics_staged

-- select 
-- 	a.name
-- 	, a.column_id 
-- 	, b.name
-- 	, a.max_length
-- 	, a.precision
-- 	, a.scale
-- 	, a.collation_name
-- from sys.columns a
-- inner join sys.types b 
-- 	on a.system_type_id = b.system_type_id
-- where object_id = object_id('Demographics')
-- order by column_id asc; 

-- select 
-- 	max(len(account_id)) as account_id
-- 	, max(len(account_phone)) as account_phone
-- 	, max(len(client_id)) as client_id
-- 	, max(len(patient_age)) as patient_age
-- 	, max(len(export_date)) as export_date
-- 	, max(len(zip_code)) as zip_code
-- 	, max(len(financial_class)) as financial_class
-- 	, max(len(patient_type)) as patient_type
-- 	, max(len(med_service)) as med_service
-- 	, max(len(status_code)) as status_code
-- 	, max(len(previous_status_code)) as previous_status_code
-- 	, max(len(employer_known)) as employer_known
-- 	, max(len(is_employed)) as is_employed
-- 	, max(len(assigned_date)) as assigned_date
-- 	, max(len(assigned_year)) as assigned_year
-- 	, max(len(assigned_month)) as assigned_month
-- 	, max(len(assigned_week)) as assigned_week
-- 	, max(len(initial_balance)) as initial_balance
-- 	, max(len(cancelled_amount)) as cancelled_amount
-- 	, max(len(calls_by_acctID)) as calls_by_acctID
-- 	, max(len(calls_by_telephone)) as calls_by_telephone
-- 	, max(len(status_change_date)) as status_change_date
-- 	, max(len(inventory_age)) as inventory_age
-- 	, max(len(days_since_discharge)) as days_since_discharge
-- 	, max(len(insured)) as insured
-- 	, max(len(government_ins)) as government_ins
-- 	, max(len(Day_30)) as Day30
-- 	, max(len(Day_31)) as day31
-- 	, max(len(Day_60)) as day60
-- 	, max(len(Day_61)) as day61
-- 	, max(len(Day_90)) as day90
-- 	, max(len(Day_91)) as day91
-- 	, max(len(Day_120)) as day120
-- 	, max(len(Day_121)) as day121
-- 	, max(len(ATB_bucket)) as atb
-- 	, max(len(PPA)) as ppa
-- from Demographics_staged

select
	convert(assi)
	--convert(datetime,assigned_date,101) 
from Demographics_staged
order by assigned_date asc; 