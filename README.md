# flights-case-study-
# ✈️ SQL Case Study: Flight Data Analysis

## 📌 Overview
This case study explores a real-world flight dataset using advanced SQL techniques — focusing on **time manipulation**, **grouping**, **filtering**, and **derived columns**.

## 📂 Files
- `flights.csv`: Raw dataset
- `flight_case_study.sql`: SQL queries for all 18 business problems
- `insights.md`: Summarized key findings from the analysis

## 📊 Techniques Used
- `STR_TO_DATE`, `DATE_ADD`, `DAYNAME`, `MONTHNAME`, `HOUR()`
- Common Table Expressions (CTEs)
- Conditional Aggregation
- Date Ranges, Time Windows, Duration parsing

## 🚀 Business Questions Solved
1. Which month had most flights?
2. Which weekday had the most expensive flights?
3. Airline-specific monthly traffic
4. Flights between specific hours
5. Weekend flights analysis
6. Arrival time and date calculation
7. Overnight travel detection
8. Quarter-wise analysis
9. Duration-based grouping by city pairs
10. Non-stop overnight flights
11. Longest flights by airline
12. Stop-based duration comparison
13. Time grid frequency and pricing from major cities
# ✈️ Flight Data Case Study – Key Insights

## 1. Monthly Peak
- **Month with most flights**: [MonthName from query]

## 2. Price Peak
- **Weekday with highest average flight price**: [Weekday from query]

## 3. Airline Activity
- **IndiGo** operates the most monthly flights across months.

## 4. Time Specific Travel
- Flights from **Bangalore to Delhi** between **10AM–2PM** are common.

## 5. Weekend Travel
- High number of departures from **Bangalore** on **Saturdays & Sundays**.

## 6–7. Arrival Time & Date
- **Arrival time** is accurately calculated by converting durations and adding to departures.

## 8. Overnight Journeys
- Some flights **depart on one date and arrive the next**, implying long duration or overnight trips.

## 9. Duration Insights
- Average duration between city pairs computed — helpful for route planning.

## 10. Midnight Travelers
- Flights **leaving before midnight and arriving after** are identified for **non-stop routes**.

## 11. Quarter Trends
- **Quarter-wise** distribution of flights per airline shows seasonal traffic.

## 12. Longest Route
- Airline with the **longest average flight time**: [Airline from query].

## 13. Stops vs Duration
- Flights with **stops** take significantly more time on average.

## 14. Date Range Filter
- **Air India** flights from **Delhi** between **1st to 10th March 2019** extracted.

## 15. Max Duration
- **Longest flight** per airline is recorded.

## 16. >3 Hour City Pairs
- City pairs with **avg. duration > 3 hours** identified.

## 17–18. Time Grid
- Grids show **flight frequencies and average prices** by **weekday & time block** from **Delhi and Bangalore**.



## ✅ Tools
- MySQL 8.0+
- Excel (optional for visualization)
