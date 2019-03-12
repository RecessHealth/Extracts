BULK INSERT staging.dbo.Calls_staged
    from 'C:\Users\jadrummond\Documents\deliverables\recess\extract\Barnabas\BigSquid\Calls.csv'
    with (
		formatfile = 'C:\Users\jadrummond\Documents\deliverables\recess\extract\Barnabas\BigSquid\Calls_format2.txt'
		, firstrow = 2
	);

insert into staging.dbo.Calls (
	account_id 
	, dialer_in_30  
	, outbound_in_30 
	, pickup_in_30 
	, inbound_in_30 
	, Phonepay_in_30 
	, dialer_in_60 
	, outbound_in_60 
	, pickup_in_60 
	, inbound_in_60 
	, Phonepay_in_60 
	, dialer_in_90 
	, outbound_in_90 
	, pickup_in_90 
	, inbound_in_90 
	, Phonepay_in_90 
	, dialer_in_120 
	, outbound_in_120 
	, pickup_in_120 
	, inbound_in_120 
	, Phonepay_in_120 
	, total_dialer_placed 
)
select 
	account_id 
	, dialer_in_30  
	, outbound_in_30 
	, pickup_in_30 
	, inbound_in_30 
	, Phonepay_in_30 
	, dialer_in_60 
	, outbound_in_60 
	, pickup_in_60 
	, inbound_in_60 
	, Phonepay_in_60 
	, dialer_in_90 
	, outbound_in_90 
	, pickup_in_90 
	, inbound_in_90 
	, Phonepay_in_90 
	, dialer_in_120 
	, outbound_in_120 
	, pickup_in_120 
	, inbound_in_120 
	, Phonepay_in_120 
	, total_dialer_placed 
from Calls_staged 