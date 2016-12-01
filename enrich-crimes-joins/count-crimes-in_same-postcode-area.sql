with number_crimes_in_postcode_area as
(
    select 
        post_code, 
        count(*) as number_crimes_in_pca,
        sum(case when crime_type = 'Other crime' then 1 else 0 end) as number_crimes_in_pca_other_crime,
        sum(case when crime_type = 'Possession of weapons' then 1 else 0 end) as number_crimes_in_pca_possession_of_weapons,
        sum(case when crime_type = 'Criminal damage and arson' then 1 else 0 end) as number_crimes_in_pca_criminal_damage_and_arson,
        sum(case when crime_type = 'Shoplifting' then 1 else 0 end) as number_crimes_in_pca_shoplifting,
        sum(case when crime_type = 'Robbery' then 1 else 0 end) as number_crimes_in_pca_robbery,
        sum(case when crime_type = 'Burglary' then 1 else 0 end) as number_crimes_in_pca_burglary,
        sum(case when crime_type = 'Public disorder and weapons' then 1 else 0 end) as number_crimes_in_pca_public_disorder_and_weapons,
        sum(case when crime_type = 'Drugs' then 1 else 0 end) as number_crimes_in_pca_drugs,
        sum(case when crime_type = 'Other theft' then 1 else 0 end) as number_crimes_in_pca_other_theft,
        sum(case when crime_type = 'Violent crime' then 1 else 0 end) as number_crimes_in_pca_violent_crime,
        sum(case when crime_type = 'Public order' then 1 else 0 end) as number_crimes_in_pca_public_order,
        sum(case when crime_type = 'Violence and sexual offences' then 1 else 0 end) as number_crimes_in_pca_violence_and_sexual_offences,
        sum(case when crime_type = 'Vehicle crime' then 1 else 0 end) as number_crimes_in_pca_vehicle_crime,
        sum(case when crime_type = 'Bicycle theft' then 1 else 0 end) as number_crimes_in_pca_bicycle_theft,
        sum(case when crime_type = 'Theft from the person' then 1 else 0 end) as number_crimes_in_pca_theft_from_the_person,
        sum(case when crime_type = 'Anti-social behaviour' then 1 else 0 end) as number_crimes_in_pca_anti_social_behaviour
    from crimes_uk_crimes_all
    group by post_code
)
update crimes_uk_crimes_all c
set 
    number_crimes_in_pca = n.number_crimes_in_pca,
    number_crimes_in_pca_other_crime = n.number_crimes_in_pca_other_crime,
    number_crimes_in_pca_possession_of_weapons = n.number_crimes_in_pca_possession_of_weapons,
    number_crimes_in_pca_criminal_damage_and_arson = n.number_crimes_in_pca_criminal_damage_and_arson,
    number_crimes_in_pca_shoplifting = n.number_crimes_in_pca_shoplifting,
    number_crimes_in_pca_robbery = n.number_crimes_in_pca_robbery,
    number_crimes_in_pca_burglary = n.number_crimes_in_pca_burglary,
    number_crimes_in_pca_public_disorder_and_weapons = n.number_crimes_in_pca_public_disorder_and_weapons,
    number_crimes_in_pca_drugs = n.number_crimes_in_pca_drugs,
    number_crimes_in_pca_other_theft = n.number_crimes_in_pca_other_theft,
    number_crimes_in_pca_violent_crime = n.number_crimes_in_pca_violent_crime,
    number_crimes_in_pca_public_order = n.number_crimes_in_pca_public_order,
    number_crimes_in_pca_violence_and_sexual_offences = n.number_crimes_in_pca_violence_and_sexual_offences,
    number_crimes_in_pca_vehicle_crime = n.number_crimes_in_pca_vehicle_crime,
    number_crimes_in_pca_bicycle_theft = n.number_crimes_in_pca_bicycle_theft,
    number_crimes_in_pca_theft_from_the_person = n.number_crimes_in_pca_theft_from_the_person,
    number_crimes_in_pca_anti_social_behaviour = n.number_crimes_in_pca_anti_social_behaviour
from number_crimes_in_postcode_area n
where c.post_code is not null
and c.post_code <> ''
and c.post_code = n.post_code;
