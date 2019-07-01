CREATE OR REPLACE TABLE transactions_staging (
    "transaction_id" string
    , "account_id" string
    , "client_id" string
	, "transaction_amount" string
    , "transaction_status" string
    , "transaction_date" string
) 
COPY GRANTS
;

CREATE OR REPLACE TABLE transactions ( 
    account_id int
  , transaction_id string 
  , client_id string 
  , transaction_amount number(13,2)
  , transaction_status int 
  , transaction_date date 
)
COPY GRANTS
; 
