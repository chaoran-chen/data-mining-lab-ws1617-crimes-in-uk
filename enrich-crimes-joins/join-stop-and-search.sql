insert into crimes_uk_crimes_with_stop_and_search (
	crime_id,
	number_ss,
	number_ss_person_searches,
	number_ss_vehicle_searches,
	number_ss_asian_searches,
	number_ss_black_searches,
	number_ss_white_searches,
	number_ss_outcome_suspect_arrested,
	number_ss_outcome_article_found,
	number_ss_outcome_offender_given_drugs_possession_warning,
	number_ss_outcome_offender_cautioned,
	number_ss_outcome_suspect_summonsed_to_court,
	number_ss_outcome_nothing_found,
	number_ss_outcome_offender_given_penalty_notice,
	number_ss_outcome_local_resolution,
	number_ss_age_under_10,
	number_ss_age_10_17,
	number_ss_age_18_24,
	number_ss_age_25_34,
	number_ss_age_over_34,
	number_ss_object_controlled_drugs,
	number_ss_object_criminal_demage_articles,
	number_ss_object_stolen_goods,
	number_ss_object_weapons,
	number_ss_object_firearms,
	number_ss_object_evidence
)
select
	c.id,
	count(*),
	sum(case when s.type = 'Person search' then 1 else 0 end),
	sum(case when s.type <> 'Person search' then 1 else 0 end),
	sum(case when s.officer_defined_ethnicity = 'Asian' then 1 else 0 end),
	sum(case when s.officer_defined_ethnicity = 'Black' then 1 else 0 end),
	sum(case when s.officer_defined_ethnicity = 'White' then 1 else 0 end),
	sum(case when s.outcome = 'Suspect arrested' then 1 else 0 end),
	sum(case when s.outcome = 'Article found - Detailed outcome unavailable' then 1 else 0 end),
	sum(case when s.outcome = 'Offender given drugs possession warning' then 1 else 0 end),
	sum(case when s.outcome = 'Offender cautioned' then 1 else 0 end),
	sum(case when s.outcome = 'Suspect summonsed to court' then 1 else 0 end),
	sum(case when s.outcome = 'Nothing found - no further action' then 1 else 0 end),
	sum(case when s.outcome = 'Offender given penalty notice' then 1 else 0 end),
	sum(case when s.outcome = 'Local resolution' then 1 else 0 end),
	sum(case when s.age_range = 'under 10' then 1 else 0 end),
	sum(case when s.age_range = '10-17' then 1 else 0 end),
	sum(case when s.age_range = '18-24' then 1 else 0 end),
	sum(case when s.age_range = '25-34' then 1 else 0 end),
	sum(case when s.age_range = 'over 34' then 1 else 0 end),
	sum(case when s.object_of_search = 'Controlled drugs' then 1 else 0 end),
	sum(case when s.object_of_search = 'Articles for use in criminal damage' then 1 else 0 end),
	sum(case when s.object_of_search = 'Stolen goods' then 1 else 0 end),
	sum(case when (s.object_of_search = 'Anything to threaten or harm anyone' or 
		s.object_of_search = 'Offensive weapons')then 1 else 0 end),
	sum(case when s.object_of_search = 'Fireworks' then 1 else 0 end),
	sum(case when s.object_of_search = 'Evidence of offences under the Act' then 1 else 0 end)
from crimes_uk_crimes c, crimes_uk_stop_and_search s
where
	ST_CONTAINS(
	    ST_MakeEnvelope(
	          c.latitude - (5.0/1110),
	          c.longitude - (5.0/1110),
	          c.latitude + (5.0/1110), 
	          c.longitude + (5.0/1110)
	        )
	, s.geom)
group by c.id;
