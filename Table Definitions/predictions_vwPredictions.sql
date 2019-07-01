create or replace view production.&client.vw_Predictions (
    account_id
  , prediction
  , initial_balance 
  , atb_bucket
  , model 
)
as
  select 
	account_id
	, prediction
	, initial_balance
	, atb_bucket
	, model 
  from ( 
	select 
		"account_id"
		, "pif_in_120_predicted_1.0" as prediction 
		, 'pif120' as model 
	from pif120_source_predicted 
	where "pif_in_120" is null 
	UNION 
	select 
		"account_id" 
		, "pif_in_105_predicted_1.0" as prediction 
		, 'pif105' as model 
	from pif105_source_predicted 
	where "pif_in_105" is null 
	UNION 
	select 
		"account_id"
		, "pif_in_90_predicted_1.0" as prediction 
		, 'pif90' as model 
	from pif90_source_predicted 
	where "pif_in_90" is null 
	UNION 
	select 
		"account_id" 
		, "pif_in_75_predicted_1.0" as prediction 
		, 'pif75' as model 
	from pif75_source_predicted
	where "pif_in_75" is null 
	UNION 
	select 
		"account_id"
		, "pif_in_60_predicted_1.0" as prediction 
		, 'pif60' as model 
	from pif60_source_predicted
	where "pif_in_60" is null 
	UNION 
	select 
		"account_id"
		, "pif_in_45_predicted_1.0" as prediction 
		, 'pif45' as model 
	from pif45_source_predicted
	where "pif_in_45" is null 
	UNION 
	select 
		"account_id"
		, "pif_in_30_predicted_1.0" as prediction 
		, 'pif30' as model 
	from pif30_source_predicted  
	where "pif_in_30" is null 
	) as m
	inner join staging.&client.vw_features as f
		on f.account_id = m."account_id" 
; 


