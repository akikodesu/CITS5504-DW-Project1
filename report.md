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

1. Dim_Time
   Month Season Year
   Schema:
2. Dim_Date
   Dayweek Day_of_Week
3. Dim_TimeofDay
   Time Hour_bin Time_of_Day
4. Dim_Density
   Capital_City State
5. Dim_Holiday
   boolean
6. Dim_Crash
7. Dim_Road
8. Dim_Vehicle
   bollean

### StarNet Diagram & Query Capabilities

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
