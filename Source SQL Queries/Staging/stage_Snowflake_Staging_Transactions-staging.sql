REMOVE @RWJB_Staging pattern='.*Transactions-postings.*.txt.gz';
PUT file://&directory//Transactions-postings_&stamp.txt @rwjb_staging;
TRUNCATE transactions_staging;
COPY INTO transactions_staging FROM @rwjb_staging/Transactions-postings_&stamp.txt.gz FILE_FORMAT = (FORMAT_NAME = 'load_tsv');