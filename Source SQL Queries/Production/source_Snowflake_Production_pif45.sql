merge into pif45_source t
using (
-- gather applied set 
	select * 
	from staging.&client.vw_features 
	where 
		pif_in_45 is null 
		and (
			(
--				called=0  and
				atb_bucket = 30
			) 
			or (
				called=1 
				and atb_bucket=18
			)
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set 
	t.outbound_in_30 = s.outbound_in_30
	, t.pickup_in_30 = s.pickup_in_30
	, t.inbound_in_30 = s.inbound_in_30
	, t.phonepay_in_30 = s.phonepay_in_30
	, t.paid_in_30 = s.paid_in_30
	, t.trans_in_30 = s.paid_in_30 
	, t.pif_in_45 = s.pif_in_45 
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
    , outbound_in_30
    , pickup_in_30
    , inbound_in_30
    , phonepay_in_30
    , paid_in_30
    , trans_in_30 
    , pif_in_45 
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
    , outbound_in_30
    , pickup_in_30
    , inbound_in_30
    , phonepay_in_30
    , paid_in_30
    , trans_in_30 
    , pif_in_45 
)
; 

-- graduate accounts that have been predicted on and called 
--delete 
--from pif45_source t
--using staging.&client.vw_features s
--where 
--	s.account_id = t.account_id 
--	and s.pif_in_45 is null 
--	and s.atb_bucket = 30
--	and s.called = 1 
--; 

-- update accounts that have aged from applied data to training data without having been called
update production.rwjb.pif45_source t
set t.pif_in_45 = s.pif_in_45
from (
    select 
        account_id
        , pif_in_45 
    from staging.rwjb.vw_features 
    where pif_in_45 is not null 
)  s 
where t.pif_in_45 is null 
and s.account_id = t.account_id 
; 