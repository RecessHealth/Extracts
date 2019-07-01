merge into pif30_source t
using (
-- gather applied set 
	select * from staging.&client.vw_features where 
		pif_in_30 is null 
		and (
--			called=0 and 
			atb_bucket = 18
		)
) s 
	on t.account_id = s.account_id 
when matched then 
update set 
	t.outbound_in_18 = s.outbound_in_18
	, t.pickup_in_18 = s.pickup_in_18
	, t.inbound_in_18 = s.inbound_in_18
	, t.phonepay_in_18 = s.phonepay_in_18
	, t.paid_in_18 = s.paid_in_18
	, t.trans_in_18 = s.paid_in_18 
	, t.pif_in_30 = s.pif_in_30 
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
    , outbound_in_18
    , pickup_in_18
    , inbound_in_18
    , phonepay_in_18
    , paid_in_18
    , trans_in_18 
    , pif_in_30 
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
    , outbound_in_18
    , pickup_in_18
    , inbound_in_18
    , phonepay_in_18
    , paid_in_18
    , trans_in_18 
    , pif_in_30 
)
; 

-- graduate accounts that have been called since model prediction. --> keep called accounts, currently no model to accomodate pif in 30 with information after Day 18 
-- -delete 
-- -from pif30_source t
-- -using staging.&client.vw_features s
-- -where 
-- -	s.account_id = t.account_id 
-- -	and s.pif_in_30 is null 
-- -	and s.atb_bucket = 18
-- -	and s.called = 1 
-- -; 

-- update pif status of applied data aged into training data before called 
update production.rwjb.pif30_source t
set t.pif_in_30 = s.pif_in_30
from (
    select 
        account_id
        , pif_in_30 
    from staging.rwjb.vw_features 
    where pif_in_30 is not null 
)  s 
where t.pif_in_30 is null 
and s.account_id = t.account_id 