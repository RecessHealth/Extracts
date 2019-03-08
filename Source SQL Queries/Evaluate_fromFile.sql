-- grab all accounts from Predicted dataset 
; with y as (
	select 
		account_id
		, assigned_date
		, status_change_date
		, ppi
	from openrowset (
		bulk 'C:\Users\jadrummond\Documents\deliverables\Recess\solution\Kraken\validation\Accounts_Predicted.csv'
		, formatfile='C:\Users\jadrummond\Documents\deliverables\Recess\solution\Kraken\validation\Accounts_Predicted.fmt'
	) as csv  
), 
-- grab Barnabas accounts that have PIF'd 
x as (							
 	select 
 		account_id
 	from Predicted
 	where status_code in ('PIF')			-- choose which status accounts you want 
 	and client_id like 'BH%'
 )
select   
	-- account_id 
	-- ppi 
	avg(abs(datediff(day,assigned_date,status_change_date))) as avg_days_to_PIF		-- find days from assignment to PIF 
	from x
inner join y 
	on x.account_id = y.account_id
--group by ppi 
--having ppi < 6.00
where cast(ppi as decimal(4,2)) < 6.00
order by ppi asc;


