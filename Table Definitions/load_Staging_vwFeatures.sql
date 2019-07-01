CREATE OR REPLACE VIEW staging.rwjb.vw_Features (
    account_id
    , client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, initial_balance
	, outbound_in_18
	, pickup_in_18
	, inbound_in_18
    , phonepay_in_18
    , paid_in_18
	, trans_in_18
	, outbound_in_30
	, pickup_in_30
	, inbound_in_30
    , phonepay_in_30
	, paid_in_30
	, trans_in_30
	, outbound_in_45
	, pickup_in_45
	, inbound_in_45
    , phonepay_in_45
	, paid_in_45
	, trans_in_45
	, outbound_in_60
	, pickup_in_60
	, inbound_in_60
    , phonepay_in_60
	, paid_in_60
	, trans_in_60
	, outbound_in_75
	, pickup_in_75
	, inbound_in_75
    , phonepay_in_75
	, paid_in_75
	, trans_in_75
	, outbound_in_90
	, pickup_in_90
	, inbound_in_90
    , phonepay_in_90
	, paid_in_90
	, trans_in_90
	, outbound_in_105
	, pickup_in_105
	, inbound_in_105
    , phonepay_in_105
	, paid_in_105
	, trans_in_105
	, outbound_in_120
	, pickup_in_120
	, inbound_in_120
    , phonepay_in_120
	, paid_in_120
	, trans_in_120
    , pif_in_18
    , pif_in_30 
    , pif_in_45
    , pif_in_60
    , pif_in_75
    , pif_in_90
    , pif_in_105
    , pif_in_120
    , atb_bucket
    , called 
)
as 
select 
	d.account_id
	, client_id
	, patient_age
	, density_estimate
	, financial_class
	, patient_type
	, med_service
	, assigned_year
	, assigned_month
	, assigned_week
	, zeroifnull(initial_balance)
	, zeroifnull(outbound_in_18)
	, zeroifnull(pickup_in_18)
	, zeroifnull(inbound_in_18)
    , zeroifnull(phonepay_in_18)
    , zeroifnull(paid_in_18)
	, zeroifnull(trans_in_18)
	, zeroifnull(outbound_in_30)
	, zeroifnull(pickup_in_30)
	, zeroifnull(inbound_in_30)
    , zeroifnull(phonepay_in_30)
	, zeroifnull(paid_in_30)
	, zeroifnull(trans_in_30)
	, zeroifnull(outbound_in_45)
	, zeroifnull(pickup_in_45)
	, zeroifnull(inbound_in_45)
    , zeroifnull(phonepay_in_45)
	, zeroifnull(paid_in_45)
	, zeroifnull(trans_in_45)
	, zeroifnull(outbound_in_60)
	, zeroifnull(pickup_in_60)
	, zeroifnull(inbound_in_60)
    , zeroifnull(phonepay_in_60)
	, zeroifnull(paid_in_60)
	, zeroifnull(trans_in_60)
	, zeroifnull(outbound_in_75)
	, zeroifnull(pickup_in_75)
	, zeroifnull(inbound_in_75)
    , zeroifnull(phonepay_in_75)
	, zeroifnull(paid_in_75)
	, zeroifnull(trans_in_75)
	, zeroifnull(outbound_in_90)
	, zeroifnull(pickup_in_90)
	, zeroifnull(inbound_in_90)
    , zeroifnull(phonepay_in_90)
	, zeroifnull(paid_in_90)
	, zeroifnull(trans_in_90)
	, zeroifnull(outbound_in_105)
	, zeroifnull(pickup_in_105)
	, zeroifnull(inbound_in_105)
    , zeroifnull(phonepay_in_105)
	, zeroifnull(paid_in_105)
	, zeroifnull(trans_in_105)
	, zeroifnull(outbound_in_120)
	, zeroifnull(pickup_in_120)
	, zeroifnull(inbound_in_120)
    , zeroifnull(phonepay_in_120)
	, zeroifnull(paid_in_120)
	, zeroifnull(trans_in_120)
	, CASE 
		when current_date() < Day_18 AND paid_in_18 is null then null
		when current_date() < Day_18 AND abs(paid_in_18) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_18) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_18
	, CASE 
		when current_date() < Day_30 AND paid_in_30 is null then null
		when current_date() < Day_30 AND abs(paid_in_30) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_30) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_30 
	, CASE 
		when current_date() < Day_45 AND paid_in_45 is null then null
		when current_date() < Day_45 AND abs(paid_in_45) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_45) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_45
	, CASE 
		when current_date() < Day_60 AND paid_in_60 is null then null
		when current_date() < Day_60 AND abs(paid_in_60) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_60) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_60 
	, CASE 
		when current_date() < Day_75 AND paid_in_75 is null then null
		when current_date() < Day_75 AND abs(paid_in_75) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_75) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_75 
	, CASE 
		when current_date() < Day_90 AND paid_in_90 is null then null
		when current_date() < Day_90 AND abs(paid_in_90) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_90) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_90 
	, CASE 
		when current_date() < Day_105 AND paid_in_105 is null then null
		when current_date() < Day_105 AND abs(paid_in_105) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_105) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_105 
	, CASE 
		when current_date() < Day_120 AND paid_in_120 is null then null
		when current_date() < Day_120 AND abs(paid_in_120) < abs(to_number(initial_balance,13,2))-9.99 then null	-- if Day 30 is today or after today (account aged Days 0 - 29) and the amount paid within 30 days is less than balance ==> withold judgement until Day 30 
		else case 
            WHEN initial_balance = 0 THEN 'false'			-- ignore 0 balances 
            else 
                case when abs(paid_in_120) >= abs(to_number(initial_balance,13,2))-9.99 then 'true' 					-- small balance write-off for Barnabas = $9.99 (Non-Medicare, don't require statements) 
				else 'false' end 
            end 
		end as pif_in_120
	, ATB_bucket
	, case
		when ATB_bucket is null then null  
		when ATB_bucket = '105' AND lastCallDate >= Day_105 then 1 
		when ATB_bucket ='105' then 0 
		else case 
			when ATB_bucket = '90' AND lastCallDate >= Day_90 then 1 
			when ATB_bucket ='90' then 0 
			else case 
				when ATB_bucket ='75' AND lastCallDate >= Day_75 then 1
				when ATB_bucket='75' then 0 
				else case
					when ATB_bucket='60' AND lastCallDate >= Day_60 then 1 
					when ATB_bucket='60' then 0 
					else case 
						when ATB_bucket ='45' AND lastCallDate >= Day_45 then 1 
						when ATB_bucket ='45' then 0 
						else case 
							when ATB_bucket='30' AND lastCallDate >= Day_30 then 1
							when ATB_bucket = '30' then 0 
							else case 
								when ATB_bucket = '18' AND lastCallDate >= Day_18 then 1 
								when ATB_bucket ='18' then 0 
								else null 
								end 
							end
						end
					end 
				end
			end 
		end as called
from demographics d
left join vw_calls c
	on d.account_id = c.account_id
left join vw_transactions t 
	on d.account_id = t.account_id
left join zipcodes z 
	on d.zip_code = to_varchar(z.zipcode)
;