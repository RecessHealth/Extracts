@ECHO OFF
REM prompt user to identify where to save extracted files
REM set path=%path%;C:\Program Files\Snowflake SnowSQL;
set path=%path%;C:\Program Files\Snowflake SnowSQL;
set UserDestinationPath=//pfs-fps/buffaloshare/Marty/Extracts
set schema=rwjb 

REM change directory --> all paths relative to this batch script 
cd /d %~dp0

REM grab timestamp to append to file extracts 
set getdate=%date:~10,4%%date:~4,2%%date:~7,2%
echo local time at start: [%getdate% -- %time%] > Log.txt 2>&1

REM extract source files 
echo [extracting Demographic data] >> Log.txt 2>&1
call BatchImport-stepwise\extract_Demographics-inventory.bat %UserDestinationPath% %getdate% >> Log.txt 2>&1

echo [extracting Phone Numbers] >> Log.txt 2>&1
call BatchImport-stepwise\extract_Phonebook.bat %UserDestinationPath% %getdate% >> Log.txt 2>&1

echo [extracting outbound Calling data] >> Log.txt 2>&1
call BatchImport-stepwise\extract_Calls-outbound_lastBusinessDay.bat %UserDestinationPath% %getdate% >> Log.txt 2>&1

echo [extracting inbound Calling data] >> Log.txt 2>&1
call BatchImport-stepwise\extract_Calls-inbound_lastBusinessDay.bat %UserDestinationPath% %getdate% >> Log.txt 2>&1

echo [extracting Transactions data] >> Log.txt 2>&1
call BatchImport-stepwise\extract_Transactions-postings_lastBusinessDay.bat %UserDestinationPath% %getdate% >> Log.txt 2>&1

REM load staging tables 
echo [uploading Demographics] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\stage_Snowflake_Staging_Demographics-staging.sql -D directory=%UserDestinationPath% -D stamp=%getdate% >> Log.txt 2>&1

echo [uploading inbound, outbound calls] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\stage_Snowflake_Staging_Calls-staging.sql -D directory=%UserDestinationPath% -D stamp=%getdate% -o quiet=false >> Log.txt 2>&1

echo [uploading transactions] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\stage_Snowflake_Staging_Transactions-staging.sql -D directory=%UserDestinationPath% -D stamp=%getdate% -o quiet=false >> Log.txt 2>&1

REM update Demographics storage table 
echo [updating demographics] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\load_Snowflake_Staging_Demographics.sql -o quiet=false >> Log.txt 2>&1

REM update Phonebook to latest phone numbers
echo [updating phonebook] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\load_Snowflake_Staging_Phonebook.sql -o quiet=false >> Log.txt 2>&1

REM insert Calls, Transactions into storage tables 
echo [storing calls to account profiles] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\load_Snowflake_Staging_Calls.sql >> Log.txt 2>&1

echo [storing transactions to account profiles] >> Log.txt 2>&1
call snowsql -c pfs -f sourceQueries\load_Snowflake_Staging_Transactions.sql >> Log.txt 2>&1

REM extract daily Features list 
echo [extracting today's features list for active accounts] >> Log.txt 
call snowsql -c rwjb -f sourceQueries\extract_Snowflake_Staging_Features.sql -D client=%schema% -D stamp=%getdate% -D directory=%UserDestinationPath% -o quiet=false >> Log.txt  2>&1

REM convert line endings from single-byte "\r" per Snowflake file format --> Windows "\r\n" for Bryan's app to pick-up 
call BatchImport-stepwise/transform_windowsRowTerminators.bat %UserDestinationPath% %getdate% >> Log.txt 2>&1

REM load source tables for Kraken 
echo [adding accounts for prediction to training set for each model] >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif30.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif45.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif60.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif75.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif90.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif105.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1
call snowsql -c rwjb -f sourceQueries\source_Snowflake_Production_pif120.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1

REM create "Archive" directory if non-existant, move source files to archive 
if not exist %UserDestinationPath%\archive\NUL md %UserDestinationPath%\archive >> Log.txt 2>&1

REM move staging files to flat file archive 
echo archiving source data >> Log.txt 2>&1
call move %UserDestinationPath%\*_%getdate%.txt %UserDestinationPath%\archive >> Log.txt 2>&1

REM print timestamp 
echo local time at completion: [%getdate% -- %time%] >> Log.txt 
