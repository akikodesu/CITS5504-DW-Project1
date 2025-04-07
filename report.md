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

1. **Dim_Time**

   - Schema:
     - **timeid(PK)**: unique identifier for each time record
     - **month**: enables detailed monthly trend analysis and seasonal comparisons
     - **season**: facilitates quarterly reports and seasonal pattern detection
     - **year**: provides the top-level time granularity for long-term trend analysis and aligns with annual reporting cycles
   - Concept Hierarchy:

2. **Dim_Date**

   - Schema:
     - **dateid(PK)**: unique identifier for each calendar date
     - **dayweek**: patterns for each day
     - **day_of_week**: show markedly different traffic and accident profiles
   - Concept Hierarchy:

3. **Dim_DaynNight**

   - Schema:
     - **timeofdayid(PK)**: unique identifier for each time-of-day record
     - **time**: Allows pinpointing the precise occurrence of accidents for detailed temporal analysis
     - **hour_bin**: balances granularity and usability by grouping times into manageable intervals—this helps reveal patterns like “peak accident windows” without overwhelming users with 1‑minute resolution
     - **time_of_day**: captures broad diurnal differences in traffic conditions and visibility, supporting quick comparisons between daytime and nighttime risk
   - Concept Hierarchy:

4. **Dim_Density**还没定下来

   - Schema:
     - DensityID(PK): unique identifier for each density record
     - Capital_City: Name of the capital city
     - State: State in which the capital city resides

5. **Dim_Holiday**

   - Schema:
     - **holidayid(PK)**: Unique identifier for each holiday record
     - **christmas_period**: captures heightened travel and traffic volumes during the festive season, when accident patterns often change
     - **easter_period**: marks another major holiday with increased road usage and unique risk factors
   - Concept Hierarchy:
     - They are independent Boolean fields and do not sonsitute a concept hierarchy.

6. **Dim_Crash**

   - Schema:
     - **crashid(PK)**: original crash identifier from source csv file
     - **crash_type**: differentiates accident scenarios by their complexity and severity, enabling analysis of how single‑vehicle versus multi‑vehicle incidents impact fatality outcomes
   - Concept Hierarchy:
     - No concept hierarchy because they are classification type.

7. **Dim_Road**

   - Schema:
     - **roadid(PK)**: unique identifier for each road record
     - **speed_limit**: reflects the designed maximum travel speed, which correlates strongly with crash severity and fatality risk
     - **road_type**: captures the functional role and typical traffic volume of the roadway, allowing comparison of safety outcomes across different road environments
   - Concept Hierarchy:
     - Both speed_limit and road_type are flat attributes with no parent-child relationships.

8. **Dim_VehicleInvl**

   - Schema:
     - **vehicleinvlid(PK)**: unique identifier for each vehicle involvement record
     - **bus_invl**: identifies accidents involving buses, which may carry multiple passengers and pose unique risk profiles due to vehicle size and passenger load
     - **heavy_rigid_truck_invl**: highlights collisions with heavy rigid trucks, where vehicle mass and momentum significantly increase fatality likelihood
     - **articulated_truck_invl**: marks incidents involving articulated trucks, which have extended length and reduced maneuverability, often leading to severe crash outcomes.
   - Concept Hierarchy:
     - They are independent Boolean fields and do not sonsitute a concept hierarchy.

9. **Dim_Victim**
   - Schema:
     - **victimid(PK)**: unique identifier for each victim involvement record
     - **road_user**: Role of the individual in the vehicle (e.g., Driver, Passenger)
     - **gender**: Individual's gender (e.g., Male, Female)
     - **age_group**: Age category of the individual (e.g., 17_to_25)
   - Concept Hierarchy:
     - They are independent attributes with no parent-child relationships among them, and therefore do not from a concept hierarchy.

---

## DW Schema & Fact Table Design

### Fact Table Design

1. **Table name and Grain**
   - Name: Fact_Fatality
   - Grain Definition: "One row represents a single fatality event in the fact table, linking a specific victim to the corresponding time, date, day/night period, holiday, crash, road segment, and vehicle involvement dimensions, and including demographic and derived age‑group flags."
2. **Schema**
   | Fields | Description |
   | ---------- | -------------- |
   | fatality | incremental, PK of the fact table |
   | timeid | incremental, FK of the Dim_Time |
   | dateid | incremental, FK of the Dim_Date |
   | timeofdayid | incremental, FK of the Dim_DaynNight |
   | 空着 | incremental, FK of the Dim |
   | holidyid | incremental, FK of the Dim_Holiday |
   | crashid | incremental, FK of the Dim_Crash |
   | roadid | incremental, FK of the Dim_Road |
   | vehicleinvlid | incremental, FK of the Dim_VehichleInvl |
   | victimid | incremental, FK of the Dim_Victim |
   | age | from original csv file |
   | is_senior(=>65) | derived, enable fast and consistent age-group filtering and aggregation without repetitive range logic |
   | is_general(25-65) | derived, enable fast and consistent age-group filtering and aggregation without repetitive range logic |
   | is_young(18<=age<=25) | derived, enable fast and consistent age-group filtering and aggregation without repetitive range logic |

### Business Queries

Based on our fact and dimension tables, we can ask the following five business questions:

1. How are fatalities distributed across states during nighttime hours in different seasons?在不同季节的夜间时段，各州死亡人数的死亡人数分布如何？

2. How are fatalities distributed among age groups for each crash type?不同事故类型下，各年龄组的死亡人数分布如何？

3. Within each two-hour time bin, how do fatalities compare between involving buses and those without bus involvement? 每日两小时时段（Hour_Bin）内，按是否涉及公交车（Bus_Invl）划分的死亡人数分布如何？

4. During the Christmas period versus non-Christmas periods, how do fatalities differ by road type and bus involvement? 在圣诞节期间与非圣诞节期间，不同道路类型（Road_Type）和公交车参与情况（Bus_Invl）下的死亡人数有何差异？比如：是否在高速公路上圣诞节期间由于客流量增加，涉及公交车的事故死亡人数显著上升？

### StarNet Diagram

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
