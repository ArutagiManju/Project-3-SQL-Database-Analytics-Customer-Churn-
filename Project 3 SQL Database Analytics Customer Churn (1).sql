-- Phase 1 – Database Setup
-- Step 1 Create Database

CREATE DATABASE churn_analysis;
USE churn_analysis;

-- Step 2 Create Table

CREATE TABLE Customers (
    CustomerID VARCHAR(30) PRIMARY KEY,
    Gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    Tenure INT,
    MonthlyCharges DECIMAL(10 , 2 )
)

CREATE TABLE Services (
    CustomerID VARCHAR(30),
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PRIMARY KEY (CustomerID)
)

CREATE TABLE Billing (
    CustomerID VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    TotalCharges DECIMAL(10 , 2 ),
    PRIMARY KEY (CustomerID)
)

CREATE TABLE Churn (
    CustomerID VARCHAR(30),
    Churn VARCHAR(5),
    PRIMARY KEY (CustomerID)
)


SELECT 
    COUNT(*)
FROM
    Customers
    

SELECT 
    COUNT(*)
FROM
    Services

SELECT 
    COUNT(*)
FROM
    Billing

SELECT 
    COUNT(*)
FROM
    Churn


DESCRIBE Customers;

DESCRIBE Services;

DESCRIBE Billing;

DESCRIBE Churn;

SELECT 
    *
FROM
    Customers
WHERE
    CustomerID IS NULL OR Gender IS NULL
        OR Tenure IS NULL

SELECT 
    *
FROM
    Billing
WHERE
    TotalCharges IS NULL

SELECT 
    Churn, COUNT(*) Customers
FROM
    Churn
GROUP BY Churn

SELECT
Churn,
COUNT(*) AS Customers,
ROUND(COUNT(*)*100/
(SUM(COUNT(*)) OVER()),2) Percentage
FROM Churn
GROUP BY Churn;

SELECT 
    ROUND(SUM(CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS ChurnRate
FROM
    Churn

SELECT 
    Gender,
    COUNT(*) Customers,
    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) Churned,
    ROUND(SUM(CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS ChurnRate
FROM
    Customers c
        JOIN
    Churn ch ON c.CustomerID = ch.CustomerID
GROUP BY Gender

SELECT 
    Contract,
    COUNT(*) Customers,
    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) Churned,
    ROUND(SUM(CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS ChurnRate
FROM
    Services s
        JOIN
    Churn c ON s.CustomerID = c.CustomerID
GROUP BY Contract


SELECT 
    InternetService,
    COUNT(*) Customers,
    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) Churned,
    ROUND(SUM(CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS ChurnRate
FROM
    Services s
        JOIN
    Churn c ON s.CustomerID = c.CustomerID
GROUP BY InternetService

SELECT 
    PaymentMethod,
    COUNT(*) Customers,
    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) Churned,
    ROUND(SUM(CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS ChurnRate
FROM
    Billing b
        JOIN
    Churn c ON b.CustomerID = c.CustomerID
GROUP BY PaymentMethod



SELECT 
    CASE
        WHEN Tenure <= 12 THEN '0-12'
        WHEN Tenure <= 24 THEN '13-24'
        WHEN Tenure <= 36 THEN '25-36'
        WHEN Tenure <= 48 THEN '37-48'
        WHEN Tenure <= 60 THEN '49-60'
        ELSE '61-72'
    END AS Cohort,
    COUNT(*) Customers,
    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) Churned
FROM
    Customers cu
        JOIN
    Churn ch ON cu.CustomerID = ch.CustomerID
GROUP BY Cohort



SELECT 
    CustomerID,
    MonthlyCharges,
    Tenure,
    ROUND(MonthlyCharges * Tenure, 2) AS CLV
FROM
    Customers
 
SELECT 
    ROUND(AVG(MonthlyCharges * Tenure), 2) Average_CLV
FROM
    Customers
 
SELECT 
    CustomerID, Tenure Recency
FROM
    Customers
 
SELECT 
    CustomerID, Tenure Frequency
FROM
    Customers
 
SELECT 
    CustomerID, TotalCharges Monetary
FROM
    Billing

SELECT 
    c.CustomerID,
    c.Tenure AS Recency,
    c.Tenure AS Frequency,
    b.TotalCharges Monetary
FROM
    Customers c
        JOIN
    Billing b ON c.CustomerID = b.CustomerID



SELECT 
    CustomerID,
    CASE
        WHEN TotalCharges > 5000 THEN 'High Value'
        WHEN TotalCharges > 2000 THEN 'Medium'
        ELSE 'Low'
    END AS Segment
FROM
    Billing
    
    
    
    SELECT

CustomerID,

TotalCharges,

RANK() OVER(ORDER BY TotalCharges DESC)

RankNo

FROM Billing;

SELECT

Contract,

AVG(MonthlyCharges)

OVER(PARTITION BY Contract)

AvgCharge

FROM Customers c

JOIN Services s

ON c.CustomerID=s.CustomerID;




WITH ChurnData AS
(
SELECT

c.CustomerID,

Contract,

MonthlyCharges,

Churn

FROM Customers c

JOIN Services s

ON c.CustomerID=s.CustomerID

JOIN Churn ch

ON c.CustomerID=ch.CustomerID
)

SELECT *

FROM ChurnData

WHERE Churn='Yes';




CREATE VIEW vw_ChurnSummary AS
    SELECT 
        Contract,
        COUNT(*) Customers,
        SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) Churned
    FROM
        Services s
            JOIN
        Churn c ON s.CustomerID = c.CustomerID
    GROUP BY Contract


CREATE VIEW vw_CLV AS
    SELECT 
        CustomerID,
        MonthlyCharges,
        Tenure,
        MonthlyCharges * Tenure AS CLV
    FROM
        Customers



SELECT 
    *
FROM
    vw_CLV
ORDER BY CLV DESC
LIMIT 10

SELECT 
    c.CustomerID, Contract, MonthlyCharges, PaymentMethod, Churn
FROM
    Customers c
        JOIN
    Services s ON c.CustomerID = s.CustomerID
        JOIN
    Billing b ON c.CustomerID = b.CustomerID
        JOIN
    Churn ch ON c.CustomerID = ch.CustomerID
WHERE
    Contract = 'Month-to-month'
        AND Churn = 'Yes'
 
        
SELECT 
    CustomerID, MonthlyCharges, Tenure
FROM
    Customers
WHERE
    MonthlyCharges > 80 AND Tenure < 12
 
    
SELECT 
    InternetService,
    COUNT(*) Customers,
    SUM(Churn = 'Yes') Churned
FROM
    Services s
        JOIN
    Churn c ON s.CustomerID = c.CustomerID
GROUP BY InternetService


