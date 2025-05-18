with cte_1 as (select ad_date, campaign_name, adset_name, spend, impressions, reach, clicks, leads, value, 'facebook' as media_source
from facebook_ads_basic_daily fabd
left join facebook_campaign fc
on fabd.campaign_id=fc.campaign_id
left join facebook_adset fa
on fabd.adset_id=fa.adset_id
union all
select ad_date, campaign_name, adset_name, spend, impressions, reach, clicks, leads, value, 'google' as media_source
from google_ads_basic_daily gabd
order by ad_date)
select ad_date, media_source, campaign_name, adset_name, sum(spend) as total_spend, sum(impressions) as total_impressions,
sum(clicks) as total_clicks, sum(value) as total_value
from cte_1
where ad_date is not null
group by ad_date, media_source, campaign_name, adset_name
order by 1;