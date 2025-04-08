-- Q1 --
SELECT 
    s.state,
    t.season,
    COUNT(*) AS total_fatalities
FROM fact_fatalities ff
JOIN dim_daynight d ON ff.time_of_day_id = d.time_of_day_id
JOIN dim_time t ON ff.time_id = t.time_id
JOIN dim_state_aging_level s ON ff.population_age_id = s.population_age_id
WHERE d.time_of_day ILIKE '%night%'
GROUP BY s.state, t.season
ORDER BY s.state, t.season;

-- Q2 --
SELECT 
    c.crash_type,
    v.age_group,
    COUNT(*) AS total_fatalities
FROM fact_fatalities ff
JOIN dim_crash c ON ff.crash_dim_id = c.crash_dim_id
JOIN dim_victim v ON ff.victim_type_id = v.victim_type_id
GROUP BY c.crash_type, v.age_group
ORDER BY c.crash_type, v.age_group;

-- Q3 -- 
SELECT 
    d.time_bin,
    v.bus_involvement,
    COUNT(*) AS fatalities_count
FROM fact_fatalities ff
JOIN dim_daynight d ON ff.time_of_day_id = d.time_of_day_id
JOIN dim_vehicle_invl v ON ff.vehicle_invl_id = v.vehicle_invl_id
GROUP BY d.time_bin, v.bus_involvement
ORDER BY d.time_bin, v.bus_involvement;

-- Q4 --
SELECT 
    r.national_road_type,
    h.christmas_period,
    COUNT(*) AS fatality_count
FROM fact_fatalities ff
JOIN dim_road r ON ff.road_id = r.road_id
JOIN dim_holiday h ON ff.holiday_id = h.holiday_id
GROUP BY r.national_road_type, h.christmas_period
ORDER BY r.national_road_type, h.christmas_period;
-- Q5 --
SELECT 
    s.state,
    s.abs_pct_65_plus_group_2023,
    COUNT(*) AS fatality_count
FROM fact_fatalities ff
JOIN dim_time t ON ff.time_id = t.time_id
JOIN dim_state_aging_level s ON ff.population_age_id = s.population_age_id
WHERE t.year = 2023
GROUP BY s.state, s.abs_pct_65_plus_group_2023
ORDER BY s.state;
