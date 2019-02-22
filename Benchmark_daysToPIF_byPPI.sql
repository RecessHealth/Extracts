-- create temp table with <client> PIF accounts with a valid ppi score 
select
 	account_id 
	, abs(datediff(day, assigned_date, status_change_date)) as PIFdays
	, cast(ppi as decimal(5,2)) as ppi 
into #TempPIF
	from tbl_Report_Data
	where client_id like 'BH%' -- select client 
	and status_code = 'PIF' --status filter
	and ppi like '[0-9]%'; --valid ppi scores only 

-- set ppi filter 
declare @ppilimlow decimal(5,2) = 7.00;  --lower bound of desired ppi scores
declare @ppilimupp decimal(5,2) = 10.00;  -- upper bound of desired ppi scores

-- summary table of ATB aging for ppi filter (range between lower and upper bounds)  
select
sum(case when PIFDays <= 30 then 1 else 0 end) as [<30 days]
,sum(case when PIFDays between 31 and 60 then 1 else 0 end) as [31-60]
, sum(case when PIFDays between 61 and 90 then 1 else 0 end) as [61-90]
, sum(case when PIFDays between 91 and 120 then 1 else 0 end) as [91-120]
, sum(case when PIFDays > 120 then 1 else 0 end) as [> 120 days]
from #TempPIF
where ppi between @ppilimlow and @ppilimupp;


-- subtotal of how many accounts have desired ppi scores
declare @ppisubttl int = (select count(*) from #TempPIF where ppi between @ppilimlow and @ppilimupp);


-- Answer: 
-- summary table of <client> inventory ATB aging given <status> and <ppi> filter
select 
(sum(case when PIFDays <= 30 then 1 else 0 end)*100.00)/@ppisubttl as [0-days(%)]
,(sum(case when PIFDays between 31 and 60 then 1 else 0 end)*100.00)/@ppisubttl as [31-60(%)]
, (sum(case when PIFDays between 61 and 90 then 1 else 0 end)*100.00)/@ppisubttl as [61-90(%)]
, (sum(case when PIFDays between 91 and 120 then 1 else 0 end)*100.00)/@ppisubttl as [91-120(%)]
, (sum(case when PIFDays > 120 then 1 else 0 end)*100.00)/@ppisubttl as [>120 (%)]
from #TempPIF
where ppi between @ppilimlow and @ppilimupp;


-- clear temp table when done 
drop table #TempPIF; 


