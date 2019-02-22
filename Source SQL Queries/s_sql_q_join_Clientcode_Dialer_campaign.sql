select a.project, campaign_id, campaign
from Stratadial.dbo.tbl_project a
inner join tbl_CampaignMapping c
	on a.campaignid = c.mapping_name
order by project asc; 
