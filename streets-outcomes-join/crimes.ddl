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
