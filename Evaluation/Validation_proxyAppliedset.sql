declare @new18 date = getdate()-12; 
-- declare @proxyrecords int = 20000 - (select count(distinct account_id) from staging..Demographics where getdate()-1 < Day_30 and getdate()-1 >= Day_18); 


; with y as ( 
	select 
		f.account_id 
		, f.client_id 
		, f.patient_age
		, city_name
		, density_estimate
		, f.financial_class
		, f.med_service
		, f.assigned_year
		, f.assigned_month
		, f.assigned_week
		, f.initial_balance
		, dialer_in_18
		, outbound_in_18
		, pickup_in_18
		, inbound_in_18
		, phonepay_in_18
		, paid_in_18
		, trans_in_18
		, pif_in_30 
	from staging..Features f
	inner join staging..Demographics d 
		on f.account_id = d.account_id 
	where getdate() < Day_30 and getdate() >= Day_18 
),  
x as (
	select top 10000 --(@proxyrecords)
		f.account_id 
		, f.client_id 
		, f.patient_age 
		, city_name
		, density_estimate
		, f.financial_class
		, f.med_service
		, datepart(year,@new18) as assigned_year
		, datepart(month,@new18) as assigned_month
		, datepart(week,@new18) as assigned_week 
		, f.initial_balance
	    , f.dialer_in_18
		, f.outbound_in_18
		, f.pickup_in_18
		, f.inbound_in_18
	    , f.phonepay_in_18
	    , f.paid_in_18
		, f.trans_in_18
		, '' as pif_in_30
	from staging..Features f
	where f.pif_in_30 is not null  
	and f.account_id not in (select account_id from y)
	order by newid()
) 
select * from x 
union 
select 
	f.account_id
	, f.client_id
	, f.patient_age 
	, city_name 
	, density_estimate
	, f.financial_class
	, f.med_service 
	, f.assigned_year
	, f.assigned_month
	, f.assigned_week
	, f.initial_balance
    , f.dialer_in_18
	, f.outbound_in_18
	, f.pickup_in_18
	, f.inbound_in_18
    , f.phonepay_in_18
    , f.paid_in_18
	, f.trans_in_18
	, CASE 
		when getdate() <= [Day_30] AND abs(cast(paid_in_30 as decimal(13,2))) < abs(cast(f.initial_balance as decimal(13,2)))-9.99 then ''	-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
		else case 
            WHEN f.initial_balance = 0 THEN 'false'
            else 
                case when abs(cast(paid_in_30 as decimal(13,2))) >= abs(cast(f.initial_balance as decimal(13,2)))-9.99 then 'true' else 'false' end 
            end 
		end as pif_in_30
from staging..Features f 
inner join staging..Demographics d
	on f.account_id = d.account_id 
where not exists
(select account_id from x where x.account_id = f.account_id) 
and getdate() >= Day_30 
order by pif_in_30 asc; 


