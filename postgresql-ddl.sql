CREATE TABLE crimes_uk_stop_and_search
(
    id SERIAL NOT NULL,
    type VARCHAR(40),
    date TIMESTAMP,
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
    id SERIAL NOT NULL,
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
    id SERIAL NOT NULL,
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
    id SERIAL NOT NULL,
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
    id SERIAL NOT NULL,
    category VARCHAR(40),
    poi VARCHAR(60),
    longitude DECIMAL(11,8),
    latitude DECIMAL(10,8),
    address TEXT,
    description TEXT,
    PRIMARY KEY(id)
);
