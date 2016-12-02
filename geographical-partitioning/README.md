#### Load Information about Postcodes

1. Download dataset from [data.gov.uk](https://data.gov.uk/dataset/national-statistics-postcode-lookup-uk/resource/3206f3b9-854a-46ec-8fd2-a6823e836b65).
2. COPY post_codes FROM 'National_Statistics_Postcode_Lookup_UK.csv' DELIMITER ',' CSV HEADER;
3. Execute [insert_post_codes.sql](insert_post_codes.sql).
