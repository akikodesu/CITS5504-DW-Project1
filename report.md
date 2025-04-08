# Data Warehousing Project 1

| Name       | Student Number |
| ---------- | -------------- |
| Wendy Wang | 23904899       |
| Xiang Li   | 23921151       |

---

## Introduction

### Background and Objectives

Traffic-accident analysis plays a critical role in enhancing public safety, reducing economic losses, and guiding evidence-based policymaking.

The primary goals of this project are two fold. First, we aim to **design and implement a data warehouse** that supports fast, flexible querying across multiple dimensions. Second, we will **apply association-rule mining techniques** to uncover hidden patterns that link environmental conditions, vehicle characteristics, and human factors to specific types of road-user outcomes. The ultimate objective is to **translate these findings into concrete recommendations** for improving road-safety policies and interventions.

### Dataset Description

This report leverages three datasets sourced from a government open-data portal:

1. bitre_fatal_crashes_dec2024.xlsx
   - provides a macro-level view of where and when fatal accidents occur.
2. bitre_fatalities_dec2024.xlsx
   - enables analysis of how demographic and situational factors influence accident outcomes.
3. Total area (km²) in population density classes by capital city.csv
   - presents the total land area (in km²) of each Australian capital city categorized by population density classes (people per square kilometre)

### Overall Architecture

This data warehouse employs a **star schema**, consisting of one fact table **(Fact_Fatality)** and nine dimension tables. Each dimension **(Dim_Time, Dim_Date, Dim_DaynNight, Dim_Density, Dim_Holiday, Dim_Crash, Dim_Road, Dim_VehicleInvl, Dim_Victim)** is directly linked to the fat table via foreign keys, enabling multidimensional analysis and rapid aggregation.

---

## Dimensional Model Design

### Dimension Schemas & Concept Hierarchies

1. **dim_time**

   - Schema:
     - **time_id(PK)**: unique identifier for each time record
     - **month**: enables detailed monthly trend analysis and seasonal comparisons
     - **season**: facilitates quarterly reports and seasonal pattern detection
     - **year**: provides the top-level time granularity for long-term trend analysis and aligns with annual reporting cycles
   - Concept Hierarchy:

2. **dim_date**

   - Schema:
     - **date_id(PK)**: unique identifier for each calendar date
     - **dayweek**: patterns for each day
     - **day_of_week**: show markedly different traffic and accident profiles
   - Concept Hierarchy:

3. **dim_daynight**

   - Schema:
     - **time_of_day_id(PK)**: unique identifier for each time-of-day record
     - **time**: Allows pinpointing the precise occurrence of accidents for detailed temporal analysis
     - **time_bin**: balances granularity and usability by grouping times into manageable intervals—this helps reveal patterns like “peak accident windows” without overwhelming users with 1‑minute resolution
     - **time_of_day**: captures broad diurnal differences in traffic conditions and visibility, supporting quick comparisons between daytime and nighttime risk
   - Concept Hierarchy:

4. **dim_state_aging_level**

   - Schema:
     - **population_age_id**(PK): unique identifier for each state's population information
     - **state**: provides geographical context to associate demographic data with specific regions
     - **population_structure_2023**: offers up-to-date overall population statistics to serve as a baseline for comparative analysis with traffic and fatality data
     - **abs_pct_65_plus_group_2023**: indicates the proportion of the population aged 65 and above, enabling targeted analysis of the elderly group’s vulnerability and risk in traffic incidents
   - Concept Hierarchy:
     - dsfsfsv

5. **dim_holiday**

   - Schema:
     - **holiday_id(PK)**: unique identifier for each holiday record
     - **christmas_period**: captures heightened travel and traffic volumes during the festive season, when accident patterns often change
     - **easter_period**: marks another major holiday with increased road usage and unique risk factors
   - Concept Hierarchy:
     - They are independent Boolean fields and do not sonsitute a concept hierarchy.

6. **dim_crash**

   - Schema:
     - **crash_dim_id**: unique identifier for each crash record
     - **crash_id**: original crash identifier from source csv file
     - **crash_type**: differentiates accident scenarios by their complexity and severity, enabling analysis of how single‑vehicle versus multi‑vehicle incidents impact fatality outcomes
   - Concept Hierarchy:
     - No concept hierarchy because they are classification type.

