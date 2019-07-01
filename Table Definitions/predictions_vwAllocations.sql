create or replace view production.&client.vw_Allocations (
	account_id
    , desk_id 
	, prediction
	, atb_bucket 
	, initial_balance 
	, priority 
	, reallocate 
) 
copy grants 
as 
SELECT 
	p.account_id 
    , desk_id 
	, prediction 
	, p.atb_bucket
    , p.initial_balance 
	, row_number() over (order by prediction desc, p.atb_bucket asc, p.initial_balance desc)
	, case when prediction >= threshold then 1 else 0 end
from production.&client.vw_Predictions as p 
inner join production.&client.thresholds as m 
	on m.model = p.model 
inner join staging.&client.demographics d 
    on d.account_id = p.account_id 
; 