insert into calls ( 
	account_id 
	, client_id 
	, agent_id
	, campaign_id 
	, termcode
	, outbound
	, pickup
	, inbound
	, phonepay
	, calldate 
)
	select 
		account_id
		, client_id
		, agent_id
		, campaign_id
		, termcode
		, try_to_number(outbound) 
		, try_to_number(pickup)
		, null 
		, try_to_number(phonepay)
		, try_to_timestamp_ntz(callDate)  
	from callsoutbound_staging  
	union 
	select 
		account_id
		, null
		, null
		, null
		, 'IB'
		, null
		, null
		, 1
		, null
		, try_to_timestamp_ntz(callDate) 
	from callsinbound_staging
;