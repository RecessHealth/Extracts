-- Project Theta extract from tbl_DialerCode
-- Reference Join to describe model feature (i.e., call disposition)
-- static reference: translate dialer system, custom codes (i.e., CSR manual input) to describe call outcomes 

select 
	dialercode
	,[description]
	,codetype
from tbl_DialerCode;
