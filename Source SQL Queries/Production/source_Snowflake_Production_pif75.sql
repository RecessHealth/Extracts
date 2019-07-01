merge into pif75_source t
using (
-- gather new accounts into applied set 
	select * 
	from staging.&client.vw_features 
	where 
		pif_in_75 is null 
		and (
			(
--				called=0 and
				atb_bucket = 60
			) 
			or (
				called=1 
				and atb_bucket=45
			)
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set 
	t.outbound_in_60 = s.outbound_in_60
	, t.pickup_in_60 = s.pickup_in_60
	, t.inbound_in_60 = s.inbound_in_60
	, t.phonepay_in_60 = s.phonepay_in_60
	, t.paid_in_60 = s.paid_in_60
	, t.trans_in_60 = s.paid_in_60 
	, t.pif_in_75 = s.pif_in_75 
when not matched then 
insert (
    account_id 
    , client_id
    , patient_age
    , density_estimate
    , financial_class
    , patient_type
    , med_service
    , assigned_year
    , assigned_month
    , assigned_week
    , initial_balance
    , outbound_in_60
    , pickup_in_60
    , inbound_in_60
    , phonepay_in_60
    , paid_in_60
    , trans_in_60 
    , pif_in_75 
) 
values (
    account_id 
    , client_id
    , patient_age
    , density_estimate
    , financial_class
    , patient_type
    , med_service
    , assigned_year
    , assigned_month
    , assigned_week
    , initial_balance
    , outbound_in_60
    , pickup_in_60
    , inbound_in_60
    , phonepay_in_60
    , paid_in_60
    , trans_in_60 
    , pif_in_75 
)
; 

-- graduate accounts that have been predicted on and called 
delete 
from pif75_source t
using staging.&client.vw_features s
where 
	s.account_id = t.account_id 
	and s.pif_in_75 is null 
	and s.atb_bucket = 60
	and s.called = 1 
; 

-- update existing accounts from applied set that have aged or pif'd into training data without having been called 
update production.rwjb.pif75_source t
set t.pif_in_75 = s.pif_in_75
from (
    select 
        account_id
        , pif_in_75 
    from staging.rwjb.vw_features 
    where pif_in_75 is not null 
)  s 
where t.pif_in_75 is null 
and s.account_id = t.account_id 