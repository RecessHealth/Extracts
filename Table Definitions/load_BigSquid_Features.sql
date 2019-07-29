CREATE OR REPLACE TABLE features (
    account_id int
	, client_id varchar(20)
	, patient_age int
	, density_estimate float
	, financial_class varchar(127)
	, patient_type varchar(127)
	, med_service varchar(127)
	, assigned_year varchar(127)
	, assigned_month int 
	, assigned_week int 
	, initial_balance int 
	, outbound_in_18 int
	, pickup_in_18 int
	, inbound_in_18 int
    , phonepay_in_18 int 
    , paid_in_18 number(13,2)
	, trans_in_18 int 
	, outbound_in_30 int 
	, pickup_in_30 int 
	, inbound_in_30 int 
    , phonepay_in_30 int 
	, paid_in_30 number(13,2)
	, trans_in_30 int 
	, outbound_in_45 int
	, pickup_in_45 int 
	, inbound_in_45 int
    , phonepay_in_45 int
	, paid_in_45 number(13,2)
	, trans_in_45 int
	, outbound_in_60 int
	, pickup_in_60 int
	, inbound_in_60 int 
    , phonepay_in_60 int
	, paid_in_60 number(13,2)
	, trans_in_60 int
	, outbound_in_75 int
	, pickup_in_75 int
	, inbound_in_75 int
    , phonepay_in_75 int
	, paid_in_75 number(13,2)
	, trans_in_75 int 
	, outbound_in_90 int
	, pickup_in_90 int
	, inbound_in_90 int
    , phonepay_in_90 int
	, paid_in_90 number(13,2)
	, trans_in_90 int
	, outbound_in_105 int
	, pickup_in_105 int
	, inbound_in_105 int
    , phonepay_in_105 int
	, paid_in_105 number(13,2)
	, trans_in_105 int
	, outbound_in_120 int
	, pickup_in_120 int
	, inbound_in_120 int
    , phonepay_in_120 int
	, paid_in_120 number (13,2)
	, trans_in_120 int
	, pif_in_18 boolean 
	, pif_in_30 boolean 
	, pif_in_45 boolean 
	, pif_in_60 boolean 
	, pif_in_75 boolean 
	, pif_in_90 boolean 
	, pif_in_105 boolean 
	, pif_in_120 boolean 
	, ATB_bucket int 
    , called boolean 
  )
  COPY GRANTS; 