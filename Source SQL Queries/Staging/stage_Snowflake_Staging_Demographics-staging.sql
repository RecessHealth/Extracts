REMOVE @RWJB_Staging pattern='.*Demographics.*.txt.gz';
PUT file://&directory/Demographics_&stamp.txt @rwjb_staging;
TRUNCATE demographics_staging;
COPY INTO demographics_staging FROM @rwjb_staging/Demographics_&stamp.txt.gz FILE_FORMAT = (FORMAT_NAME = 'load_tsv');

REMOVE @RWJB_Staging pattern='.*Phonebook.*.txt.gz';
PUT file://&directory/Phonebook_&stamp.txt @rwjb_staging;
TRUNCATE phonebook_staging;
COPY INTO phonebook_staging FROM @rwjb_staging/Phonebook_&stamp.txt.gz FILE_FORMAT = (FORMAT_NAME = 'load_tsv');
