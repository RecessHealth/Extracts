merge into pif120_source t
using (
-- gather new accounts into applied set 
	select * 
	from staging.&client.vw_features 
	where 
		pif_in_120 is null 
		and (
			(
--				called=0 and
				atb_bucket = 105
			) 
			or (
				called=1 
				and atb_bucket=90
			)
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set 
	t.outbound_in_105 = s.outbound_in_105
	, t.pickup_in_105 = s.pickup_in_105
	, t.inbound_in_105 = s.inbound_in_105
	, t.phonepay_in_105 = s.phonepay_in_105
	, t.paid_in_105 = s.paid_in_105
	, t.trans_in_105 = s.paid_in_105 
	, t.pif_in_120 = s.pif_in_120 
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
    , outbound_in_105
    , pickup_in_105
    , inbound_in_105
    , phonepay_in_105
    , paid_in_105
    , trans_in_105 
    , pif_in_120 
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
    , outbound_in_105
    , pickup_in_105
    , inbound_in_105
    , phonepay_in_105
    , paid_in_105
    , trans_in_105 
    , pif_in_120 
)
; 

-- update accounts in applied set that have aged or pif'd into training set without having been called
update production.rwjb.pif120_source t
set t.pif_in_120 = s.pif_in_120
from (
    select 
        account_id
        , pif_in_120 
    from staging.rwjb.vw_features 
    where pif_in_120 is not null 
)  s 
where t.pif_in_120 is null 
and s.account_id = t.account_id 
; 