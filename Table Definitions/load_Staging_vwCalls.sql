CREATE VIEW staging.&client.vw_Calls 
AS 
select 
	c.account_id 
	, max(Calldate) as lastCallDate 
    , sum(case when callDate < Day_18 and outbound = 1 then 1 else 0 end) as outbound_in_18 
    , sum(case when callDate < Day_18 and pickup = 1 then 1 else 0 end) as pickup_in_18
	, sum(case when callDate < Day_18 and inbound = 1 then 1 else 0 end) as inbound_in_18
	, sum(case when callDate < Day_18 and Phonepay = 1 then 1 else 0 end) as Phonepay_in_18
    , sum(case when (callDate between Day_18 and Day_29) and outbound = 1 then 1 else 0 end) as outbound_in_30 
    , sum(case when (callDate between Day_18 and Day_29) and pickup = 1 then 1 else 0 end) as pickup_in_30
	, sum(case when (callDate between Day_18 and Day_29) and inbound = 1 then 1 else 0 end) as inbound_in_30
    , sum(case when (callDate between Day_18 and Day_29) and Phonepay = 1 then 1 else 0 end) as Phonepay_in_30
    , sum(case when (callDate between Day_30 and Day_44) and (outbound = 1) then 1 else 0 end) as outbound_in_45
    , sum(case when (callDate between Day_30 and Day_44) and (pickup = 1) then 1 else 0 end) as pickup_in_45
	, sum(case when (callDate between Day_30 and Day_44) and (inbound = 1) then 1 else 0 end) as inbound_in_45
    , sum(case when (callDate between Day_30 and Day_44) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_45
    , sum(case when (callDate between Day_45 and Day_59) and (outbound = 1) then 1 else 0 end) as outbound_in_60
    , sum(case when (callDate between Day_45 and Day_59) and (pickup = 1) then 1 else 0 end) as pickup_in_60
	, sum(case when (callDate between Day_45 and Day_59) and (inbound = 1) then 1 else 0 end) as inbound_in_60
    , sum(case when (callDate between Day_45 and Day_59) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_60
    , sum(case when (callDate between Day_60 and Day_74) and (outbound = 1) then 1 else 0 end) as outbound_in_75
    , sum(case when (callDate between Day_60 and Day_74) and (pickup = 1) then 1 else 0 end) as pickup_in_75
	, sum(case when (callDate between Day_60 and Day_74) and (inbound = 1) then 1 else 0 end) as inbound_in_75
    , sum(case when (callDate between Day_60 and Day_74) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_75
    , sum(case when (callDate between Day_75 and Day_89) and (outbound = 1)then 1 else 0 end) as outbound_in_90
    , sum(case when (callDate between Day_75 and Day_89) and (pickup = 1) then 1 else 0 end) as pickup_in_90
	, sum(case when (callDate between Day_75 and Day_89) and (inbound = 1) then 1 else 0 end) as inbound_in_90
    , sum(case when (callDate between Day_75 and Day_89) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_90
    , sum(case when (callDate between Day_90 and Day_104) and (outbound = 1) then 1 else 0 end) as outbound_in_105
    , sum(case when (callDate between Day_90 and Day_104) and (pickup = 1) then 1 else 0 end) as pickup_in_105
	, sum(case when (callDate between Day_90 and Day_104) and (inbound = 1) then 1 else 0 end) as inbound_in_105
    , sum(case when (callDate between Day_90 and Day_104) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_105
    , sum(case when (callDate between Day_105 and Day_119) and (outbound = 1) then 1 else 0 end) as outbound_in_120
    , sum(case when (callDate between Day_105 and Day_119) and (pickup = 1) then 1 else 0 end) as pickup_in_120
	, sum(case when (callDate between Day_105 and Day_119) and (inbound = 1) then 1 else 0 end) as inbound_in_120
    , sum(case when (callDate between Day_105 and Day_119) and (Phonepay = 1) then 1 else 0 end) as Phonepay_in_120
    , sum(case when calldate >= Day_120 and outbound = 1 then 1 else 0 end) as outbound_over_120
    , sum(case when callDate >= Day_120 and pickup = 1 then 1 else 0 end) as pickup_over_120
	, sum(case when callDate >= Day_120 and inbound = 1 then 1 else 0 end) as inbound_over_120
    , sum(case when callDate >= Day_120 and Phonepay = 1 then 1 else 0 end) as Phonepay_over_120
from Calls c
join Demographics d 
	on c.account_id = d.account_id 
group by c.account_id 

