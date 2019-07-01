CREATE OR REPLACE TABLE zipcodes (
    zipcode int 
  , latitude float
  , longitude float
  , city_name string
  , state_id string
  , state_name string
  , zcta boolean 
  , population int
  , density_estimate float
  , county_fips int
  , county_name string
  , timezone string
)
COPY GRANTS
; 