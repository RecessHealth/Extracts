use warehouse PREDICTIONS;

copy into @rwjb_export/DialOrder_&stamp.csv from (select account_id, desk_id, priority, toBlast,&stamp from production.&client.vw_Allocations order by priority asc) 
file_format=(format_name='load_csv') single=true header=true; 
GET @rwjb_export/DialOrder_&stamp.csv file://&directory; 
REMOVE @rwjb_export pattern=".*DialOrder.*";