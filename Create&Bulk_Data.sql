CREATE TABLE dim_time (
    time_id SERIAL PRIMARY KEY,
    year INT,
    month INT,
    season VARCHAR(20)
);

CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    dayweek VARCHAR(20),
    day_of_week VARCHAR(20)
);

CREATE TABLE dim_daynight (
    time_of_day_id SERIAL PRIMARY KEY,
    time VARCHAR(10),
    time_bin VARCHAR(20),
    time_of_day VARCHAR(20)
);

CREATE TABLE dim_vehicle_invl (
    vehicle_invl_id SERIAL PRIMARY KEY,
    bus_involvement BOOLEAN,
    heavy_rigid_truck_involvement BOOLEAN,
    articulated_truck_involvement BOOLEAN
);

CREATE TABLE dim_crash (
    crash_dim_id SERIAL PRIMARY KEY,
    crash_id INT,
    crash_type VARCHAR(20)
);

CREATE TABLE dim_holiday (
    holiday_id SERIAL PRIMARY KEY,
    christmas_period BOOLEAN,
    easter_period BOOLEAN
);

CREATE TABLE dim_road (
    road_id SERIAL PRIMARY KEY,
    speed_limit INT,
    national_road_type VARCHAR(50)
);

CREATE TABLE dim_state_aging_level (
    population_age_id SERIAL PRIMARY KEY,
    state VARCHAR(10),
    population_structure_2023 VARCHAR(30),
    abs_pct_65_plus_group_2023 VARCHAR(30)
);

CREATE TABLE dim_victim (
    victim_type_id SERIAL PRIMARY KEY,
    gender VARCHAR(20),
    age_group VARCHAR(20),
    road_user VARCHAR(50)
);

CREATE TABLE fact_fatalities (
    fatality_id SERIAL PRIMARY KEY,
    age FLOAT,
    time_id INT REFERENCES dim_time(time_id),
    date_id INT REFERENCES dim_date(date_id),
    time_of_day_id INT REFERENCES dim_daynight(time_of_day_id),
    vehicle_invl_id INT REFERENCES dim_vehicle_invl(vehicle_invl_id),
    crash_dim_id INT REFERENCES dim_crash(crash_dim_id),
    holiday_id INT REFERENCES dim_holiday(holiday_id),
    road_id INT REFERENCES dim_road(road_id),
    population_age_id INT REFERENCES dim_state_aging_level(population_age_id),
    victim_type_id INT REFERENCES dim_victim(victim_type_id),
    is_young INT,
    is_general INT,
    is_senior INT
);

COPY dim_crash (crash_dim_id, crash_id, crash_type )
FROM '/private/tmp/5504project1-tables/dim_crash.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_crash;

COPY dim_date (date_id, dayweek, day_of_week )
FROM '/private/tmp/5504project1-tables/dim_date.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_date;

COPY dim_daynight (time_of_day_id, time, time_bin, time_of_day)
FROM '/private/tmp/5504project1-tables/dim_daynight.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_daynight;

COPY dim_holiday (holiday_id, christmas_period, easter_period)
FROM '/private/tmp/5504project1-tables/dim_holiday.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_holiday;

COPY dim_road (road_id, speed_limit, national_road_type)
FROM '/private/tmp/5504project1-tables/dim_road.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_road;

COPY dim_state_aging_level (population_age_id, state, population_structure_2023, abs_pct_65_plus_group_2023)
FROM '/private/tmp/5504project1-tables/dim_state_aging_level.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_state_aging_level

COPY dim_time (time_id, year, month, season)
FROM '/private/tmp/5504project1-tables/dim_time.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_time;

COPY dim_vehicle_invl (vehicle_invl_id, bus_involvement, heavy_rigid_truck_involvement, articulated_truck_involvement)
FROM '/private/tmp/5504project1-tables/dim_vehicle_invl.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_vehicle_invl;

COPY dim_victim (victim_type_id, gender, age_group, road_user)
FROM '/private/tmp/5504project1-tables/dim_victim.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dim_victim;

COPY fact_fatalities (
  	fatality_id,
    age,
    time_id,
    date_id,
    time_of_day_id,
    vehicle_invl_id,
    crash_dim_id,
    holiday_id,
    road_id,
    population_age_id,
    victim_type_id,
 	is_young,
    is_general,
    is_senior
)
FROM '/private/tmp/5504project1-tables/fact_fatalities.csv'
DELIMITER ',' 
CSV HEADER;

SELECT * FROM fact_fatalities;