use warehouse PREDICTIONS;

copy into @rwjb_export/BRS_&stamp.csv from (select account_id, priority from production.&client.vw_Blast where campaign = 'BRS' order by priority asc) 
file_format=(format_name='load_csv') single=true header=true; 
GET @rwjb_export/BR_&stamp file://&directory; 
REMOVE @rwjb_export pattern=".*BRS.*";

copy into @rwjb_export/BR6_&stamp.csv from (select account_id, priority from production.&client.vw_Blast where campaign = 'BR6' order by priority asc) 
file_format=(format_name='load_csv') single=true header=true; 
GET @rwjb_export/BR_&stamp file://&directory; 
REMOVE @rwjb_export pattern=".*BR6.*";

copy into @rwjb_export/BRB_&stamp.csv from (select account_id, priority from production.&client.vw_Manned order by priority asc) 
file_format=(format_name='load_csv') single=true header=true; 
GET @rwjb_export/BRB_&stamp file://&directory; 
REMOVE @rwjb_export pattern=".*BRB.*";

