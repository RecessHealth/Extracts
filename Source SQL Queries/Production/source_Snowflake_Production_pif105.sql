merge into pif105_source t
using (
-- gather new accounts into applied set 
	select * 
	from staging.&client.vw_features 
	where 
		pif_in_105 is null 
		and (
			(
--				called=0 and
				atb_bucket = 90
			) 
			or (
				called=1 
				and atb_bucket=75
			)
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set 
	t.outbound_in_90 = s.outbound_in_90
	, t.pickup_in_90 = s.pickup_in_90
	, t.inbound_in_90 = s.inbound_in_90
	, t.phonepay_in_90 = s.phonepay_in_90
	, t.paid_in_90 = s.paid_in_90
	, t.trans_in_90 = s.paid_in_90 
	, t.pif_in_105 = s.pif_in_105 
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
    , outbound_in_90
    , pickup_in_90
    , inbound_in_90
    , phonepay_in_90
    , paid_in_90
    , trans_in_90 
    , pif_in_105 
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
    , outbound_in_90
    , pickup_in_90
    , inbound_in_90
    , phonepay_in_90
    , paid_in_90
    , trans_in_90 
    , pif_in_105 
)
; 

-- graduate existing accounts in applied set to next model if already called and predicted on 
delete 
from pif105_source t
using staging.&client.vw_features s
where 
	s.account_id = t.account_id 
	and s.pif_in_105 is null 
	and s.atb_bucket = 90
	and s.called = 1 
; 

-- update existing applied set accounts that have aged or pif'd into training set without having been called 
update production.rwjb.pif105_source t
set t.pif_in_105 = s.pif_in_105
from (
    select 
        account_id
        , pif_in_105 
    from staging.rwjb.vw_features 
    where pif_in_105 is not null 
)  s 
where t.pif_in_105 is null 
and s.account_id = t.account_id 
; 