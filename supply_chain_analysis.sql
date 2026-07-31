/*
===========================================================================
 Supply Chain Delivery Performance Analysis
 Dataset: DataCo Smart Supply Chain (180,519 orders)
 Author: Rebecca
 Description: SQL analysis investigating late delivery drivers across
 region, shipping mode, and product category, plus a data prep query
 used for demand forecasting in Python (Prophet).
===========================================================================
*/


-- ===========================================================================
-- 1. LATE DELIVERIES BY REGION
-- Business question: Is late delivery concentrated in specific regions?
-- Finding: Late % is fairly consistent across regions (~55-60%), with no
-- single region standing out as a major outlier (aside from small-sample
-- exceptions like Central Africa at 61%).
-- ===========================================================================
SELECT 
    [Order_Region],
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN [Late_Delivery_Flag] = 'Late' THEN 1 ELSE 0 END) AS LateOrders,
    ROUND(100.0 * SUM(CASE WHEN [Late_Delivery_Flag] = 'Late' THEN 1 ELSE 0 END) / COUNT(*), 1) AS LatePercentage
FROM SupplyChainOrders
GROUP BY [Order_Region]
ORDER BY LatePercentage DESC;


-- ===========================================================================
-- 2. LATE DELIVERIES BY SHIPPING MODE
-- Business question: Does shipping mode affect on-time performance?
-- Finding (headline insight): First Class is late 100% of the time,
-- Second Class 79.7% of the time. Standard Class (the slowest option)
-- is the MOST reliable at 39.8% late -- suggesting the issue is SLA
-- design, not operational execution.
-- ===========================================================================
SELECT 
    [Shipping_Mode],
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN [Late_Delivery_Flag] = 'Late' THEN 1 ELSE 0 END) AS LateOrders,
    ROUND(100.0 * SUM(CASE WHEN [Late_Delivery_Flag] = 'Late' THEN 1 ELSE 0 END) / COUNT(*), 1) AS LatePercentage
FROM SupplyChainOrders
GROUP BY [Shipping_Mode]
ORDER BY LatePercentage DESC;


-- ===========================================================================
-- 3. SCHEDULED VS. ACTUAL SHIPPING DAYS BY SHIPPING MODE
-- Business question: WHY is First/Second Class so unreliable?
-- Finding (root cause): First Class promises 1 day but averages 2 days
-- delivered, every time. Second Class promises 2 days but averages 4.
-- Standard Class promises 4 days and delivers in ~4 -- the SLA promise
-- matches actual fulfillment capability, which is why it performs well.
-- ===========================================================================
SELECT 
    [Shipping_Mode],
    AVG(CAST([Days_for_shipping_real] AS FLOAT)) AS AvgRealDays,
    AVG(CAST([Days_for_shipment_scheduled] AS FLOAT)) AS AvgScheduledDays
FROM SupplyChainOrders
GROUP BY [Shipping_Mode];


-- ===========================================================================
-- 4. LATE DELIVERIES BY PRODUCT CATEGORY
-- Business question: Is late delivery tied to specific product types?
-- Finding: No -- late % clusters tightly in the high-50s to low-60s
-- across nearly all 50 categories. This rules out product-specific
-- handling issues as a root cause, reinforcing that shipping mode SLA
-- design (see Query 2 & 3) is the real driver.
-- ===========================================================================
SELECT 
    [Category_Name],
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN [Late_Delivery_Flag] = 'Late' THEN 1 ELSE 0 END) AS LateOrders,
    ROUND(100.0 * SUM(CASE WHEN [Late_Delivery_Flag] = 'Late' THEN 1 ELSE 0 END) / COUNT(*), 1) AS LatePercentage
FROM SupplyChainOrders
GROUP BY [Category_Name]
ORDER BY LatePercentage DESC;


-- ===========================================================================
-- 5. DAILY ORDER VOLUME (DATA PREP FOR FORECASTING)
-- Purpose: Aggregates order counts by day, exported to CSV and used as
-- the input for a Prophet demand forecasting model in Python.
-- Note: Records after 2017-10-02 were later excluded from the forecast
-- due to a data quality issue (mechanically repeating values), identified
-- and documented during the Python forecasting stage.
-- ===========================================================================
SELECT 
    CAST([order_date_DateOrders] AS DATE) AS OrderDate,
    COUNT(*) AS OrderCount
FROM SupplyChainOrders
GROUP BY CAST([order_date_DateOrders] AS DATE)
ORDER BY OrderDate;
