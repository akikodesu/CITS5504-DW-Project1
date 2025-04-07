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

This report leverages three datasets sourced from a government open-data portal:（要引用）

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

   - Schema: TimeID(Primary Key), Month, Season, Year
     ![concept hierarchy](/Users/akiko/Desktop/CITS5504-DW-Project1/Dim_Time.png)

2. **Dim_Date**

   - Schema: DateID(Primary Key), Dayweek, Day_of_Week
     ![concept hierarchy](/Users/akiko/Desktop/CITS5504-DW-Project1/Dim_Date.png)

3. **Dim_DaynNight**

   - Schema: TimeofDayID(Primary Key), Time, Hour_Bin, Time_of_Day
     ![concept hierarchy](/Users/akiko/Desktop/CITS5504-DW-Project1/Dim_TimeofDay.png)

4. **Dim_Density**

   - Schema: DensityID(Primary Key), Capital_City, State
     ![concept hierarchy](/Users/akiko/Desktop/CITS5504-DW-Project1/Dim_Density.png)

5. **Dim_Holiday**

   - Schema: HolidayID(Primary Key), Christmas_Period, Easter_Period

6. **Dim_Crash**
   - Schema: CrashID(original ID，not increment field, primary key), Crash_Type
7. **Dim_Road**
   - Schema: RoadID(Primary Key), Speed_Limit, Road_Type
8. **Dim_Vehicle**

- Schema: VehicleID(Primary Key), Bus_Invl, Heavy_Rigid_Truck, Articulated_Truck
-

### StarNet Diagram

### Business Queries

---

## Implementation

### Data Warehouse Schema & Fact Table Design

### ETL & Data Processing

### Schema Creation & Data Loading

---

## Analytics & Visualization

### Business Query Visualizations

### Association Rule Mining Setup

### Interpretation & Suggestions

---

## References
