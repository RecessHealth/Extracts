select top 1000
    CUBSID as account_id
    , dateadd(ss,cast(lctime as int), lastcalldate) as calltime
    , telephone
    , termcode as strata_termcd
    , campaignid as CIC_termcd
    , agentid as mapping_name
  from vw_dialerstatsnew 
  where project = 'Barnabas SPEO'; 
