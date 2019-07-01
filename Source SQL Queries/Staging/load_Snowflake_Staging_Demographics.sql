merge into demographics as t 
using demographics_staging as s 
on t.account_id = s.account_id
when matched 
--	and exists (
--		select s.desk_id, s.client_id, s.patient_age, s.export_date, s.zip_code, s.financial_class, s.patient_type, s.med_service, s.assigned_date, s.assigned_year, s.assigned_month, s.assigned_week, s.initial_balance
--		except  
--		select t.desk_id, t.client_id, t.patient_age, t.export_date, t.zip_code, t.financial_class, t.patient_type, t.med_service, t.assigned_date, t.assigned_year, t.assigned_month, t.assigned_week, t.initial_balance
--	) 
then update set 
		t.desk_id = s.desk_id
		, t.client_id = s.client_id 
		, t.patient_age = s.patient_age
		, t.export_date = coalesce(try_to_timestamp(s.export_date), to_timestamp_ntz(current_timestamp()))   
		, t.zip_code = case when s.zip_code like '0%' then right(s.zip_code, length(s.zip_code)-regexp_instr('0%',s.zip_code)) when length(s.zip_code) <=2 then null else s.zip_code end
		, t.financial_class = s.financial_class
		, t.patient_type = s.patient_type
 		, t.med_service = s.med_service
 		, t.assigned_date = case when length(s.assigned_date) < 10 then null else try_to_date(left(s.assigned_date,10)) end 
 		, t.assigned_year = s.assigned_year
 		, t.assigned_month = s.assigned_month 
 		, t.assigned_week = s.assigned_week 
 		, t.initial_balance = try_to_number(s.initial_balance)
 		, t.inventory_age = abs(datediff(day,try_to_date(s.assigned_date),current_date()))
 		, t.Day_18 = case when length(s.Day_18) < 10 then null else try_to_date(left(s.Day_18,10)) end
		, t.Day_19 = case when length(s.Day_19) < 10 then null else try_to_date(left(s.Day_19,10)) end
		, t.Day_29 = case when length(s.Day_29) < 10 then null else try_to_date(left(s.Day_29,10)) end
		, t.Day_30 = case when length(s.Day_30) < 10 then null else try_to_date(left(s.Day_30,10)) end
 		, t.Day_31 = case when length(s.Day_31) < 10 then null else try_to_date(left(s.Day_31,10)) end
        , t.Day_44 = case when length(s.Day_44) < 10 then null else try_to_date(left(s.Day_44,10)) end
        , t.Day_45 = case when length(s.Day_45) < 10 then null else try_to_date(left(s.Day_45,10)) end
 		, t.Day_46 = case when length(s.Day_46) < 10 then null else try_to_date(left(s.Day_46,10)) end
		, t.Day_59 = case when length(s.Day_59) < 10 then null else try_to_date(left(s.Day_59,10)) end
		, t.Day_60 = case when length(s.Day_60) < 10 then null else try_to_date(left(s.Day_60,10)) end
 		, t.Day_61 = case when length(s.Day_61) < 10 then null else try_to_date(left(s.Day_61,10)) end
		, t.Day_74 = case when length(s.Day_74) < 10 then null else try_to_date(left(s.Day_74,10)) end
        , t.Day_75 = case when length(s.Day_75) < 10 then null else try_to_date(left(s.Day_75,10)) end
        , t.Day_76 = case when length(s.Day_76) < 10 then null else try_to_date(left(s.Day_76,10)) end
		, t.Day_89 = case when length(s.Day_89) < 10 then null else try_to_date(left(s.Day_89,10)) end
 		, t.Day_90 = case when length(s.Day_90) < 10 then null else try_to_date(left(s.Day_90,10)) end
 		, t.Day_91 = case when length(s.Day_91) < 10 then null else try_to_date(left(s.Day_91,10)) end
		, t.Day_104 = case when length(s.Day_104) < 10 then null else try_to_date(left(s.Day_104,10)) end
        , t.Day_105 = case when length(s.Day_105) < 10 then null else try_to_date(left(s.Day_105,10)) end
        , t.Day_106 = case when length(s.Day_106) < 10 then null else try_to_date(left(s.Day_106,10)) end
		, t.Day_119 = case when length(s.Day_119) < 10 then null else try_to_date(left(s.Day_119,10)) end
 		, t.Day_120 = case when length(s.Day_120) < 10 then null else try_to_date(left(s.Day_120,10)) end
 		, t.Day_121 = case when length(s.Day_121) < 10 then null else try_to_date(left(s.Day_121,10)) end
		, t.lastModified = to_timestamp_ntz(current_timestamp())
		, t.sp_bai = case when (s.client_id like '%0' or s.client_id like '%3') then 'SP' when (s.client_id like '%1' or s.client_id like '%2') then 'BAI' end
