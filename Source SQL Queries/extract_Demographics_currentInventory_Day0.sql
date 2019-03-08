---------------------------------------------------------------------------------------------------------------
-- #Barncallhistory: grab outbound calls 
---------------------------------------------------------------------------------------------------------------
select
	CUBSID as account_id
	, telephone
	, termcode
	, lastcalldate
	, (case when AgentID not in ('') then 1 else 0 end) as outbound									-- outbound includes manned only, iff CSR available
	, case 
		when termcode in ('03','','16') then 1														-- phone answered by guarantor
		when termcode in ('','01','02','BR','CF','FM','FX','NR','ON','OV','PG','UK') then null		-- technical errors
		else 0 end as pickup
	, (case when termcode in ('13','14','15','17','48','52','PP','VS') then 1 else 0 end) as Phonepay
into #Barncallhistory
from vw_dialerstatsnew
where agentid in ('BRS','BR6','BRB')
; 

---------------------------------------------------------------------------------------------------------------
-- #SECCallHistory: grab inbound calls 
---------------------------------------------------------------------------------------------------------------
select 
	account_id
	, callDate
into #SECCallHistory 
from tbl_InboundCall_History
where logon = 'SEC'; 


---------------------------------------------------------------------------------------------------------------
-- #BarnDemographics: grab demographic data 
---------------------------------------------------------------------------------------------------------------
; with x as (
	select 
		* 
	from tbl_Report_Data 
	where client_id like 'BH%'
)
select 
	account_id
	, account_phone 
	, client_id
	, datediff(year, pt_dob,getdate()) as patient_age
 	, getdate() as export_date
	, case 
		when rtrim(ltrim(len(account_zip))) >= 5 then left(account_zip,5)
		when rtrim(ltrim(len(account_zip))) < 5 then '0' + account_zip
		when rtrim(ltrim(len(account_zip))) = 1 then null  
		else null 
		end as zip_code 
	, coalesce(nullif(nullif(curr_fc,'NULL'),''),'UNKNOWN') as financial_class
	, coalesce(nullif(nullif(pat_type,'NULL'),''),'UNKNOWN') as patient_type
	, coalesce(nullif(nullif(serv_type,'NULL'),''),'UNKNOWN') as [med_service]
 	, status_code 
 	, previous_status_code
	, (case when Emp1_Name in ('NULL', 'UNKNOWN') then 0 else 1 end) as employer_known
	, (case when Emp1_Name in ('unemployed', 'not employed') then 0 when nullif(Emp1_Name,'') <> '' THEN 1 else null end) as is_employed
	, assigned_date 
	, datepart(year, assigned_date) as assigned_year
	, datepart(month, assigned_date) as assigned_month
	, datepart(week, assigned_date) as assigned_week
 --	, num_ltrs_snt as stmts_sent
	, cast(round(assn_bal,0) as int) as initial_balance 
	, cast(round(cancelled_amount,0) as int) as cancelled_amount
-- new features from 3.06.2019
	, cubs_atmps as calls_by_acctID
	, phn_atmps as calls_by_telephone
	, status_change_date
	, case
		when cancelled_date is null then abs(datediff(day, getdate(), assigned_date))
		else abs(datediff(day, cancelled_date, assigned_date)) end 
		as inventory_age 
	, case
		when cancelled_date is null then abs(datediff(day, getdate(), disch_date))
		else abs(datediff(day, cancelled_date, disch_date)) end 
		as days_since_discharge
	, (case when curr_fc in ('1','I5','I6','I7','I8','IB''IA','IC','IS','O') then 0 else 1 end) as insured --codes listed are for self-pay, so inverted binary coding 
	, (case when curr_fc in ('3','3B','3H','3L','3M','3N','3S','3U','3Z','6','6B','6H','6P','C','M','N') then 1 else 0 end) as government_ins 
	, dateadd(day,30,assigned_date) as Day_30 
	, dateadd(day,31,assigned_date) as Day_31 
	, dateadd(day,60,assigned_date) as Day_60 
	, dateadd(day,61,assigned_date) as Day_61
	, dateadd(day,90,assigned_date) as Day_90 
	, dateadd(day,91,assigned_date) as Day_91
	, dateadd(day,120,assigned_date) as Day_120
	, dateadd(day,121,assigned_date) as Day_121
	, case 
		when getdate() <= dateadd(day,30,assigned_date) then '30d'
		when getdate() between dateadd(day,30,assigned_date) and dateadd(day,60,assigned_date) then '60d'
		when getdate() between dateadd(day,60,assigned_date) and dateadd(day,90,assigned_date) then '90d'
		when getdate() between dateadd(day,90,assigned_date) and dateadd(day,120,assigned_date) then '120d'
		when getdate() > dateadd(day,120,assigned_date) then '120+d' 
		else null  
		end as ATB_bucket
	, (case when status_code = 'PPA' then 1 else 0 end) as PPA 
