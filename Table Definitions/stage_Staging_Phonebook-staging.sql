CREATE OR REPLACE TABLE phonebook_staging (
	"account_id" string
	, account_phone string 
)
COPY GRANTS
; 

CREATE OR REPLACE TABLE phonebook ( 
	account_id int 
	account_phone string 
)
COPY GRANTS
; 