REMOVE @RWJB_Staging pattern='.*Calls-inbound.*.txt.gz';
PUT file://&directory//Calls-inbound_&stamp.txt @rwjb_staging;
TRUNCATE callsinbound_staging;
COPY INTO callsinbound_staging FROM @rwjb_staging/Calls-inbound_&stamp.txt.gz FILE_FORMAT = (FORMAT_NAME = 'load_tsv');

REMOVE @RWJB_Staging pattern='.*Calls-outbound.*.txt.gz';
PUT file://&directory//Calls-outbound_&stamp.txt @rwjb_staging;
TRUNCATE callsoutbound_staging;
COPY INTO callsoutbound_staging FROM @rwjb_staging/Calls-outbound_&stamp.txt.gz FILE_FORMAT = (FORMAT_NAME = 'load_tsv');
