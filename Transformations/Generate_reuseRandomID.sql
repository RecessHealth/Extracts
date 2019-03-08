create trigger reuse_randomIDs
after insert on tbl_newIDs
for each row 
begin
	declare len int unsigned default '8'; 
    declare base int unsigned default '36'; 
    declare @used_old := select used from tbl_randomIDs where abs(datediff(now(),modified_date)) > '120' and used = '1';
    
	select @updateused := select count(*) from from tbl_newIDs where used = new.used); 
    
    if @updateused = power(base,len) then 
		set @used_old = '0';
end;

