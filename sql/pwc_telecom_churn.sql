-- =========================================================================
-- PwC Telecom Churn & Customer Risk Analytics - End-to-End SQL Analysis
-- Author: Data Analyst Portfolio Project
-- Purpose: Database initialization, data validation, and exploratory data analysis (EDA)
-- =========================================================================

-- -------------------------------------------------------------------------
-- 1. DATABASE INITIALIZATION & CONFIGURATION
-- -------------------------------------------------------------------------

-- Create the specific database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'pwc_telecom_churn')
BEGIN
    CREATE DATABASE pwc_telecom_churn;
END;
GO

-- Activate the database for subsequent operations
USE pwc_telecom_churn;
GO

-- -------------------------------------------------------------------------
-- 2. DATA VALIDATION & COHESION CHECKS
-- -------------------------------------------------------------------------

-- Check total record count to verify import integrity (Should return 7,043 rows)
SELECT COUNT(*) AS Total_Imported_Records 
FROM [01 Churn-Dataset];

-- Inspect the first 10 rows to verify column layout and mapping
SELECT TOP 10 * 
FROM 01 Churn-Dataset;

-- -------------------------------------------------------------------------
-- 3. EXECUTIVE EXECUTIVE KPIS (Validating Dashboard Core Figures)
-- -------------------------------------------------------------------------

-- Calculate Total Customers, Total Churned, Churn Rate %, and Total Historical Financial Footprint
-- Target metrics match: 7,043 Customers, 1,869 Churned, and 26.54% Churn Rate
SELECT 
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Total_Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Global_Churn_Rate_Percentage,
    ROUND(SUM(TotalCharges), 2) AS Total_Historical_Revenue,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Bill
FROM 01 Churn-Dataset;

-- -------------------------------------------------------------------------
-- 4. OPERATIONAL TICKETING AUDIT (Service Desks Load)
-- -------------------------------------------------------------------------

-- Quantify structural system stress by logging total Tech and Admin Tickets (Should yield 2,955 and 3,632)
SELECT 
    SUM(numTechTickets) AS Total_Tech_Tickets,
    SUM(numAdminTickets) AS Total_Admin_Tickets,
    ROUND(AVG(CAST(numTechTickets AS DECIMAL(10,2))), 2) AS Average_Tech_Tickets_Per_Account
FROM 01 Churn-Dataset;

-- -------------------------------------------------------------------------
-- 5. CONTRACT ARCHETYPE & PAYMENT METHOD RISK ROUTINES
-- -------------------------------------------------------------------------

-- Segment customer volume and calculate localized churn rates by Contract Type (Isolating Month-to-Month risks)
SELECT 
    Contract,
    COUNT(customerID) AS Subscriber_Volume,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Volume,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Localized_Churn_Rate_Pct
FROM 01 Churn-Dataset
GROUP BY Contract
ORDER BY Localized_Churn_Rate_Pct DESC;

-- Segment customer volume and identify financial risks by Selected Payment Method
SELECT 
    PaymentMethod,
    COUNT(customerID) AS Subscriber_Volume,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Volume,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Localized_Churn_Rate_Pct
FROM 01 Churn-Dataset
GROUP BY PaymentMethod
ORDER BY Localized_Churn_Rate_Pct DESC;

-- -------------------------------------------------------------------------
-- 6. TEMPORAL TENURE SEGMENTATION ANALYSIS
-- -------------------------------------------------------------------------

-- Derive structural Tenure Groups based on months of subscription to analyze attrition timing
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '< 1 Year'
        WHEN tenure <= 24 THEN '< 2 Years'
        WHEN tenure <= 36 THEN '< 3 Years'
        WHEN tenure <= 48 THEN '< 4 Years'
        WHEN tenure <= 60 THEN '< 5 Years'
        ELSE '> 5 Years'
    END AS Derived_Tenure_Group,
    COUNT(customerID) AS Total_Subscribers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Total_Lost_Subscribers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Churn_Rate_By_Tenure_Pct
FROM 01 Churn-Dataset
GROUP BY 
    CASE 
        WHEN tenure <= 12 THEN '< 1 Year'
        WHEN tenure <= 24 THEN '< 2 Years'
        WHEN tenure <= 36 THEN '< 3 Years'
        WHEN tenure <= 48 THEN '< 4 Years'
        WHEN tenure <= 60 THEN '< 5 Years'
        ELSE '> 5 Years'
    END
ORDER BY Churn_Rate_By_Tenure_Pct DESC;

-- -------------------------------------------------------------------------
-- 7. DEMOGRAPHIC ATTRIBUTES DEEP DIVE
-- -------------------------------------------------------------------------

-- Compare subscriber behavior and churn rates across Senior Citizen segments
SELECT 
    CASE WHEN SeniorCitizen = 1 THEN 'Senior' ELSE 'Citizen' END AS Age_Demographic_Bracket,
    COUNT(customerID) AS Active_Base,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Churn_Rate_Pct
FROM 01 Churn-Dataset
GROUP BY SeniorCitizen;

-- -------------------------------------------------------------------------
-- 8. PRODUCT & SERVICE LAYER CORRELATIONS
-- -------------------------------------------------------------------------

-- Identify attrition dynamics based on subscription to Online Security & Tech Support services
SELECT 
    InternetService,
    TechSupport,
    OnlineSecurity,
    COUNT(customerID) AS Total_Accounts,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Total_Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Risk_Churn_Rate_Pct
FROM 01 Churn-Dataset
GROUP BY InternetService, TechSupport, OnlineSecurity
ORDER BY Total_Accounts DESC;
