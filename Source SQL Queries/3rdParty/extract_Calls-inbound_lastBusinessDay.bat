REM extract inbound calls from yesterday for <client>
bcp "select account_id, callDate from tbl_InboundCall_History where logon = 'SEC' and calldate = case when datepart(weekday, getutcdate()) in (3,4,5,6) then convert(datetime,datediff(day,0,getutcdate()-1),102) when datepart(weekday, getutcdate()) in (2) then convert(datetime,datediff(day,0,getutcdate()-3),102) end;" queryout %1\Calls-inbound_%2.txt -S "pfs-sql1" -d "PFS" -U readonly -P today05 -c 