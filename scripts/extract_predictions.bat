@ECHO OFF
REM prompt user to identify where to save extracted files
REm set path=%path%;C:\Program Files\Snowflake SnowSQL;
set path=%path%;C:\Program Files\Snowflake SnowSQL;
set UserDestinationPath=//pfs-fps/buffaloshare/Marty/Extracts
set schema=rwjb 

set getdate=%date:~10,4%%date:~4,2%%date:~7,2%

cd /d %~dp0

REM print timestamp 
echo local time at start: [%getdate% -- %time%] >> Log.txt 

REM upload predictions from Data Robot to Snowflake 
echo [uploading Data Robot predictions]>>Log.txt 
call snowsql -c rwjb -f sourceQueries\predict_Snowflake_Production_model-predicted.sql -D directory=%UserDestinationPath%/archive -D client=%schema% -D stamp=%getdate% -o quiet=false >> Log.txt 2>&1

REM extract Prediction list 
echo [consolidating predictions from each model for each account] >> Log.txt 
call snowsql -c rwjb -f sourceQueries\predict_Snowflake_Production_grabPredictions.sql -D client=%schema% -o quiet=false >> Log.txt 2>&1

echo [pulling CSV for Dial order] >> Log.txt 2>&1
echo [STILL NEED TO QUALIFY and generate campaigns!] >> Log.txt 2>&1
call snowsql -c pfs -s rwjb -d production -f sourceQueries\extract_Snowflake_Production_toQual.sql -D directory=%UserDestinationPath% -D stamp=%getdate% -D client=%schema% >> Log.txt 2>&1

echo [uploading CSVs to linked SQL server for PFS to qualify and generate campaigns] >> Log.txt 
call bcp predictions in %UserDestinationPath%\DialOrder_%getdate%.csv -S "pfs-sql2\sql14" -d "ML1" -F 2 -f formatFiles\DialOrder_format.txt  -T >> Log.txt 2>&1

REM move remaining production files to flat file archive 
echo archiving source data >> Log.txt 
call move %UserDestinationPath%\*.csv %UserDestinationPath%\archive >> Log.txt 2>&1

REM print timestamp 
echo local time at completion: [%getdate% -- %time%] >> Log.txt 