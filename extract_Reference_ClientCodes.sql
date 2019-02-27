-- Project Theta extract from vw_Clients
-- Used for Staging join for client-partitioned datasets  
-- static reference dataset 
-- built from tbl_ClientID, tbl__ClientCodeDescription

select 
	client_id 
	, client_code 
	, client_description 
	, project as [Dialer project] 
from vw_Clients
where 
	client_id like 'BH%' and
	client_id not in (
		'BHRI100'
		, 'BHEC100'
		, 'BHHS100'
		, 'BHST100'
		,'BHAK100'
		, 'BHLR100'
		, 'BHNL100'
	)