-- Project Theta extract from Stratadial.dbo.termcd, cf. tbl_DialerCode 
-- reference join to describe model features (i.e., action codes) 
-- static reference: translate Strata system-automated codes to describe call outcomes 

select 
	termcd as [action_code]
	,termdesc as [description]
	,systemtc as [system_generated] 
from termcd