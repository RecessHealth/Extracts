bcp "DECLARE @SQL VARCHAR(3000); SET @SQL = 'SELECT * FROM TRANS WHERE Client_ID LIKE ''BH%%'''; exec up_LoadCUBSODBC @sql,'SEC_odbc','MARTIAN_JAY'; SELECT transaction_id, account_id, transaction_amount, Client_ID, transaction_code, transaction_date FROM STAGING..MARTIAN_JAY where post_date = case when datepart(weekday,getutcdate()) in (3,4,5,6) then convert(datetime,datediff(day,0,getutcdate()-1),102) when datepart(weekday,getutcdate()) = 2 then convert(datetime,datediff(day,0,getutcdate()-3),102) end;" queryout %1\Transactions-postings_%2.txt -S "pfs-sql1" -U readonly -P today05 -c