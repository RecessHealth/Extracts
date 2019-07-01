merge into pif60_source t
using (
-- gather new accounts into applied set 
	select * 
	from staging.&client.vw_features 
	where 
		pif_in_60 is null 
		and (
			(
--				called=0 and
				atb_bucket = 45
			) 
			or (
				called=1 
				and atb_bucket=30
			)
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set 
	t.outbound_in_45 = s.outbound_in_45
	, t.pickup_in_45 = s.pickup_in_45
	, t.inbound_in_45 = s.inbound_in_45
	, t.phonepay_in_45 = s.phonepay_in_45
	, t.paid_in_45 = s.paid_in_45
	, t.trans_in_45 = s.paid_in_45 
	, t.pif_in_60 = s.pif_in_60 
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
    , outbound_in_45
    , pickup_in_45
    , inbound_in_45
    , phonepay_in_45
    , paid_in_45
    , trans_in_45 
    , pif_in_60 
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
    , outbound_in_45
    , pickup_in_45
    , inbound_in_45
    , phonepay_in_45
    , paid_in_45
    , trans_in_45 
    , pif_in_60 
)
; 

-- graduate existing accounts that have been called and predicted on 
delete 
from pif60_source t
using staging.&client.vw_features s
where 
	s.account_id = t.account_id 
	and s.pif_in_60 is null 
	and s.atb_bucket = 45
	and s.called = 1 
; 

-- update existing accounts that have graduated or aged from applied set to training set without having been called 
update production.rwjb.pif60_source t
set t.pif_in_60 = s.pif_in_60
from (
    select 
        account_id
        , pif_in_60 
    from staging.rwjb.vw_features 
    where pif_in_60 is not null 
)  s 
where t.pif_in_60 is null 
and s.account_id = t.account_id 