-- 

select 
	account_id
	, account_phone 
	, case 
		when cancelled_date is null then abs(datediff(day, getdate(), assigned_date)) -- account for active accounts
		else abs(datediff(day, cancelled_date, assigned_date)) 
	end as [Days in agency]
into #TempBarnAccounts   -- consistently referenced large set 
from tbl_Report_Data a
where client_id like 'BH%'

select 
	CUBSID, 
	telephone, 
	[FileName]
into #TempBarnCalls    -- consistently referenced large set 
from vw_dialerstatsnew
where client_id like 'BH%'

; with b as (
	select 
		account_id 
		, max([Days in agency]) as [Days in agency]			-- single statistic per rollup 
		, count([FileName]) as calls_per_acct				-- Filename = unique record 
	from #TempBarnAccounts  
	inner join #TempBarnCalls								-- associate account_id to call stats (phone level) 
		on account_id = cubsid
	group by account_id										-- roll-up for each account 
)
select 
	telephone 
	, count([FileName]) as total_calls_phone				-- total calls made to telephone across all accounts all time 
	, count(distinct #TempBarnAccounts.account_id) as accounts_per_phone -- how many account_ids attributed to telephone 
	, max(b.calls_per_acct) as max_calls_acct				-- highest number of calls from all accounts attributed to telephone
	, max(b.[Days in agency]) as longest_account			-- longest stretch from all accounts attributed to telephone
from #TempBarnAccounts
inner join #TempBarnCalls
	on account_id = CUBSID
inner join b 
	on #TempBarnAccounts.account_id = b.account_id
group by telephone											-- rollup by guarantor (telephone as proxy) 
order by max_calls_acct desc;								

drop table #TempBarnAccounts
drop table #TempBarnCalls
