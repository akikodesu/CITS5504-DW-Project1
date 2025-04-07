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

---

## Dimensional Model Design

### Dimension Schemas & Concept Hierarchies

1. **Dim_Time**

   - Schema:
     - TimeID(PK): Unique identifier for each time record
     - Month: Month of the year (1-12)
     - Season: Fiscal season (e.g., Winter, Spring)
     - Year: Calendar year (e.g., 2024)

2. **Dim_Date**

   - Schema:
     - DateID(PK): Unique identifier for each calendar date
     - Dayweek: Day of a week (e.g., Monday)
     - Day_of_Week: Day category (Weekday vs. Weekend)

3. **Dim_DaynNight**

   - Schema:
     - TimeofDayID(PK): Unique identifier for each time-of-day record
     - Time: Exact clock time (HH:MM)
     - Hour_Bin: Two-hour grouping (e.g., 06:00-08:00)
     - Time_of_Day: Broad category (Day vs. Night, defined as 06:00–18:00 / 18:00–06:00)

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
     - HolidayID(PK): Unique identifier for each holiday record
     - Christmas_Period: Flag indicating whether the date falls within the Christmas period (Yes/No)
     - Easter_Period: Flag indicating whether the date falls within the Easter period (Yes/No)
     - They are independent Boolean fields and do not sonsitute a concept hierarchy

6. **Dim_Crash**

   - Schema:
     - CrashID(PK): Original crash identifier from source csv file
     - Crash_Type: Classification of crash (e.g., Single vs. Multiple )
     - No concept hierarchy because they are classification type

7. **Dim_Road**

   - Schema:
     - RoadID(PK): Unique identifier for each road record
     - Speed_Limit: Posted speed limit (km/h)
     - Road_Type: Classfication of road (e.g., Local Road, Arterial Road)
     - Both Speed_Limit and Road_Type are flat attributes with no parent-child relationships

8. **Dim_VehicleInvl**

   - Schema:
     - VehicleInvlID(PK): Unique identifier for each vehicle involvement record
     - Bus_Invl: Flag indicating bus involvement (Yes/No)
     - Heavy_Rigid_Truck_Invl: Flag indicating heavy rigid truck involvement (Yes/No)
     - Articulated_Truck_Invl: Flag indicating articulated truck involvement (Yes/No)
     - They are independent Boolean fields and do not sonsitute a concept hierarchy

9. **Dim_Victim**
   - Schema:
     - VictimID(PK): Unique identifier for each victim involvement record
     - Road_User: Role of the individual in the vehicle (e.g., Driver, Passenger)
     - Gender: Individual's gender (e.g., Male, Female)
     - Age_Group: Age category of the individual (e.g., 17_to_25)
     - They are independent attributes with no parent-child relationships among them, and therefore do not from a concept hierarchy.

---

## DW Schema & Fact Table Design

### Fact Table Design

### Business Queries

### StarNet Diagram

---

## Implementation

### ETL & Data Processing

### Schema Creation & Data Loading

---

## Analytics & Visualization

### Business Query Visualizations

### Association Rule Mining Setup

### Interpretation & Suggestions

---

## References
