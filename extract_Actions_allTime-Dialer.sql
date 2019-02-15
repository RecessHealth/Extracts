-- Project Theta extract from from vw_dialerstatsnew
-- All-time dialer history 
-- Production data source for guarantor action timeline

select
	CUBSID as account_id,
	dateadd(ss,cast(lctime as int),lastcalldate) as calltime, 
	telephone,
	termcode as strata_termcd,
	campaignid as CIC_termcd
from vw_dialerstatsnew;

 