-- =========================================
-- Customer Churn Analysis Project
-- Database Setup (PostgreSQL)
-- Author: Data Analyst Portfolio Project
-- Purpose: Create analytics-ready table for churn analysis
-- =========================================

-- =========================================
-- 1. Create Schema (Namespace for project tables)
-- =========================================
-- This ensures proper project organization and avoids conflicts
CREATE SCHEMA IF NOT EXISTS telco_churn;

-- Set schema context so all operations apply to this schema
SET search_path TO telco_churn;

-- =========================================
-- 2. Clean Re-run Safety
-- =========================================
-- Drop existing table to ensure reproducibility of pipeline runs
-- This allows the script to be executed multiple times without errors
DROP TABLE IF EXISTS customer_churn;

-- =========================================
-- 3. Create Main Analytics Table
-- =========================================
-- This table contains processed customer-level features
-- It is designed for SQL analysis, BI tools (Power BI), and reporting

CREATE TABLE customer_churn (
    customerid VARCHAR(50) PRIMARY KEY,   -- Unique customer identifier

    gender VARCHAR(10),
    seniorcitizen INTEGER,
    partner VARCHAR(10),
    dependents VARCHAR(10),

    tenure INTEGER,                       -- Customer lifecycle duration
    tenure_group VARCHAR(20),            -- Segmented tenure (e.g., New, Loyal)

    phoneservice VARCHAR(20),
    multiplelines VARCHAR(30),

    internetservice VARCHAR(30),
    onlinesecurity VARCHAR(30),
    onlinebackup VARCHAR(30),
    deviceprotection VARCHAR(30),
    techsupport VARCHAR(30),
    streamingtv VARCHAR(30),
    streamingmovies VARCHAR(30),

    contract VARCHAR(30),                 -- Contract type (key churn driver)
    paperlessbilling VARCHAR(10),
    paymentmethod VARCHAR(50),            -- Payment behavior indicator

    monthlycharges FLOAT,                 -- Monthly revenue per customer
    totalcharges FLOAT,                   -- Total accumulated charges
    total_revenue FLOAT,                 -- Engineered revenue metric

    churn VARCHAR(10),                   -- Target variable (Yes/No)
    churn_flag INTEGER                   -- Binary encoding (1 = churn, 0 = active)
);

-- =========================================
-- 4. Quick Validation Query
-- =========================================
-- Used to confirm table structure is correct after creation
SELECT * 
FROM telco_churn.customer_churn 
LIMIT 10;

-- =========================================
-- 5. Load Processed Dataset into Table
-- =========================================
-- IMPORTANT:
-- This uses the CLEANED / PROCESSED dataset (not raw data)
-- Ensure column order matches table definition

COPY telco_churn.customer_churn (
    customerid,
    gender,
    seniorcitizen,
    partner,
    dependents,
    tenure,
    phoneservice,
    multiplelines,
    internetservice,
    onlinesecurity,
    onlinebackup,
    deviceprotection,
    techsupport,
    streamingtv,
    streamingmovies,
    contract,
    paperlessbilling,
    paymentmethod,
    monthlycharges,
    totalcharges,
    churn,
    churn_flag,
    tenure_group,
    total_revenue
)


FROM 'E:/Customer Churn Analysis/data/processed/telco_churn_cleaned.csv'
DELIMITER ','
CSV HEADER;

-- =========================================
-- 6. Data Quality Check
-- =========================================
-- Verify that data has been loaded correctly into the table
-- This is a sanity check before starting analysis

SELECT COUNT(*) 
FROM telco_churn.customer_churn;