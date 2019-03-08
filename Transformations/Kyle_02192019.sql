CREATE OR REPLACE TABLE "KRAKEN_PIF_120_STAGE"
AS

SELECT "a"."account_id"
    ,"a"."client_id"
    ,"a"."patient_age"
    ,"a"."zip_code"
    ,COALESCE("b"."CITY_NAME",'UNKNOWN') AS "city_name"
    ,COALESCE("b"."COUNTY_NAME",'UNKNOWN') AS "county_name"
    ,COALESCE("b"."STATE_NAME",'UNKNOWN') AS "state_name"
    ,COALESCE("b"."POPULATION",0) AS "population_estimate"
    ,COALESCE("b"."DENSITY",0.00) AS "density_estimate"
    ,COALESCE("b"."TIMEZONE",'UNKNOWN') AS "local_timezone"
    ,"a"."financial_class"
    ,"a"."patient_type"
    ,"a"."med_service"
    ,"a"."status_code"
    ,"a"."previous_status_code"
    ,"a"."employer_known"
    ,"a"."is_employed"
    ,"a"."assigned_date"
    ,YEAR("a"."assigned_date") AS "assigned_year"
    ,MONTH("a"."assigned_date") AS "assigned_month"
    ,WEEK("a"."assigned_date") AS "assigned_week"
    ,"a"."initial_balance"
    ,"a"."cancelled_balance"
    ,"a"."paid_in_30"
    ,"a"."paid_in_60"
    ,"a"."paid_in_90"
    ,"a"."paid_in_120"
    ,"a"."paid_in_180"
    ,"a"."paid_in_365"
    ,COALESCE("a"."transaction_total",0.00) AS "transaction_total"
    ,"a"."transaction_count"
    ,"a"."trans_in_30"
    ,"a"."trans_in_60"
    ,"a"."trans_in_90"
    ,"a"."trans_in_120"
    ,CASE WHEN CURRENT_DATE() < DATEADD('day',120,"a"."assigned_date") AND ("a"."paid_in_120" < "a"."initial_balance") THEN NULL ELSE
        CASE WHEN "a"."initial_balance" = 0 THEN 'false' ELSE
            CASE WHEN ("a"."paid_in_120" / "a"."initial_balance") >= 0.9 THEN 'true' ELSE 'false' END
        END
     END AS "pif_in_120"

FROM (
SELECT "a"."ACCOUNT_ID" AS "account_id"
    ,"a"."CLIENT_ID" AS "client_id"
    ,"a"."PATIENT_AGE" AS "patient_age"
    ,LEFT(LPAD("a"."ZIP_CODE",5,'0'),5) AS "zip_code"
    ,COALESCE(NULLIF(NULLIF("a"."FINANCIAL_CLASS",'NULL'),''),'UNKNOWN') AS "financial_class"
    ,COALESCE(NULLIF(NULLIF("a"."PATIENT_TYPE",'NULL'),''),'UNKNOWN') AS "patient_type"
    ,COALESCE(NULLIF(NULLIF("a"."MED_SERVICE",'NULL'),''),'UNKNOWN') AS "med_service"
    ,"a"."STATUS_CODE" AS "status_code"
    ,"a"."PREVIOUS_STATUS_CODE" AS "previous_status_code"
    ,CASE WHEN "a"."EMPLOYER" IN ('NULL','UNKNOWN') THEN '0' ELSE '1' END AS "employer_known"
    ,"a"."EMPLOYED" AS "is_employed"
    ,"a"."ASSIGNED_DATE"::DATE AS "assigned_date"
    ,"a"."LETTERS_SENT" AS "letter_sent"
    ,"a"."INITIAL_BALANCE" AS "initial_balance"
    ,"a"."CANCELLED_AMOUNT" AS "cancelled_balance"
    ,COUNT(DISTINCT "b"."ID") AS "transaction_count"
    ,COUNT(DISTINCT CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',30,"a"."ASSIGNED_DATE"::DATE) THEN "b"."ID" END) AS "trans_in_30"
    ,COUNT(DISTINCT CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',60,"a"."ASSIGNED_DATE"::DATE) THEN "b"."ID" END) AS "trans_in_60"
    ,COUNT(DISTINCT CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',90,"a"."ASSIGNED_DATE"::DATE) THEN "b"."ID" END) AS "trans_in_90"
    ,COUNT(DISTINCT CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',120,"a"."ASSIGNED_DATE"::DATE) THEN "b"."ID" END) AS "trans_in_120"
    ,SUM(CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',30,"a"."ASSIGNED_DATE"::DATE) THEN "b"."AMOUNT" ELSE 0.00 END) AS "paid_in_30"
    ,SUM(CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',60,"a"."ASSIGNED_DATE"::DATE) THEN "b"."AMOUNT" ELSE 0.00 END) AS "paid_in_60"
    ,SUM(CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',90,"a"."ASSIGNED_DATE"::DATE) THEN "b"."AMOUNT" ELSE 0.00 END) AS "paid_in_90"
    ,SUM(CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',120,"a"."ASSIGNED_DATE"::DATE) THEN "b"."AMOUNT" ELSE 0.00 END) AS "paid_in_120"
    ,SUM(CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',180,"a"."ASSIGNED_DATE"::DATE) THEN "b"."AMOUNT" ELSE 0.00 END) AS "paid_in_180"
    ,SUM(CASE WHEN "b"."TRANS_DATE"::DATE <= DATEADD('day',365,"a"."ASSIGNED_DATE"::DATE) THEN "b"."AMOUNT" ELSE 0.00 END) AS "paid_in_365"
    ,COALESCE(SUM("b"."AMOUNT"),'0.00') AS "transaction_total"

FROM "SQUIDBITS"."PFS_GROUP"."ACCOUNTS" AS "a"

LEFT JOIN "SQUIDBITS"."PFS_GROUP"."TRANSACTION_RECORDS" AS "b" ON "a"."ACCOUNT_ID" = "b"."ACCOUNT_ID"

WHERE "a"."CLIENT_ID" LIKE 'BH%'

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

) AS "a"

LEFT JOIN "SQUIDBITS"."PFS_GROUP"."ZIP_DETAILS" AS "b" ON "a"."zip_code" = LPAD("b"."ZIP_CODE",5,'0')

WHERE "a"."transaction_total" >= 0 /*AND "a"."assigned_date" < CURRENT_DATE()-140*/
