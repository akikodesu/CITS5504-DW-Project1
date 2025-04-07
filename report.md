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
     - timeid(PK): Unique identifier for each time record
     - month: Month of the year (1-12)
     - season: Fiscal season (e.g., Winter, Spring)
     - year: Calendar year (e.g., 2024)

2. **Dim_Date**

   - Schema:
     - dateid(PK): Unique identifier for each calendar date
     - dayweek: Day of a week (e.g., Monday)
     - day_of_week: Day category (Weekday vs. Weekend)

3. **Dim_DaynNight**

   - Schema:
     - timeofdayid(PK): Unique identifier for each time-of-day record
     - time: Exact clock time (HH:MM)
     - hour_bin: Two-hour grouping (e.g., 06:00-08:00)
     - time_of_day: Broad category (Day vs. Night, defined as 06:00–18:00 / 18:00–06:00)

4. **Dim_Density**

   - Schema:
     - DensityID(PK): Unique identifier for each density record
     - Capital_City: Name of the capital city
     - State: State in which the capital city resides
     - No_density_ratio(%): Percentage of the state’s total area with zero population density
     - Low_density_ratio(%): Percentage of the state’s total area with low population density
     - Medium_density_ratio(%): Percentage of the state’s total area with medium population density
     - High_density_ratio(%): Percentage of the state’s total area with high population density
     - Total_Area(km^2): Total areas of the state

5. **Dim_Holiday**

   - Schema:
     - holidayid(PK): Unique identifier for each holiday record
     - christmas_period: Flag indicating whether the date falls within the Christmas period (Yes/No)
     - easter_period: Flag indicating whether the date falls within the Easter period (Yes/No)
     - They are independent Boolean fields and do not sonsitute a concept hierarchy

6. **Dim_Crash**

   - Schema:
     - crashid(PK): Original crash identifier from source csv file
     - crash_type: Classification of crash (e.g., Single vs. Multiple )
     - No concept hierarchy because they are classification type

7. **Dim_Road**

   - Schema:
     - roadid(PK): Unique identifier for each road record
     - speed_limit: Posted speed limit (km/h)
     - road_type: Classfication of road (e.g., Local Road, Arterial Road)
     - Both speed_limit and road_type are flat attributes with no parent-child relationships

8. **Dim_VehicleInvl**

   - Schema:
     - vehicleinvlid(PK): Unique identifier for each vehicle involvement record
     - bus_invl: Flag indicating bus involvement (Yes/No)
     - heavy_rigid_truck_invl: Flag indicating heavy rigid truck involvement (Yes/No)
     - articulated_truck_invl: Flag indicating articulated truck involvement (Yes/No)
     - They are independent Boolean fields and do not sonsitute a concept hierarchy

9. **Dim_Victim**
   - Schema:
     - victimid(PK): Unique identifier for each victim involvement record
     - road_user: Role of the individual in the vehicle (e.g., Driver, Passenger)
     - gender: Individual's gender (e.g., Male, Female)
     - age_group: Age category of the individual (e.g., 17_to_25)
     - They are independent attributes with no parent-child relationships among them, and therefore do not from a concept hierarchy.

---

## DW Schema & Fact Table Design

### Fact Table Design

1. **Table name and Grain**
   - Name: Fact_Fatality
   - Grain Definition: ""
2. **Schema**
3. **Reasons**

### Business Queries

1. 在不同季节的夜间时段，各州死亡人数的死亡人数分布如何？

2. 不同事故类型下，各年龄组的死亡人数分布如何？（用 fact table 里的年龄组）

3. 每日两小时时段（Hour_Bin）内，按是否涉及公交车（Bus_Invl）划分的死亡人数分布如何？

4. 在圣诞节期间与非圣诞节期间，不同道路类型（Road_Type）和公交车参与情况（Bus_Invl）下的死亡人数有何差异？比如：是否在高速公路上圣诞节期间由于客流量增加，涉及公交车的事故死亡人数显著上升？

### StarNet Diagram

---

## Implementation

### ETL & Data Processing

### Schema Creation & Data Loading

### 所有维度表和事实表塞进 postgresql 中生成了 erd 图

## Analytics & Visualization

### Business Query Visualizations

### Association Rule Mining Setup

### Interpretation & Suggestions

---

## References
