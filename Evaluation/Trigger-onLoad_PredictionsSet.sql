select 
	account_id
	, convert(int, days_in_inventory) as days_in_inventory
	, convert(datetime, date_modified) as date_modified
	, case 
		when isnumeric(ppi)=1 then convert(decimal(5,2), ppi)
		else null 
		end as ppi 
into Incumbent
from Incumbent_ppi
; 
