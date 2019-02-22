-- payments over account lifecycle 
-- NOT real-time aging report! 

create table #TempATB (
	account_id varchar(8000)
	, ppi varchar(8000)
	, assigned_date datetime
	, [1st_pmt] datetime
	, [pmts -30] decimal(13,2)
	, [pmts 31-60] decimal(13,2)
	, [pmts 61-90] decimal(13,2)
	, [pmts 91-120] decimal(13,2)
	, [pmts 120+] decimal(13,2)
	, cancelled_amt decimal(13,2)
);

select * from #TempATB

-- assigned date = day 0
declare @day0 datetime; set @day0 = (select assigned_date from tbl_Report_Data);

-- define ATB buckets: 30 day cutoff date after assigned date
declare @day30 datetime; set @day30 = dateadd(day,30,@day0);

-- define ATB buckets: 60 day cutoff date after assigned date
declare @day60 datetime; set @day60 = dateadd(day,60,@day0); 

-- define ATB buckets: 90 day cutoff date after assigned date
declare @day90 datetime; set @day90 = dateadd(day,90,@day0);

-- define ATB buckets: 120 day cutoff date after assinged date 
declare @day120 datetime; set @day120 = dateadd(day,90,@day0);

--insert into #TempATB







