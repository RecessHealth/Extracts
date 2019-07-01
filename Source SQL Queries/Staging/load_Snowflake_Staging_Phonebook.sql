MERGE into phonebook as t
USING phonebook_staging as s 
	on t.account_id = s.account_id 
WHEN MATCHED 
THEN UPDATE SET 
	t.account_phone = s.account_phone 
WHEN NOT MATCHED THEN 
INSERT (
	account_id 
	, account_phone 
) 
VALUES (
	account_id
	, account_phone
)
; 