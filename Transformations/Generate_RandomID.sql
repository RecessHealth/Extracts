create table #Increment (
	id int identity(1,1) not null 
	, sortedValue varchar(8) 
)

declare @i int = 0;
while @i < 99 -- desired number of rows

begin 

insert #Increment default values 
	set @i = @i+1

end 

update #Increment 
	set sortedValue = (select rand(id)) -- output values are linear to seed :. order by will maintain order

select count(distinct(sortedValue))		-- sanity check that sorting value is unique 
from #Increment 

insert into tbl_randomID (GID)
	select id from #Increment order by 1

select * from #Increment order by 1
select * from tbl_randomID


exec sp_columns tbl_randomID