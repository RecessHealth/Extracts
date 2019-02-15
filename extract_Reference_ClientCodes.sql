-- Project Theta extract from vw_Clients
-- Used for Staging join for client-partitioned datasets  
-- static reference dataset 
-- built from tbl_ClientID, tbl__ClientCodeDescription

select 
	client_id, 
	client_code, 
	client_description 
from vw_Clients;