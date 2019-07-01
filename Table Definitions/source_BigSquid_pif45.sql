USE DATABASE bigsquid;

CREATE OR REPLACE TABLE pif45_source (
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
    , outbound_in_30 int
    , pickup_in_30 int
    , inbound_in_30 int
    , phonepay_in_30 int
    , paid_in_30 number(13,2)
    , trans_in_30 int
    , pif_in_45 boolean 
); 