-- =========================================
-- Customer Churn KPI Analysis
-- Author: Data Analyst Portfolio Project
-- Purpose: Business-level KPI extraction for churn analysis
-- =========================================

-- =========================================
-- 1. Overall Churn Rate
-- =========================================
-- This shows the percentage of customers who have churned
-- Core KPI for executive dashboards

SELECT 
    ROUND(AVG(churn_flag) * 100, 2) AS overall_churn_rate_percent
FROM telco_churn.customer_churn;


-- =========================================
-- 2. Churn by Contract Type
-- =========================================
-- Identifies which contract types are most risky
-- Key insight: month-to-month usually has highest churn

SELECT 
    contract,
    COUNT(*) AS total_customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_percent
FROM telco_churn.customer_churn
GROUP BY contract
ORDER BY churn_rate_percent DESC;


-- =========================================
-- 3. Churn by Payment Method
-- =========================================
-- Shows behavioral impact of payment type on churn

SELECT 
    paymentmethod,
    COUNT(*) AS total_customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_percent
FROM telco_churn.customer_churn
GROUP BY paymentmethod
ORDER BY churn_rate_percent DESC;


-- =========================================
-- 4. Churn by Internet Service Type
-- =========================================
-- Helps identify service-level churn patterns

SELECT 
    internetservice,
    COUNT(*) AS total_customers,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_percent
FROM telco_churn.customer_churn
GROUP BY internetservice
ORDER BY churn_rate_percent DESC;


-- =========================================
-- 5. Revenue at Risk (Critical KPI)
-- =========================================
-- Estimates how much monthly revenue is at risk due to churn

SELECT 
    ROUND(SUM(monthlycharges)::numeric, 2) AS revenue_at_risk
FROM telco_churn.customer_churn
WHERE churn_flag = 1;


-- =========================================
-- 6. High Risk Segment Identification
-- =========================================
-- Identifies combinations of contract and payment method
-- that are most associated with churn

SELECT 
    contract,
    paymentmethod,
    COUNT(*) AS customer_count,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_percent
FROM telco_churn.customer_churn
GROUP BY contract, paymentmethod
ORDER BY churn_rate_percent DESC;