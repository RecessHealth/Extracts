declare @incumbent_threshold decimal(7,2) = 6.00
declare @ValidationSample int = (select count(*) from Predicted)
declare @OperationalSample int = (select count(*) from Incumbent)

select 
	Predicted.account_id
	, pif_in_120 as [target]  
	, pif_in_120_predicted as [model_prediction]
	, convert(decimal(4,2),pif_in_120_predicted_true)as [model_confidence] 
	, case  
		when ppi <= @incumbent_threshold then 'FALSE'
		when ppi > @incumbent_threshold then 'TRUE'
		else null 
		end as [incumbent_prediction]
	, convert(decimal(5,2),ppi) as [incumbent_confidence]
into #ValidationSet
from Predicted
inner join Incumbent
	on Predicted.account_id = Incumbent.account_id 
; 

select 
	(sum(case when model_prediction = [target] then 1 else 0 end)*100.00)/@ValidationSample as model_points
	, (sum(case when incumbent_prediction = [target] then 1 else 0 end)*100.00)/@ValidationSample  as incumbent_points 
from #ValidationSet

--drop table #ValidationSet