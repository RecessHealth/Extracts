merge into pif90_source t
using (
-- gather new accounts into applied set 
	select * 
	from staging.&client.vw_features 
	where 
		pif_in_90 is null 
		and (
			(
--				called=0 and
				atb_bucket = 75
			) 
			or (
				called=1 
				and atb_bucket=60
			)
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set
	t.outbound_in_75 = s.outbound_in_75
	, t.pickup_in_75 = s.pickup_in_75
	, t.inbound_in_75 = s.inbound_in_75
	, t.phonepay_in_75 = s.phonepay_in_75
	, t.paid_in_75 = s.paid_in_75
	, t.trans_in_75 = s.paid_in_75 
	, t.pif_in_90 = s.pif_in_90 
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
    , outbound_in_75
    , pickup_in_75
    , inbound_in_75
    , phonepay_in_75
    , paid_in_75
    , trans_in_75 
    , pif_in_90 
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
    , outbound_in_75
    , pickup_in_75
    , inbound_in_75
    , phonepay_in_75
    , paid_in_75
    , trans_in_75 
    , pif_in_90 
)
; 

-- graduate applied set accounts that have been predicted on and called already 
delete 
from pif90_source t
using staging.&client.vw_features s
where 
	s.account_id = t.account_id 
	and s.pif_in_90 is null 
	and s.atb_bucket = 75
	and s.called = 1 
; 

-- update existing applied set accounts that have either aged or pif'd into training set without having been called 
update production.rwjb.pif90_source t
set t.pif_in_90 = s.pif_in_90
from (
    select 
        account_id
        , pif_in_90 
    from staging.rwjb.vw_features 
    where pif_in_90 is not null 
)  s 
where t.pif_in_90 is null 
and s.account_id = t.account_id 
; 