into #BarnDemographics	
from x; 

---------------------------------------------------------------------------------------------------------------
-- #BarnCallStats: aggregate outbound history for each account
---------------------------------------------------------------------------------------------------------------
select 
	z.account_id 
	, count(y.telephone) as dialer_placed											-- number of times [telephone] shows up in dialer
	, sum(case when LastCallDate <= Day_30 then 1 else 0 end) as dialer_in_30		-- dialer includes all blast and manned attempts
	, sum(case when LastCallDate <= Day_30 and outbound = 1 then 1 else 0 end) as outbound_in_30 
	, sum(case when LastCallDate <= Day_30 and pickup = 1 then 1 else 0 end) as pickup_in_30
	, sum(case when LastCallDate <= Day_30 and Phonepay = 1 then 1 else 0 end) as Phonepay_in_30
	, sum(case when (LastCallDate between Day_31 and Day_60) and outbound = 1 then 1 else 0 end) as dialer_in_60
	, sum(case when (LastCallDate between Day_31 and Day_60) and (outbound = 1) then 1 else 0 end) as outbound_in_60
	, sum(case when (LastCallDate between Day_31 and Day_60) and (pickup = 1) then 1 else 0 end) as pickup_in_60
	, sum(case when (LastCallDate between Day_31 and Day_60) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_60
	, sum(case when (LastCallDate between Day_61 and Day_90) and outbound = 1 then 1 else 0 end) as dialer_in_90
	, sum(case when (LastCallDate between Day_61 and Day_90) and (outbound = 1)then 1 else 0 end) as outbound_in_90
	, sum(case when (LastCallDate between Day_61 and Day_90) and (pickup = 1) then 1 else 0 end) as pickup_in_90
	, sum(case when (LastCallDate between Day_61 and Day_90) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_90
	, sum(case when (LastCallDate between Day_91 and Day_120) and outbound = 1 then 1 else 0 end) as dialer_in_120
	, sum(case when (LastCallDate between Day_91 and Day_120) and (outbound = 1)then 1 else 0 end) as outbound_in_120
	, sum(case when (LastCallDate between Day_91 and Day_120) and (pickup = 1) then 1 else 0 end) as pickup_in_120
	, sum(case when (LastCallDate between Day_91 and Day_120) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_120
	, sum(case when lastcalldate > Day_120 and (outbound = 1) then 1 else 0 end) as outbound_over_120
into #BarnCallsStats
from #Barncallhistory y 
right join #BarnDemographics z  
	on y.account_id = z.account_id
group by z.account_id
; 


---------------------------------------------------------------------------------------------------------------
-- #BarnIBStats: aggregate inbound history for each account
---------------------------------------------------------------------------------------------------------------
select 
	z.account_id 
	, sum(case when CallDate <= Day_30 then 1 else 0 end) as inbound_in_30
	, sum(case when (CallDate between Day_31 and Day_60) then 1 else 0 end) as inbound_in_60
	, sum(case when (CallDate between Day_61 and Day_90) then 1 else 0 end) as inbound_in_90
	, sum(case when (CallDate between Day_91 and Day_120) then 1 else 0 end) as inbound_in_120
	, sum(case when calldate > Day_120 then 1 else 0 end) as inbound_over_120
into #BarnIBStats
from #SECCallHistory w 
right join #BarnDemographics z  
	on w.account_id = z.account_id
group by z.account_id
; 


---------------------------------------------------------------------------------------------------------------
--  #BarnCallExport: merge IB/OB call history for each account
---------------------------------------------------------------------------------------------------------------
select 
	g.account_id 
	, dialer_in_30 
	, outbound_in_30
	, pickup_in_30
	, inbound_in_30
	, Phonepay_in_30
	, dialer_in_60 
	, outbound_in_60
	, pickup_in_60
	, inbound_in_60
	, Phonepay_in_60
	, dialer_in_90 
	, outbound_in_90
	, pickup_in_90
	, inbound_in_90
	, Phonepay_in_90
	, dialer_in_120 
	, outbound_in_120
	, pickup_in_120
	, inbound_in_120
	, Phonepay_in_120
	, dialer_placed as total_dialer_placed
into #BarnCallExport
from #BarnCallsStats g
left join #BarnIBStats h
	on g.account_id = h.account_id
; 


--------------------------------------------------------------------------
-- export output tables
-------------------------------------------------------------------------
select * from #BarnDemographics; 
select * from #BarnCallExport;

------------------------------------------------------------------------
--drop table #Barncallhistory; 
--drop table #BarnCallsStats;
--drop table #BarnDemographics;
--drop table #BarnIBStats;
--drop table #SECCallHistory;
--drop table #BarnCallExport;