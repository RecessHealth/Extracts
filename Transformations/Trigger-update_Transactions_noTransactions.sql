BEGIN TRAN FeatureTransactions with mark; 
update Features
	set 
		-- set non-null value for accounts that don't have transaction data 
		paid_in_30 = coalesce(paid_in_30, 0)
		, paid_in_60 = coalesce(paid_in_60,0)
		, paid_in_90 = coalesce(paid_in_90,0)
		, paid_in_120 = coalesce(paid_in_120,0)
		, trans_in_30 = coalesce(trans_in_30,0)
		, trans_in_60 = coalesce(trans_in_60,0)
		, trans_in_90 = coalesce(trans_in_90,0)
		, trans_in_120 = coalesce(trans_in_120,0)
;
COMMIT TRAN FeatureTransactions;
 
