COPY dim_crash (crash_dim_id, crash_id, crash_type )
FROM '/private/tmp/5504project1-tables/dim_crash.csv'
DELIMITER ','
CSV HEADER;

COPY dim_date (date_id, dayweek, day_of_week )
FROM '/private/tmp/5504project1-tables/dim_date.csv'
DELIMITER ','
CSV HEADER;

COPY dim_daynight (time_of_day_id, time, time_bin, time_of_day)
FROM '/private/tmp/5504project1-tables/dim_daynight.csv'
DELIMITER ','
CSV HEADER;

COPY dim_holiday (holiday_id, christmas_period, easter_period)
FROM '/private/tmp/5504project1-tables/dim_holiday.csv'
DELIMITER ','
CSV HEADER;

COPY dim_road (road_id, speed_limit, national_road_type)
FROM '/private/tmp/5504project1-tables/dim_road.csv'
DELIMITER ','
CSV HEADER;

COPY dim_state_aging_level (population_age_id, state, population_structure_2023, abs_pct_65_plus_group_2023)
FROM '/private/tmp/5504project1-tables/dim_state_aging_level.csv'
DELIMITER ','
CSV HEADER;

COPY dim_time (time_id, year, month, season)
FROM '/private/tmp/5504project1-tables/dim_time.csv'
DELIMITER ','
CSV HEADER;

COPY dim_vehicle_invl (vehicle_invl_id, bus_involvement, heavy_rigid_truck_involvement, articulated_truck_involvement)
FROM '/private/tmp/5504project1-tables/dim_vehicle_invl.csv'
DELIMITER ','
CSV HEADER;

COPY dim_victim (victim_type_id, gender, age_group, road_user)
FROM '/private/tmp/5504project1-tables/dim_victim.csv'
DELIMITER ','
CSV HEADER;

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