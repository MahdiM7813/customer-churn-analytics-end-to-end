-- =========================================
-- Customer Segmentation Analysis
-- Author: Data Analyst Portfolio Project
-- Purpose: Identify customer groups based on risk, value, and tenure
-- =========================================

-- =========================================
-- 1. Base Segmentation Table
-- =========================================
-- Combines risk level, tenure stage, and value segment

SELECT 
    customerid,
    tenure_group,
    contract,
    paymentmethod,
    monthlycharges,
    total_revenue,
    churn_flag,

    -- =====================================
    -- 2. Risk Segmentation (Rule-based model)
    -- =====================================
    CASE 
        WHEN contract = 'Month-to-month' 
             AND churn_flag = 1 THEN 'High Risk'
        
        WHEN tenure <= 12 AND churn_flag = 1 THEN 'High Risk'
        
        WHEN monthlycharges > (SELECT AVG(monthlycharges) FROM telco_churn.customer_churn)
             AND churn_flag = 1 THEN 'High Risk'
        
        WHEN churn_flag = 1 THEN 'Medium Risk'
        
        ELSE 'Low Risk'
    END AS risk_level,

    -- =====================================
    -- 3. Value Segmentation
    -- =====================================
    CASE 
        WHEN total_revenue >= 3000 THEN 'High Value'
        WHEN total_revenue >= 1000 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS value_segment,

    -- =====================================
    -- 4. Lifecycle Segmentation
    -- =====================================
    CASE 
        WHEN tenure <= 12 THEN 'New (0-1y)'
        WHEN tenure <= 24 THEN 'Growing (1-2y)'
        WHEN tenure <= 48 THEN 'Mature (2-4y)'
        ELSE 'Loyal (4y+)'
    END AS lifecycle_stage

FROM telco_churn.customer_churn;
