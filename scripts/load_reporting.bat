REM 
set UserDestinationPath=//pfs-fps/buffaloshare/Marty/Extracts
set schema=rwjb 
set getdate=%date:~10,4%%date:~4,2%%date:~7,2%

cd /d %~dp0

echo [extracting yesterday's quals from source db]
call BatchImport-stepwise\extract_Reporting_YesterdayQualHistory.bat %UserDestinationPath% %getdate%

echo [uploading yesterday's quals to reporting table]
call snowsql -c execupdater -f fsourceQueries\load_Snowflake_Reporting_Quals.sql -D directory=%UserDestinationPath% -D stamp=%getdate% -D client=%schema%

echo [updating reporting tables with today's predictions] 
call snowsql -c execupdater -f sourceQueries\report_Snowflake_Reporting_CampaignStats.sql -D client=%schema% 

echo [updating each account with predictions at ATB milestones]
call snowsql -c execupdater -f sourceQueries\report_Snowflake_Reporting_AccountPredictionsArchive.sql -D client=%schema% 

echo [calculating account-level accuracy based on latest predictions]
call snowsql -c execupdater -f sourceQueries\accuracy_Reporting_accuracyAtomic.sql -D client=%schema% 


