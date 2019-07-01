if object_id('tempdb.dbo.#validationset') is not null
	drop table #validationset
; 

-------------------------------------------
-- load Big Squid Kraken prediction.csv 
-------------------------------------------
select 
	d18.account_id
	, feat.initial_balance  
	, paid_in_30 
	, predicted 
	, d18.actual 
	, cast(case 
		when try_convert(float, predicted) >= .99 then 99 
		when try_convert(float, predicted) >= .95 then 95
		when try_convert(float, predicted) >= .9 then 90 
		when try_convert(float, predicted) >= .85 then 85
		when try_convert(float, predicted) >= .8  then 80
		when try_convert(float, predicted) >= .75 then 75
		when try_convert(float, predicted) >= .7 then 70
		when try_convert(float, predicted) >= .65 then 65
		when try_convert(float, predicted) >= .6 then 60
		when try_convert(float, predicted) >= .55 then 55
		when try_convert(float, predicted) >= .5 then 50
		when try_convert(float, predicted) >= .45 then 45
		when try_convert(float, predicted) >= .4 then 40
		when try_convert(float, predicted) >= .35 then 35
		when try_convert(float, predicted) >= .3 then 30
		when try_convert(float, predicted) >= .25 then 25
		when try_convert(float, predicted) >= .2 then 20
		when try_convert(float, predicted) >= .15 then 15
		when try_convert(float, predicted) >= .1 then 10
		when try_convert(float, predicted) >= .05 then 05
		else 0 
	end as int) as class 
	, d18.initial_balance * try_convert(float, predicted) as expected 
into #validationset 
from BigSquid..Day_18 d18 
inner join staging..Features_staged feat
	on d18.account_id = feat.account_id 
; 



-------------------------------------------
-- Precision Histogram 
-------------------------------------------
declare @actual int = (select count(account_id) from #validationset where actual = 'true');			-- total number of accounts that pif
select @actual 

select 
	[sample].class
	, (correct*100.00)/@actual as marginal_gain
	, (correct*100.00)/class_population as [precision] 
from (	
	select 
		class 
		, count(actual) as [correct]					-- how many accounts' actual outcomes mirror predicted @ predicted class 
--		, sum(initial_balance) as [pif_AR] 
--		, sum(expected) as [expected]
	from #validationset
	group by class, actual  
	having actual = 'true' 
) [sample]
inner join (
	select 
		class
		, count(actual) as [class_population]			-- how many accounts with known outcome did model score @ predicted class 
--		, sum(initial_balance) as [total_AR]
--		, sum(expected) as [goal]
	from #validationset
	group by class  
) [class]
	on class.class = [sample].class
	order by class desc;   

-- add cursor arithmetic ==> cumulative gains 





--------------------------------------------------
-- Call List metrics 
--------------------------------------------------
-- ; with x as (
-- 	select top 5000
-- 		expected 
-- 	from #validationset
-- 	order by expected desc
-- ) select
-- 	sum(expected) 
-- from x; 

-- cumulative gains chart 
-- ; declare @actual2 int = (select top 5000 sum(actual) from #validationset where actual = 'true' order by expected desc)  

-- ; with x as (
-- 	select top 5000 
-- 	sum(actual)/ over(partition by order by expected desc)			-- Y-axis: % = (gains = running total of actual = 'true')/sum(actual='true') within sample (=top 5000) 
-- 	cume_dist() over(partition by order by expected desc)			-- X-axis: top x% of population (n=5000) 
-- 	from #validationset
-- )  
-- order by expected desc


