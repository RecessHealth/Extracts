if object_id('tempdb.dbo.#TempPPI','U') is not null
	drop table #TempPPI;
else
	create table #TempPPI (
		account_id varchar(8)
		, [days to PIF] int
		, ppi varchar(4)
		, previous_status_code varchar(3) 
);

-- days to PIF for <client> on all accounts
select  
	account_id 
	, abs(datediff(day, assigned_date,status_change_date)) as 'days to PIF' -- calculate days elapsed between assigned_date and date when status_code changed to PIF 
	, ppi
	, previous_status_code  
into #TempPPI
from tbl_Report_Data
where client_id like 'BH%' -- <client> = Barnabas (all projects) 
and ppi like '[0-9]%' 
and status_code = 'PIF' 
order by [days to PIF] asc;


select top 1000 
	ppi
	, avg('days to PIF') as 'avgdays to PIF' over(-- calculate days elapsed between assigned_date and date when status_code changed to PIF 
		partition by ppi 
		order by ppi)
from #TempPPI
group by ppi, previous_status_code;

-- drop temp table when finished 
drop table #TempPPI; 