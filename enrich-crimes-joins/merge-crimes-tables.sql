INSERT INTO crimes_uk_crimes_all
(
	id,
    crime_id,
    month,
    reported_by ,
    falls_within,
    longitude,
    latitude,
    location,
    lsoa_code,
    lsoa_name,
    crime_type,
    last_outcome_category,
    suspect_identified,
    context,
    county,
    outcome_type,
    suspect_identified_outcome,
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
    number_ss_object_evidence,
    number_poi,
    number_poi_community,
    number_poi_food_and_drink,
    number_poi_fuel,
    number_poi_atm,
    number_poi_transport,
    number_poi_motorcycle_dealership,
    number_poi_wifi_hotspot,
    number_poi_shopping_supermarkets,
    number_poi_special_interest,
    number_poi_shopping_others,
    number_poi_banks,
    number_poi_sports_center,
    number_poi_car_dealership,
    number_poi_commercial_site,
    number_poi_association,
    number_poi_car_parts_supplier,
    number_poi_builder_and_diy_supplies,
    number_poi_accommodation,
    number_poi_attraction,
    number_poi_pharmacy,
    number_poi_healthcare,
    number_poi_landmark,
    number_poi_public_service_buildings,
    number_poi_shopping_consumer_electrics,
    number_poi_entertainment,
    number_poi_car_servicing,
    number_poi_building_society,
    number_poi_bookshop,
    number_poi_truck_dealership,
    number_poi_holiday_park,
    number_poi_government_agency,
    number_poi_vehicle_hire,
    number_poi_car_auction,
    number_poi_caravan_dealership,
    number_poi_courier,
    number_poi_estate_agent
)
SELECT
	c.id,
    c.crime_id,
    c.month,
    c.reported_by ,
    c.falls_within,
    c.longitude,
    c.latitude,
    c.location,
    c.lsoa_code,
    c.lsoa_name,
    c.crime_type,
    c.last_outcome_category,
    c.suspect_identified,
    c.context,
    c.county,
    c.outcome_type,
    c.suspect_identified_outcome,
	cs.number_ss,
	cs.number_ss_person_searches,
	cs.number_ss_vehicle_searches,
	cs.number_ss_asian_searches,
	cs.number_ss_black_searches,
	cs.number_ss_white_searches,
	cs.number_ss_outcome_suspect_arrested,
	cs.number_ss_outcome_article_found,
	cs.number_ss_outcome_offender_given_drugs_possession_warning,
	cs.number_ss_outcome_offender_cautioned,
	cs.number_ss_outcome_suspect_summonsed_to_court,
	cs.number_ss_outcome_nothing_found,
	cs.number_ss_outcome_offender_given_penalty_notice,
	cs.number_ss_outcome_local_resolution,
	cs.number_ss_age_under_10,
	cs.number_ss_age_10_17,
	cs.number_ss_age_18_24,
	cs.number_ss_age_25_34,
	cs.number_ss_age_over_34,
	cs.number_ss_object_controlled_drugs,
	cs.number_ss_object_criminal_demage_articles,
	cs.number_ss_object_stolen_goods,
	cs.number_ss_object_weapons,
	cs.number_ss_object_firearms,
	cs.number_ss_object_evidence,
	cp.number_poi,
	cp.number_poi_community,
	cp.number_poi_food_and_drink,
	cp.number_poi_fuel,
	cp.number_poi_atm,
	cp.number_poi_transport,
	cp.number_poi_motorcycle_dealership,
	cp.number_poi_wifi_hotspot,
	cp.number_poi_shopping_supermarkets,
	cp.number_poi_special_interest,
	cp.number_poi_shopping_others,
	cp.number_poi_banks,
	cp.number_poi_sports_center,
	cp.number_poi_car_dealership,
	cp.number_poi_commercial_site,
	cp.number_poi_association,
	cp.number_poi_car_parts_supplier,
	cp.number_poi_builder_and_diy_supplies,
	cp.number_poi_accommodation,
	cp.number_poi_attraction,
	cp.number_poi_pharmacy,
	cp.number_poi_healthcare,
	cp.number_poi_landmark,
	cp.number_poi_public_service_buildings,
	cp.number_poi_shopping_consumer_electrics,
	cp.number_poi_entertainment,
	cp.number_poi_car_servicing,
	cp.number_poi_building_society,
	cp.number_poi_bookshop,
	cp.number_poi_truck_dealership,
	cp.number_poi_holiday_park,
	cp.number_poi_government_agency,
	cp.number_poi_vehicle_hire,
	cp.number_poi_car_auction,
	cp.number_poi_caravan_dealership,
	cp.number_poi_courier,
	cp.number_poi_estate_agent
