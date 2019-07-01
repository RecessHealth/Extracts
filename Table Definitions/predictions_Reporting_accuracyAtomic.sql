CREATE OR REPLACE table reporting.rwjb.accuracyAtomic ( 
    account_id string
    , pif30_predicted boolean 
    , pif30_actual boolean 
	,pif30_accuracy boolean
    , pif45_predicted boolean 
    , pif45_actual boolean 
	, pif45_accuracy boolean 
    , pif60_predicted boolean 
    , pif60_actual boolean 
	, pif60_accuracy boolean
    , pif75_predicted boolean
    , pif75_actual boolean 
	, pif75_accuracy boolean
    , pif90_predicted boolean
    , pif90_actual boolean
	, pif90_accuracy boolean
    , pif105_predicted boolean
    , pif105_actual boolean
	, pif105_accuracy boolean
    , pif120_predicted boolean
    , pif120_actual boolean
	, pif120_accuracy boolean 
) 
copy grants
; 