when not matched then 
	insert (
 		account_id
 		, desk_id
 		, client_id
 		, patient_age
 		, export_date
 		, zip_code
 		, financial_class
 		, patient_type
 		, med_service
 		, assigned_date
 		, assigned_year
 		, assigned_month
 		, assigned_week
 		, initial_balance
 		, inventory_age
 		, Day_18
		, Day_19
		, Day_29
		, Day_30
 		, Day_31
		, Day_44
        , Day_45
        , Day_46
		, Day_59
 		, Day_60
 		, Day_61
		, Day_74
        , Day_75
        , Day_76
		, Day_89
 		, Day_90
 		, Day_91
		, Day_104
        , Day_105
        , Day_106
		, Day_119 
 		, Day_120
 		, Day_121
		, lastModified
		, sp_bai 
	)
	values (
		try_to_number(s.account_id)
		, s.desk_id
		, s.client_id 
		, s.patient_age
		, coalesce(try_to_timestamp(s.export_date), to_timestamp_ntz(current_timestamp()))  
		, case when s.zip_code like '0%' then right(s.zip_code, length(s.zip_code)-regexp_instr('0%',s.zip_code)) when length(s.zip_code) <=2 then null else s.zip_code end
		, s.financial_class
		, s.patient_type
 		, s.med_service
 		, case when length(s.assigned_date) < 10 then null else try_to_date(left(s.assigned_date,10)) end 
 		, s.assigned_year
 		, try_to_number(s.assigned_month) 
 		, try_to_number(s.assigned_week) 
 		, try_to_number(s.initial_balance)
 		, abs(datediff(day,try_to_date(s.assigned_date),current_date()))
 		, case when length(s.Day_18) < 10 then null else try_to_date(left(s.Day_18,10)) end
		, case when length(s.Day_19) < 10 then null else try_to_date(left(s.Day_19,10)) end
		, case when length(s.Day_29) < 10 then null else try_to_date(left(s.Day_29,10)) end
		, case when length(s.Day_30) < 10 then null else try_to_date(left(s.Day_30,10)) end
 		, case when length(s.Day_31) < 10 then null else try_to_date(left(s.Day_31,10)) end
        , case when length(s.Day_44) < 10 then null else try_to_date(left(s.Day_44,10)) end
        , case when length(s.Day_45) < 10 then null else try_to_date(left(s.Day_45,10)) end
 		, case when length(s.Day_46) < 10 then null else try_to_date(left(s.Day_46,10)) end
		, case when length(s.Day_59) < 10 then null else try_to_date(left(s.Day_59,10)) end
		, case when length(s.Day_60) < 10 then null else try_to_date(left(s.Day_60,10)) end
 		, case when length(s.Day_61) < 10 then null else try_to_date(left(s.Day_61,10)) end
		, case when length(s.Day_74) < 10 then null else try_to_date(left(s.Day_74,10)) end
        , case when length(s.Day_75) < 10 then null else try_to_date(left(s.Day_75,10)) end
        , case when length(s.Day_76) < 10 then null else try_to_date(left(s.Day_76,10)) end
		, case when length(s.Day_89) < 10 then null else try_to_date(left(s.Day_89,10)) end
 		, case when length(s.Day_90) < 10 then null else try_to_date(left(s.Day_90,10)) end
 		, case when length(s.Day_91) < 10 then null else try_to_date(left(s.Day_91,10)) end
		, case when length(s.Day_104) < 10 then null else try_to_date(left(s.Day_104,10)) end
        , case when length(s.Day_105) < 10 then null else try_to_date(left(s.Day_105,10)) end
        , case when length(s.Day_106) < 10 then null else try_to_date(left(s.Day_106,10)) end
		, case when length(s.Day_119) < 10 then null else try_to_date(left(s.Day_119,10)) end
 		, case when length(s.Day_120) < 10 then null else try_to_date(left(s.Day_120,10)) end
 		, case when length(s.Day_121) < 10 then null else try_to_date(left(s.Day_121,10)) end
		, null 
		, case when (s.client_id like '%0' or s.client_id like '%3') then 'SP' when (s.client_id like '%1' or s.client_id like '%2') then 'BAI' end
	)
;
update demographics 
set 
	ATB_bucket = case 
		when inventory_age < 18 then null 
		when inventory_age between 18 and 29 then '18' 
		when inventory_age between 30 and 44 then '30' 
		when inventory_age between 45 and 59 then '45' 
		when inventory_age between 60 and 74 then '60' 
		when inventory_age between 75 and 89 then '75' 
		when inventory_age between 90 and 104 then '90' 
		when inventory_age between 105 and 119 then '105' 
		when inventory_age >= 120 then null end
	, lastModified=to_timestamp_ntz(current_timestamp()) 
where 
	inventory_age between 18 and 120;    
