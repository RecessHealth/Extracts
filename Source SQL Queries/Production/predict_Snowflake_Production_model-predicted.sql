remove @RWJB_staging pattern='.*Predicted_Features.*_PIF30.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF30.csv @rwjb_staging;
truncate table production.&client.pif30_predicted; 
copy into production.&client.pif30_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF30.csv.gz FILE_FORMAT=(FORMAT_NAME='load_csv');

remove @RWJB_staging pattern='.*Predicted_Features_.*_PIF45.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF45.csv @rwjb_staging;
truncate table production.&client.pif45_predicted; 
copy into production.&client.pif45_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF45.csv.gz FILE_FORMAT=(FORMAT_NAME='load_csv');

remove @RWJB_staging pattern='.*Predicted_Features_.*_PIF60.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF60.csv @rwjb_staging;
truncate table production.&client.pif60_predicted; 
copy into production.&client.pif60_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF60.csv.gz FILE_FORMAT=(FORMAT_NAME='load_csv');

remove @RWJB_staging pattern='.*Predicted_Features_.*_PIF75.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF75.csv @rwjb_staging;
truncate table production.&client.pif75_predicted; 
copy into production.&client.pif75_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF75.csv.gz FILE_FORMAT=(FORMAT_NAME='load_csv');

remove @RWJB_staging pattern='.*Predicted_Features_.*_PIF90.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF90.csv @rwjb_staging;
truncate table production.&client.pif90_predicted; 
copy into production.&client.pif90_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF90.txt.gz FILE_FORMAT=(FORMAT_NAME='load_csv');

remove @RWJB_staging pattern='.*Predicted_Features_.*_PIF105.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF105.csv @rwjb_staging;
truncate table production.&client.pif105_predicted; 
copy into production.&client.pif105_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF105.csv.gz FILE_FORMAT=(FORMAT_NAME='load_csv');

remove @RWJB_staging pattern='.*Predicted_Features_.*_PIF120.csv.gz'; 
PUT file://&directory//Predicted_Features_&{stamp}_PIF120.csv @rwjb_staging;
truncate table production.&client.pif120_predicted; 
copy into production.&client.pif120_predicted from @rwjb_staging/Predicted_Features_&{stamp}_PIF120.csv.gz FILE_FORMAT=(FORMAT_NAME='load_csv');