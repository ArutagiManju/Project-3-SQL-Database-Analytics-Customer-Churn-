**Project.3. SQL/Database Analytics: Customer Churn Analysis**

**Project Overview**
Use SQL to extract, aggregate, and analyze customer behavior data to identify churn patterns
and generate actionable business insights. This project develops practical SQL skills for real-
world business intelligence.

**Learning Objectives**
 Write complex SQL queries (joins, subqueries, CTEs)
 Aggregate data using GROUP BY and window functions
 Calculate churn metrics and cohort analysis
 Create views for reusable analysis
 Optimize queries for performance
 Present findings through summary tables

**Dataset Information**
Data Link: Kaggle - Telco Customer Churn

**Expected Tables:**
 Customers (Customer ID, Gender, Tenure, Monthly Charges)
 Services (Customer ID, Internet Service, Phone Service, etc.)
 Billing (Customer ID, Total Charges, Payment Method)
 Churn (Customer ID, Churn)

**Step-by-Step Guidance**
**Phase 1: Database Setup (1 hour)**
1. Create database ‘churn_analysis’.
2. Import CSV files as tables (create those table from existing dataset only)
3. Verify data import
   
**Phase 2: Data Exploration (2 hours)**
1. Understand table structures:
2. Check for NULL values.
3. Identify churn distribution
   
**Phase 3: Churn Metric Calculations**
1. Overall churn rate
2. Churn by tenure cohorts
3. Churn by contract type
   
**Phase 4: Cohort & RFM Analysis**
1. Customer lifetime value (CLV)
2. RFM Segmentation (Recency, Frequency, Monetary)
   
**Phase 5: Insights & Reporting (2 hours)**
1. Create summary views for reporting
2. Generate final insight queries (top reasons for churn, vulnerable segments, etc.)
   
**Deliverables**
 SQL script with all queries documented
 Written insights: churn trends, high-risk segments, recommendations
 Optional: Export results to CSV.

**Tools & Libraries**
MySQL
