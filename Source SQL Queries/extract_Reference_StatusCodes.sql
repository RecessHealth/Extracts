-- Project Theta extract from tbl_StatusCodeDescription
-- Reference join to describe model features (i.e., Demographic status code)
-- static reference mapping

select
	statuscode, 
	statuscodedescription
from tbl_StatusCodeDescription;