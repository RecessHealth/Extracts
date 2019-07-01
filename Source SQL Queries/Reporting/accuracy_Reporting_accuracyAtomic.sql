merge into reporting.&client.accuracyAtomic t 
using (
  select
    account_id
    , Day18
    , Day30
    , Day45
    , Day60
    , Day75
    , Day90 
    , Day105
  from reporting.&client.scores  
) s 
    on s.account_id = t.account_id 
when matched then 
update set 
    t.pif30_predicted = case 
        when s.Day18 is null then null 
        when s.Day18 >= (select threshold from production.&client.thresholds where model = 'pif30') then 1 
        else 0 end 
    , t.pif45_predicted = case 
        when s.Day30 is null then null
        when s.Day30 >= (select threshold from production.&client.thresholds where model = 'pif45') then 1 
        else 0 end 
    , t.pif60_predicted = case 
        when s.Day45 is null then null 
        when s.Day45 >= (select threshold from production.&client.thresholds where model = 'pif60') then 1 
        else 0 end 
     , t.pif75_predicted = case 
        when s.Day60 is null then null 
        when s.Day60 >= (select threshold from production.&client.thresholds where model = 'pif75') then 1 
        else 0 end 
     , t.pif90_predicted = case 
        when s.Day75 is null then null 
        when s.Day75 >= (select threshold from production.&client.thresholds where model = 'pif90') then 1 
        else null end
     , t.pif105_predicted = case 
        when s.Day90 is null then null 
        when s.Day90 >= (select threshold from production.&client.thresholds where model = 'pif105') then 1 
        else null end  
     , t.pif120_predicted = case 
        when s.Day105 is null then null 
        when s.Day105 >= (select threshold from production.&client.thresholds where model = 'pif120') then 1 
        else null end 
when not matched then 
insert (
    account_id
  , pif30_predicted
  , pif45_predicted
  , pif60_predicted
  , pif75_predicted
  , pif90_predicted
  , pif105_predicted
  , pif120_predicted
)
values (
    s.account_id  
    , case 
        when s.Day18 is null then null 
        when s.Day18 >= (select threshold from production.&client.thresholds where model = 'pif30') then 1 
        else 0 end 
    , case 
        when s.Day30 is null then null
        when s.Day30 >= (select threshold from production.&client.thresholds where model = 'pif45') then 1 
        else 0 end 
    , case 
        when s.Day45 is null then null 
        when s.Day45 >= (select threshold from production.&client.thresholds where model = 'pif60') then 1 
        else 0 end 
     , case 
        when s.Day60 is null then null 
        when s.Day60 >= (select threshold from production.&client.thresholds where model = 'pif75') then 1 
        else 0 end 
     , case 
        when s.Day75 is null then null 
        when s.Day75 >= (select threshold from production.&client.thresholds where model = 'pif90') then 1 
        else null end
     , case 
        when s.Day90 is null then null 
        when s.Day90 >= (select threshold from production.&client.thresholds where model = 'pif105') then 1 
        else null end 
     , case 
        when s.Day105 is null then null 
        when s.Day105 >= (select threshold from production.&client.thresholds where model = 'pif120') then 1 
        else null end 
)
; 


update reporting.&client.accuracyAtomic t
set 
    t.pif30_actual = case 
        when s.pif_in_30 is not null then s.pif_in_30 
        else null end
    , t.pif45_actual = case 
        when s.pif_in_45 is not null then s.pif_in_45
        else null end
     , t.pif60_actual = case 
        when s.pif_in_60 is not null then s.pif_in_60 
        else null end 
     , t.pif75_actual = case 
        when s.pif_in_75 is not null then s.pif_in_75
        else null end 
     , t.pif90_actual = case 
        when s.pif_in_90 is not null then s.pif_in_90 
        else null end 
     , t.pif105_actual = case 
        when pif_in_105 is not null then s.pif_in_105 
        else null end 
     , t.pif120_actual = case 
        when pif_in_120 is not null then s.pif_in_120 
        else null end 
from staging.&client.vw_features s 
where s.account_id = t.account_id 
; 

update reporting.&client.accuracyAtomic 
set 
    pif30_accuracy = case 
        when pif30_actual is null then null 
        when pif30_predicted = pif30_actual then 1 
        else 0 end 
    , pif45_accuracy = case 
        when pif45_actual is null then null 
        when pif45_predicted = pif45_actual then 1 
        else 0 end 
     , pif60_accuracy = case 
        when pif60_actual is null then null 
        when pif60_predicted = pif60_actual then 1 
        else 0 end 
     , pif75_accuracy = case 
        when pif75_actual is null then null 
        when pif75_predicted = pif75_actual then 1 
        else 0 end 
     , pif90_accuracy = case 
        when pif90_actual is null then null 
        when pif90_predicted = pif90_actual then 1 
        else 0 end 
      , pif105_accuracy = case 
        when pif105_actual is null then null 
        when pif105_predicted = pif105_actual then 1 
        else 0 end 
      , pif120_accuracy = case 
        when pif120_actual is null then null
        when pif120_predicted = pif120_actual then 1 
        else 0 end 
; 