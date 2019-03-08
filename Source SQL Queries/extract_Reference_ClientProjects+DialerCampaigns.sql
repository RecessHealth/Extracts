-- mapping projects to dialer campaigns 
-- for dataset partitioning reference 

select a.project, c.mapping_name as campaign_id, c.display_name as campaign
from Stratadial.dbo.tbl_project a
inner join tbl_CampaignMapping c
	on a.campaignid = c.mapping_name
order by project asc; 