7. **dim_road**

   - Schema:
     - **road_id(PK)**: unique identifier for each road record
     - **speed_limit**: reflects the designed maximum travel speed, which correlates strongly with crash severity and fatality risk
     - **road_type**: captures the functional role and typical traffic volume of the roadway, allowing comparison of safety outcomes across different road environments
   - Concept Hierarchy:
     - Both speed_limit and road_type are flat attributes with no parent-child relationships.

8. **dim_vehicle_invl**

   - Schema:
     - **vehicleinvlid(PK)**: unique identifier for each vehicle involvement record
     - **bus_invl**: identifies accidents involving buses, which may carry multiple passengers and pose unique risk profiles due to vehicle size and passenger load
     - **heavy_rigid_truck_invl**: highlights collisions with heavy rigid trucks, where vehicle mass and momentum significantly increase fatality likelihood
     - **articulated_truck_invl**: marks incidents involving articulated trucks, which have extended length and reduced maneuverability, often leading to severe crash outcomes.
   - Concept Hierarchy:
     - They are independent Boolean fields and do not sonsitute a concept hierarchy.

9. **dim_victim**
   - Schema:
     - **victim_type_id(PK)**: unique identifier for each victim involvement record
     - **road_user**: role of the individual in the vehicle (e.g., Driver, Passenger)
     - **gender**: describes individual's gender
     - **age_group**: age category of the individual (e.g., 17_to_25)
   - Concept Hierarchy:
     - They are independent attributes with no parent-child relationships among them, and therefore do not from a concept hierarchy.

---

## DW Schema & Fact Table Design

### Fact Table Design

1. **Table name and Grain**
   - Name: fact_fatality
   - Grain Definition: "One row represents a single fatality event in the fact table, linking a specific victim to the corresponding time, date, day/night period, holiday, crash, road segment, and vehicle involvement dimensions, and including demographic and derived age‑group flags."
2. **Schema**
   | Fields | Description |
   | ---------- | -------------- |
   | fatality_id | incremental, PK of the fact table |
   | time_id | incremental, FK of the dim_time |
   | date_id | incremental, FK of the dim_date |
   | time_of_day_id | incremental, FK of the dim_daynight |
   | population_age_id | incremental, FK of the dim_state_aging_level |
   | holiday_id | incremental, FK of the Dim_Holiday |
   | crash_dim_id | incremental, FK of the Dim_Crash |
   | road_id | incremental, FK of the Dim_Road |
   | vehicle_invl_id | incremental, FK of the Dim_VehichleInvl |
   | victim_id | incremental, FK of the Dim_Victim |
   | age | from original csv file |
   | is_senior(=>65) | derived, enable fast and consistent age-group filtering and aggregation without repetitive range logic |
   | is_general(25-65) | derived, enable fast and consistent age-group filtering and aggregation without repetitive range logic |
   | is_young(18<=age<=25) | derived, enable fast and consistent age-group filtering and aggregation without repetitive range logic |

### Business Questions

Based on our fact and dimension tables, we can ask the following five business questions:

Q1. How are fatalities distributed across states during nighttime hours in different seasons?
适合填充地图 choropleth map
Q2. How are fatalities distributed among age groups for each crash type?
堆积条形图或分组条形图 stacked/grouped bar chart or treemap
Q3. Within each two-hour time bin, how do fatalities compare between involving buses and those without bus involvement?
分组树状图 clustered/grouped bar chart
Q4. How do fatality counts by road type differ during the Christmas period compared to non-Christmas periods?
grouped bar chart
Q5. How are fatality counts in 2023 distributed across states with varying percentages of the population aged 65 and above?
散点图 scatter plot

### StarNet Diagram

Q1. Select
Q2.
Q3.
Q4.
Q5.

---

## Implementation

### ETL & Data Processing

### Schema Creation & Data Loading

所有维度表和事实表塞进 postgresql 中生成了 erd 图

## Analytics & Visualization

### Business Query Visualizations

### Association Rule Mining Setup

### Interpretation & Suggestions

---

## References
