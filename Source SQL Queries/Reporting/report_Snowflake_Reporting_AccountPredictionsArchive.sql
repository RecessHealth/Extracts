merge into scores t
using production.&client.vw_predictions_historical s
    on t.account_id = s.account_id 
when matched then 
update set 
  t.Day18 = case when (s.atb_bucket = 18 and t.Day18 is null) then s.prediction else t.Day18 end 
  , t.Day30 = case when (s.atb_bucket = 30 and t.Day30 is null) then s.prediction else t.Day30 end 
  , t.Day45 = case when (s.atb_bucket = 45 and t.Day45 is null) then s.prediction else t.Day45 end 
  , t.Day60 = case when (s.atb_bucket = 60 and t.Day60 is null) then s.prediction else t.Day60 end
  , t.Day75 = case when (s.atb_bucket = 75 and t.Day75 is null) then s.prediction else t.Day75 end
  , t.Day90 = case when (s.atb_bucket = 90 and t.Day90 is null) then s.prediction else t.Day90 end
  , t.Day105 = case when (s.atb_bucket = 105 and t.Day105 is null) then s.prediction else t.Day105 end 
when not matched then 
insert (
   account_id 
  , Day18
  , Day30
  , Day45
  , Day60
  , Day75
  , Day90
  , Day105
)
values (
  s.account_id
  , case when s.atb_bucket = 18 then s.prediction else null end 
  , case when s.atb_bucket = 30 then s.prediction else null end 
  , case when s.atb_bucket = 45 then s.prediction else null end
  , case when s.atb_bucket = 60 then s.prediction else null end 
  , case when s.atb_bucket = 75 then s.prediction else null end 
  , case when s.atb_bucket = 90 then s.prediction else null end 
  , case when s.atb_bucket = 105 then s.prediction else null end 
)
;
