remove @ebo_rawsource; 
put file://&directory/Quals_&{stamp}.txt @ebo_rawsource; 
copy into reporting.&client.quals from '@ebo_rawsource/quals_&{stamp}.txt.gz' file_format=(format_name='load_tsv' compression='GZIP'); 