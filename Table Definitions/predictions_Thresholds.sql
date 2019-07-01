create or replace table production.rwjb.thresholds (
    model varchar
  , threshold float
)
copy grants
; 


insert into production.rwjb.thresholds
values 
    ('pif30',0.7)
    , ('pif45',0.6)
    , ('pif60',0.6)
    , ('pif75',0.9)
    , ('pif90',0.8)
    , ('pif105',0.8)
    , ('pi120',0.8) 
; 