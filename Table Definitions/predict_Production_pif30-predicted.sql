USE DATABASE production ;

CREATE OR REPLACE TABLE pif30_predicted (
    account_id string 
    , client_id string
    , patient_age string
    , density_estimate string
    , financial_class string
    , patient_type string
    , med_service string
    , assigned_year string
    , assigned_month string
    , assigned_week string
    , initial_balance string
    , outbound_in_18 string
    , pickup_in_18 string
    , inbound_in_18 string
    , phonepay_in_18 string
    , paid_in_18 string
    , trans_in_18 string
    , pif_in_30 string 
	, prediction string 
); 