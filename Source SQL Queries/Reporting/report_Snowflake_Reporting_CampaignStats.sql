insert into reporting.&client.dailies (
    callDate
  , desk_id
  , atb_bucket
  , cohort 
  , bai_manned
  , sp_blast
  , bai60_blast 
  , likelypif
  , realloc_bai_blast
  , realloc_sp_manned
  , realloc_bai60_manned 
)
Select 
    current_date()
    , a.desk_id
    , a.atb_bucket
    , assigned_date 
    , count(ma.account_id)
    , sum(case when bl.campaign = 'BRS' then 1 else 0 end) 
    , sum(case when bl.campaign = 'BR6' then 1 else 0 end) 
    , sum(likelyPIF)
    , sum(case when suggested = 'BR6' then 1 else 0 end) 
    , sum(case when suggested = 'BRB' and a.campaign = 'BRS' then 1 else 0 end) 
    , sum(case when suggested = 'BRB' and a.campaign = 'BR6' then 1 else 0 end)
from production.&client.vw_allocations a 
full outer join production.rwjb.vw_manned ma 
    on a.account_id = ma.account_id 
full outer join production.&client.vw_blast bl
    on a.account_id = bl.account_id 
inner join staging.&client.demographics d 
    on d.account_id = a.account_id 
group by 1, a.desk_id, a.atb_bucket, assigned_date 
; 
