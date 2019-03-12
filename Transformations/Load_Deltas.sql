update #Trial set content = 'test' 
where exists (
	select #Trial.content
	except 
	select content = 'test'+cast(id as varchar(10))
); 

select * from #Trial;

insert into #Trial (content)
select ('test4')
except 
select content from #Trial; 

select * from #Trial;

--------------------------------------------------
-- DELTAS 
--------------------------------------------------
-- append new records 
insert into <table> (
	<field> 
	, <field>
)
-- select new records from subquery 
select (
	<new record subquery>
)
-- which records in subquery to ignore because already exist in destination table 
except 
select 
	account_id from <table>
; 

-- changing existing records 
update <table> 
set 
	<field> = <expression>
	, <field> = <expression>
where exists (
	select 
		<table>.<field>
	except
	select 
		<field> = <expression>
)


