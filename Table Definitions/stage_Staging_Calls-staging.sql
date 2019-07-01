CREATE OR REPLACE TABLE callsoutbound_staging (
    "filename" string
    , "account_id" string
    , "client_id" string
    , "agent_id" string
    , "campaign_id" string
    , "termcode" string
    , "calldate" string
    , "outbound" string
    , "pickup" string
    , "phonepay" string
)
COPY GRANTS 
;

CREATE OR REPLACE TABLE callsinbound_staging (
	"account_id" string not null 
	, "calldate" string 
)
COPY GRANTS
; 

CREATE OR REPLACE TABLE calls ( 
    account_id int
  , client_id string
  , agent_id string
  , campaign_id string
  , termcode string
  , outbound tinyint
  , pickup tinyint
  , inbound tinyint 
  , phonepay tinyint
  , calldate date  
)
COPY GRANTS
; 
