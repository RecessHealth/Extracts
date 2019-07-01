declare @avg_days_to_pif int = (
	select 
		avg(abs(datediff(day, assigned_date, status_change_date))) 
	from PPI_test a 
	inner join Predicted b 
		on a.account_id = b.account_id 
);

declare @avg int = (
		select top 1
		days_to_pif
	from ( 
		select
			abs(datediff(day, assigned_date, status_change_date)) as days_to_pif
			from Predicted a 
		inner join PPI_test b
			on a.account_id = b.account_id
		) b
	group by days_to_pif 
	order by avg(count(days_to_pif) desc
); 

declare @mode_to_pif int = ( 
	select top 1
		days_to_pif
	from ( 
		select
			abs(datediff(day, assigned_date, status_change_date)) as days_to_pif
			from Predicted a 
		inner join PPI_test b
			on a.account_id = b.account_id
		) b
	group by days_to_pif 
	order by count(days_to_pif) desc
); 

; with estimate as (
	select 
		count(a.account_id) as pif_accounts
		, sum(initial_balance) as collected_AR 
	from Predicted a
	inner join PPI_test b
		on a.account_id = b.account_id
	where status_change_date < dateadd(day,@avg_days_to_pif,assigned_date)
), potential as (
	select 
		count(account_id) as all_accounts
		, sum(initial_balance) as possible_AR 
	from Predicted 
) 
select 
	@avg_days_to_pif as avg_days_to_pif
	, @mode_to_pif as likely_length_of_time
	, (pif_accounts*100.00)/all_accounts as percent_accts_pif_before_avg
	, (collected_AR*100.00)/possible_AR as percent_dollars_collected_before_avg
from potential, estimate





	
