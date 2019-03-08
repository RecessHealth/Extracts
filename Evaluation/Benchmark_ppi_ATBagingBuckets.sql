-- Question: How does the client's inventory score on our ppi model? 

-- temp table of all <client> accounts with associated ppi score 
select
 	account_id 
	, cast(ppi as decimal(5,2)) as ppi 
into #TempPIF
	from tbl_Report_Data
	where client_id like 'BH%' --choose client 
	and status_code = 'PIF' -- filter by status codes
	and ppi like '[0-9]%' --limit to valid ppi scores

-- total of all <client> accounts with valid ppi scores
declare @sumppi int = (select count(*) from #TempPIF); 

-- summary table of client's inventory 
-- raw numbers and % breakdown 
select 
	sum(case when ppi <= 2.45 then 1 else 0 end) as [0-2.45]
	, sum(case when ppi between 2.50 and 4.45 then 1 else 0 end) as [2.5 - 4.45]   
	, sum(case when ppi between 4.50 and 5.95 then 1 else 0 end) as [4.5 - 5.95]
	, sum(case when ppi between 6.00 and 6.99 then 1 else 0 end) as [6.0 - 6.99]
	, sum(case when ppi >= 7.00 then 1 else 0 end) as [7.0 - 10.0]
	, (sum(case when ppi <= 2.45 then 1 else 0 end)*100.00)/@sumppi as [0-2.45(%)]
	, (sum(case when ppi between 2.50 and 4.45 then 1 else 0 end)*100.00)/@sumppi as [2.5 - 4.45(%)]   
	, (sum(case when ppi between 4.50 and 5.95 then 1 else 0 end)*100.00)/@sumppi as [4.5 - 5.95(%)]
	, (sum(case when ppi between 6.00 and 6.99 then 1 else 0 end)*100.00)/@sumppi as [6.0 - 6.99(%)]
	, (sum(case when ppi >= 7.00 then 1 else 0 end)*100.00)/@sumppi as [7.0 - 10.0(%)]
into #TempPPI
from #TempPIF;

-- Answer 
select * from #TempPPI; 

-- clear temp table 
drop table #TempPPI