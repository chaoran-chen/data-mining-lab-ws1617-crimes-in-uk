CREATE TABLE crimes_uk_stop_and_search
(
    id INT AUTO_INCREMENT NOT NULL,
    type VARCHAR(40),
    date DATETIME,
    part_of_a_policing_operation VARCHAR(10),
    policing_operation TEXT,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    gender VARCHAR(10),
    age_range VARCHAR(10),
    self_defined_ethnicity TEXT,
    officer_defined_ethnicity VARCHAR(20),
    legislation TEXT,
    object_of_search TEXT,
    outcome VARCHAR(70),
    outcome_linked_to_object_of_search VARCHAR(10),
    removal_of_more_than_just_outer_clothing VARCHAR(10),
    county VARCHAR(30),
    PRIMARY KEY(id)
);

CREATE TABLE crimes_uk_streets
(
    id INT AUTO_INCREMENT NOT NULL,
    crime_id VARCHAR(80),
    month DATE,
    reported_by VARCHAR(40),
    falls_within VARCHAR(40),
    longitude DECIMAL(11,8),
    latitude DECIMAL(10,8),
    location VARCHAR(70),
    lsoa_code VARCHAR(10),
    lsoa_name VARCHAR(40),
    crime_type VARCHAR(40),
    last_outcome_category VARCHAR(70),
    suspect_identified VARCHAR(40),
    context TEXT,
    county VARCHAR(30),
    PRIMARY KEY(id)
);

CREATE TABLE crimes_uk_outcomes
(
    id INT AUTO_INCREMENT NOT NULL,
    crime_id VARCHAR(80),
    month DATE,
    county VARCHAR(30),
    reported_by VARCHAR(40),
    falls_within VARCHAR(40),
    longitude DECIMAL(11,8),
    latitude DECIMAL(10,8),
    location VARCHAR(70),
    lsoa_code VARCHAR(10),
    lsoa_name VARCHAR(40),
    outcome_type VARCHAR(70),
    suspect_identified VARCHAR(40),
    PRIMARY KEY(id)
);

CREATE TABLE crimes_uk_crimes
(
    id INT AUTO_INCREMENT NOT NULL,
    crime_id VARCHAR(80),
    month DATE,
    reported_by VARCHAR(40),
    falls_within VARCHAR(40),
    longitude DECIMAL(11,8),
    latitude DECIMAL(10,8),
    location VARCHAR(70),
    lsoa_code VARCHAR(10),
    lsoa_name VARCHAR(40),
    crime_type VARCHAR(40),
    last_outcome_category VARCHAR(70),
    suspect_identified VARCHAR(40),
    context TEXT,
    county VARCHAR(30),
    outcome_type VARCHAR(70),
    suspect_identified_outcome VARCHAR(40),
    PRIMARY KEY(id)
);

CREATE TABLE crimes_uk_poi
(
    id INT AUTO_INCREMENT NOT NULL,
    category VARCHAR(40),
    poi VARCHAR(60),
    longitude DECIMAL(11,8),
    latitude DECIMAL(10,8),
    address TEXT,
    description TEXT,
    PRIMARY KEY(id)
);

create table crimes_uk_crimes_with_stop_and_search (
    crime_id INT,
    number_ss INT,
    number_ss_person_searches INT,
    number_ss_vehicle_searches INT,
    number_ss_asian_searches INT,
    number_ss_black_searches INT,
    number_ss_white_searches INT,
    number_ss_outcome_suspect_arrested INT,
    number_ss_outcome_article_found INT,
    number_ss_outcome_offender_given_drugs_possession_warning INT,
    number_ss_outcome_offender_cautioned INT,
    number_ss_outcome_suspect_summonsed_to_court INT,
    number_ss_outcome_nothing_found INT,
    number_ss_outcome_offender_given_penalty_notice INT,
    number_ss_outcome_local_resolution INT,
    number_ss_age_under_10 INT,
    number_ss_age_10_17 INT,
    number_ss_age_18_24 INT,
    number_ss_age_25_34 INT,
    number_ss_age_over_34 INT,
    number_ss_object_controlled_drugs INT,
    number_ss_object_criminal_demage_articles INT,
    number_ss_object_stolen_goods INT,
    number_ss_object_weapons INT,
    number_ss_object_firearms INT,
    number_ss_object_evidence INT
);

create table crimes_uk_crimes_with_poi
(
    crime_id INT,
    number_poi INT,
    number_poi_community INT,
    number_poi_food_and_drink INT,
    number_poi_fuel INT,
    number_poi_atm INT,
    number_poi_transport INT,
    number_poi_motorcycle_dealership INT,
    number_poi_wifi_hotspot INT,
    number_poi_shopping_supermarkets INT,
    number_poi_special_interest INT,
    number_poi_shopping_others INT,
    number_poi_banks INT,
    number_poi_sports_center INT,
    number_poi_car_dealership INT,
    number_poi_commercial_site INT,
    number_poi_association INT,
    number_poi_car_parts_supplier INT,
    number_poi_builder_and_diy_supplies INT,
    number_poi_accommodation INT,
    number_poi_attraction INT,
    number_poi_pharmacy INT,
    number_poi_healthcare INT,
    number_poi_landmark INT,
    number_poi_public_service_buildings INT,
    number_poi_shopping_consumer_electrics INT,
    number_poi_entertainment INT,
    number_poi_car_servicing INT,
    number_poi_building_society INT,
    number_poi_bookshop INT,
    number_poi_truck_dealership INT,
    number_poi_holiday_park INT,
    number_poi_government_agency INT,
    number_poi_vehicle_hire INT,
    number_poi_car_auction INT,
    number_poi_caravan_dealership INT,
    number_poi_courier INT,
    number_poi_estate_agent INT
);
