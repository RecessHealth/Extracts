merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif120_predicted where pif_in_120 is null) s
on  s.account_id = t.account_id 
when matched then 
update set 
	t.Day105 = try_to_double(s.prediction)
when not matched then 
insert (
    account_id
  , Day105
) 
values ( 
    s.account_id
	, try_to_double(s.prediction) 
)
; 

merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif105_predicted where pif_in_105 is null) s 
on s.account_id = t.account_id 
when matched then 
update set 
	t.Day90 = try_to_double(s.prediction) 
when not matched then 
insert (
    account_id
  , Day90
) 
values (
	s.account_id 
	, try_to_double(s.prediction)
) 
; 

merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif90_predicted where pif_in_90 is null) s 
on s.account_id = t.account_id 
when matched then 
update set 	
	t.Day75 = try_to_double(s.prediction)
when not matched then 
insert (
    account_id
  , Day75
) 
values (
   s.account_id
	, try_to_double(s.prediction)
) 
;

merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif75_predicted where pif_in_75 is null) s 
on s.account_id = t.account_id 
when matched then 
update set
	t.Day60 = try_to_double(s.prediction)
when not matched then 
insert  (
    account_id
  , Day60
) 
values (
	s.account_id 
	, try_to_double(s.prediction)
) 
;

merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif60_predicted where pif_in_60 is null) s 
on s.account_id = t.account_id 
when matched then 
update set 
	t.Day45 = try_to_double(s.prediction)
when not matched then 
insert (
    account_id
  , Day45
) 
values (
	s.account_id
	, try_to_double(s.prediction)
)
;

merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif45_predicted where pif_in_45 is null) s 
on s.account_id = t.account_id 
when matched then 
update set 
	t.Day30 = try_to_double(s.prediction)
when not matched then 
insert (
    account_id
  , Day30
) 
values (
	s.account_id
	, try_to_double(s.prediction)
) 
;

merge into production.&client.grab_predictions2 t 
using (select account_id, prediction from production.&client.pif30_predicted where pif_in_30 is null) s 
on s.account_id = t.account_id 
when matched then 
update set 
	t.Day18 = try_to_double(s.prediction)
when not matched then 
insert (
    account_id
  , Day18
) 
 values ( 
    s.account_id
	, try_to_double(s.prediction)
)
;

delete from production.&client.grab_predictions2 gb
using staging.rwjb.vw_Features f 
where 
	f.account_id = gb.account_id and 
	atb_bucket is null 
;
