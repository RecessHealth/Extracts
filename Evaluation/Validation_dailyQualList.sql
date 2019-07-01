select
	account_id
	, phonenumber 
	, client_id 
	, campaign 
	, cast(qualdate as date) as qualdate 
from tbl_DialerQualificationHistory
where cast(qualdate as date) = '2019-04-19' 
and campaign in ('BRS','BR6','BRB')

