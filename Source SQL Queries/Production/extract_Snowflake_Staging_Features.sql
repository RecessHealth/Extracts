copy into @rwjb_export/Features_pif30.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_18, pickup_in_18, inbound_in_18, phonepay_in_18, paid_in_18, trans_in_18, pif_in_30 from staging.&client.vw_features where pif_in_30 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif30.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif30.*";

copy into @rwjb_export/Features_pif45.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_30, pickup_in_30, inbound_in_30, phonepay_in_30, paid_in_30, trans_in_30, pif_in_45 from staging.&client.vw_features where pif_in_45 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif45.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif45.*";

copy into @rwjb_export/Features_pif60.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_45, pickup_in_45, inbound_in_45, phonepay_in_45, paid_in_45, trans_in_45, pif_in_60 from staging.&client.vw_features where pif_in_60 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif60.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif60.*";

copy into @rwjb_export/Features_pif75.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_60, pickup_in_60, inbound_in_60, phonepay_in_60, paid_in_60, trans_in_60, pif_in_75 from staging.&client.vw_features where pif_in_75 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif75.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif75.*";

copy into @rwjb_export/Features_pif90.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_75, pickup_in_75, inbound_in_75, phonepay_in_75, paid_in_75, trans_in_75, pif_in_90 from staging.&client.vw_features where pif_in_90 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif90.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif90.*";

copy into @rwjb_export/Features_pif105.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_90, pickup_in_90, inbound_in_90, phonepay_in_90, paid_in_90, trans_in_90, pif_in_105 from staging.&client.vw_features where pif_in_105 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif105.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif105.*";

copy into @rwjb_export/Features_pif120.tsv from (select account_id, client_id, patient_age, density_estimate, financial_class, patient_type, med_service, assigned_year, assigned_month, assigned_week, initial_balance, outbound_in_105, pickup_in_105, inbound_in_105, phonepay_in_105, paid_in_105, trans_in_105, pif_in_120 from staging.&client.vw_features where pif_in_120 is null) 
file_format=(format_name='load_tsv') max_file_size=100000000 single=true header=true; 
GET @rwjb_export/Features_pif120.tsv file://&directory; 
REMOVE @rwjb_export pattern=".*Features_pif120.*";
