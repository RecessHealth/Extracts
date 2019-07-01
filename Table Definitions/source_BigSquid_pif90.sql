USE DATABASE bigsquid;

CREATE OR REPLACE TABLE pif90_source (
    account_id int
    , client_id varchar(20)
    , patient_age int
    , density_estimate float
    , financial_class varchar(127)
    , patient_type varchar(127)
    , med_service varchar(127)
    , assigned_year varchar(4)
    , assigned_month int
    , assigned_week int
    , initial_balance int
    , outbound_in_75 int
    , pickup_in_75 int
    , inbound_in_75 int
    , phonepay_in_75 int
    , paid_in_75 number(13,2)
    , trans_in_75 int
    , pif_in_90 boolean 
); 