merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_120_predicted_1.0" from production.&client.pif120_source_predicted where "pif_in_120" is null) s
on  s."account_id" = t.account_id 
when matched then 
update set 
	t.Day105 = s."pif_in_120_predicted_1.0"
when not matched then 
insert (
    account_id
  , Day105
) 
values ( 
    s."account_id"
	, s."pif_in_120_predicted_1.0"  
)
; 

merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_105_predicted_1.0" from production.&client.pif105_source_predicted where "pif_in_105" is null) s 
on s."account_id" = t.account_id 
when matched then 
update set 
	t.Day90 = s."pif_in_105_predicted_1.0" 
when not matched then 
insert (
    account_id
  , Day90
) 
values (
	s."account_id" 
	, s."pif_in_105_predicted_1.0" 
) 
; 

merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_90_predicted_1.0" from production.&client.pif90_source_predicted where "pif_in_90" is null) s 
on s."account_id" = t.account_id 
when matched then 
update set 	
	t.Day75 = s."pif_in_90_predicted_1.0" 
when not matched then 
insert (
    account_id
  , Day75
) 
values (
   s."account_id"
	, s."pif_in_90_predicted_1.0"
) 
;

merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_75_predicted_1.0" from production.&client.pif75_source_predicted where "pif_in_75" is null) s 
on s."account_id" = t.account_id 
when matched then 
update set
	t.Day60 = s."pif_in_75_predicted_1.0"
when not matched then 
insert  (
    account_id
  , Day60
) 
values (
	s."account_id" 
	, s."pif_in_75_predicted_1.0" 
) 
;

merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_60_predicted_1.0" from production.&client.pif60_source_predicted where "pif_in_60" is null) s 
on s."account_id" = t.account_id 
when matched then 
update set 
	t.Day45 = s."pif_in_60_predicted_1.0"
when not matched then 
insert (
    account_id
  , Day45
) 
values (
	s."account_id"
	, s."pif_in_60_predicted_1.0" 
)
;

merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_45_predicted_1.0" from production.&client.pif45_source_predicted where "pif_in_45" is null) s 
on s."account_id" = t.account_id 
when matched then 
update set 
	t.Day30 = s."pif_in_45_predicted_1.0"
when not matched then 
insert (
    account_id
  , Day30
) 
values (
	s."account_id"
	, s."pif_in_45_predicted_1.0"
) 
;

merge into production.&client.grab_predictions t 
using (select "account_id", "pif_in_30_predicted_1.0" from production.&client.pif30_source_predicted where "pif_in_30" is null) s 
on s."account_id" = t.account_id 
when matched then 
update set 
	t.Day18 = s."pif_in_30_predicted_1.0"
when not matched then 
insert (
    account_id
  , Day18
) 
 values ( 
    s."account_id"
	, s."pif_in_30_predicted_1.0" 
)
;

delete from production.&client.grab_predictions gb
using staging.rwjb.vw_Features f 
where 
	f.account_id = gb.account_id and 
	atb_bucket is null 
;