FROM
	crimes_uk_crimes c
	LEFT JOIN crimes_uk_crimes_with_stop_and_search cs
		ON c.id = cs.crime_id
	LEFT JOIN crimes_uk_crimes_with_poi cp
		ON c.id = cp.crime_id;
        

UPDATE crimes_uk_crimes_all SET number_ss = 0 WHERE number_ss IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_person_searches = 0 WHERE number_ss_person_searches IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_vehicle_searches = 0 WHERE number_ss_vehicle_searches IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_asian_searches = 0 WHERE number_ss_asian_searches IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_black_searches = 0 WHERE number_ss_black_searches IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_white_searches = 0 WHERE number_ss_white_searches IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_suspect_arrested = 0 WHERE number_ss_outcome_suspect_arrested IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_article_found = 0 WHERE number_ss_outcome_article_found IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_offender_given_drugs_possession_warning = 0 WHERE number_ss_outcome_offender_given_drugs_possession_warning IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_offender_cautioned = 0 WHERE number_ss_outcome_offender_cautioned IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_suspect_summonsed_to_court = 0 WHERE number_ss_outcome_suspect_summonsed_to_court IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_nothing_found = 0 WHERE number_ss_outcome_nothing_found IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_offender_given_penalty_notice = 0 WHERE number_ss_outcome_offender_given_penalty_notice IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_outcome_local_resolution = 0 WHERE number_ss_outcome_local_resolution IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_age_under_10 = 0 WHERE number_ss_age_under_10 IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_age_10_17 = 0 WHERE number_ss_age_10_17 IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_age_18_24 = 0 WHERE number_ss_age_18_24 IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_age_25_34 = 0 WHERE number_ss_age_25_34 IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_age_over_34 = 0 WHERE number_ss_age_over_34 IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_object_controlled_drugs = 0 WHERE number_ss_object_controlled_drugs IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_object_criminal_demage_articles = 0 WHERE number_ss_object_criminal_demage_articles IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_object_stolen_goods = 0 WHERE number_ss_object_stolen_goods IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_object_weapons = 0 WHERE number_ss_object_weapons IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_object_firearms = 0 WHERE number_ss_object_firearms IS NULL;
UPDATE crimes_uk_crimes_all SET number_ss_object_evidence = 0 WHERE number_ss_object_evidence IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi = 0 WHERE number_poi IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_community = 0 WHERE number_poi_community IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_food_and_drink = 0 WHERE number_poi_food_and_drink IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_fuel = 0 WHERE number_poi_fuel IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_atm = 0 WHERE number_poi_atm IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_transport = 0 WHERE number_poi_transport IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_motorcycle_dealership = 0 WHERE number_poi_motorcycle_dealership IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_wifi_hotspot = 0 WHERE number_poi_wifi_hotspot IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_shopping_supermarkets = 0 WHERE number_poi_shopping_supermarkets IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_special_interest = 0 WHERE number_poi_special_interest IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_shopping_others = 0 WHERE number_poi_shopping_others IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_banks = 0 WHERE number_poi_banks IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_sports_center = 0 WHERE number_poi_sports_center IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_car_dealership = 0 WHERE number_poi_car_dealership IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_commercial_site = 0 WHERE number_poi_commercial_site IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_association = 0 WHERE number_poi_association IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_car_parts_supplier = 0 WHERE number_poi_car_parts_supplier IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_builder_and_diy_supplies = 0 WHERE number_poi_builder_and_diy_supplies IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_accommodation = 0 WHERE number_poi_accommodation IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_attraction = 0 WHERE number_poi_attraction IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_pharmacy = 0 WHERE number_poi_pharmacy IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_healthcare = 0 WHERE number_poi_healthcare IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_landmark = 0 WHERE number_poi_landmark IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_public_service_buildings = 0 WHERE number_poi_public_service_buildings IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_shopping_consumer_electrics = 0 WHERE number_poi_shopping_consumer_electrics IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_entertainment = 0 WHERE number_poi_entertainment IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_car_servicing = 0 WHERE number_poi_car_servicing IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_building_society = 0 WHERE number_poi_building_society IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_bookshop = 0 WHERE number_poi_bookshop IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_truck_dealership = 0 WHERE number_poi_truck_dealership IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_holiday_park = 0 WHERE number_poi_holiday_park IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_government_agency = 0 WHERE number_poi_government_agency IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_vehicle_hire = 0 WHERE number_poi_vehicle_hire IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_car_auction = 0 WHERE number_poi_car_auction IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_caravan_dealership = 0 WHERE number_poi_caravan_dealership IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_courier = 0 WHERE number_poi_courier IS NULL;
UPDATE crimes_uk_crimes_all SET number_poi_estate_agent = 0 WHERE number_poi_estate_agent IS NULL;
