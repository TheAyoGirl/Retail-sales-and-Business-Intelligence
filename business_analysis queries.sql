USE RetailSalesBI;
GO

/* ============================================================
   04_BUSINESS_ANALYSIS.SQL
   Retail Sales & Business Intelligence
   ============================================================ */

/* Q1. CORE KPIs */
SELECT
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS TotalQuantity,
    COUNT(DISTINCT [Order_ID]) AS TotalOrders,
    COUNT(DISTINCT [Customer_ID]) AS TotalCustomers,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean;

/* Q2. SALES & PROFIT PER YEAR */
SELECT
    [Order_Year],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS TotalQuantity,
    COUNT(DISTINCT [Order_ID]) AS TotalOrders,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
GROUP BY [Order_Year]
ORDER BY [Order_Year];

/* Q3. REGIONAL PERFORMANCE */
SELECT
    [Region],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS TotalQuantity,
    COUNT(DISTINCT [Order_ID]) AS TotalOrders,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
GROUP BY [Region]
ORDER BY TotalProfit DESC;

/* Q4. CATEGORY PERFORMANCE */
SELECT
    [Category],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS TotalQuantity,
    COUNT(DISTINCT [Order_ID]) AS TotalOrders,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
GROUP BY [Category]
ORDER BY TotalProfit DESC;

/* Q5. SUB-CATEGORY PERFORMANCE */
SELECT
    [Category],
    [Sub_Category],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS TotalQuantity,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
GROUP BY [Category], [Sub_Category]
ORDER BY TotalProfit DESC;

/* Q6. DISCOUNT BAND PROFITABILITY */
SELECT
    CASE
        WHEN [Discount] = 0 THEN '0%'
        WHEN [Discount] <= 0.10 THEN '1-10%'
        WHEN [Discount] <= 0.20 THEN '11-20%'
        WHEN [Discount] <= 0.30 THEN '21-30%'
        WHEN [Discount] <= 0.40 THEN '31-40%'
        ELSE 'Over 40%'
    END AS DiscountBand,
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS TotalQuantity,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
GROUP BY CASE
    WHEN [Discount] = 0 THEN '0%'
    WHEN [Discount] <= 0.10 THEN '1-10%'
    WHEN [Discount] <= 0.20 THEN '11-20%'
    WHEN [Discount] <= 0.30 THEN '21-30%'
    WHEN [Discount] <= 0.40 THEN '31-40%'
    ELSE 'Over 40%'
END
ORDER BY MIN([Discount]);

/* Q7. HIGH DISCOUNTS BY CATEGORY */
SELECT
    [Category],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
WHERE [Discount] > 0.20
GROUP BY [Category]
ORDER BY TotalProfit ASC;

/* Q8. HIGH DISCOUNTS BY SUB-CATEGORY */
SELECT
    [Category],
    [Sub_Category],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
FROM dbo.Orders_Clean
WHERE [Discount] > 0.20
GROUP BY [Category], [Sub_Category]
ORDER BY TotalProfit ASC;

/* Q9. RETURNS */
SELECT
    CASE WHEN r.[Order_ID] IS NOT NULL THEN 'Returned' ELSE 'Not Returned' END AS ReturnStatus,
    SUM(o.[Sales]) AS TotalSales,
    SUM(o.[Profit]) AS TotalProfit,
    COUNT(DISTINCT o.[Order_ID]) AS TotalOrders,
    SUM(o.[Quantity]) AS TotalQuantity
FROM dbo.Orders_Clean o
LEFT JOIN dbo.Returns r ON o.[Order_ID] = r.[Order_ID]
GROUP BY CASE WHEN r.[Order_ID] IS NOT NULL THEN 'Returned' ELSE 'Not Returned' END;

/* Q10. RETURNED ORDERS BY SUB-CATEGORY */
SELECT
    o.[Category],
    o.[Sub_Category],
    COUNT(DISTINCT r.[Order_ID]) AS ReturnedOrders,
    SUM(o.[Sales]) AS ReturnedSales,
    SUM(o.[Profit]) AS ReturnedProfit
FROM dbo.Orders_Clean o
INNER JOIN dbo.Returns r ON o.[Order_ID] = r.[Order_ID]
GROUP BY o.[Category], o.[Sub_Category]
ORDER BY ReturnedOrders DESC;

/* Q11A. TOP 10 PRODUCTS BY PROFIT */
WITH ProductProfit AS (
    SELECT
        [Product_Name],
        SUM([Sales]) AS TotalSales,
        SUM([Profit]) AS TotalProfit,
        SUM([Quantity]) AS TotalQuantity,
        CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
    FROM dbo.Orders_Clean
    GROUP BY [Product_Name]
)
SELECT TOP 10 [Product_Name], TotalSales, TotalProfit, TotalQuantity, ProfitMarginPct
FROM ProductProfit
ORDER BY TotalProfit DESC;

/* Q11B. BOTTOM 10 PRODUCTS BY PROFIT */
WITH ProductProfit AS (
    SELECT
        [Product_Name],
        SUM([Sales]) AS TotalSales,
        SUM([Profit]) AS TotalProfit,
        SUM([Quantity]) AS TotalQuantity,
        CAST(SUM([Profit]) / NULLIF(SUM([Sales]), 0) * 100 AS DECIMAL(10,2)) AS ProfitMarginPct
    FROM dbo.Orders_Clean
    GROUP BY [Product_Name]
)
SELECT TOP 10 [Product_Name], TotalSales, TotalProfit, TotalQuantity, ProfitMarginPct
FROM ProductProfit
ORDER BY TotalProfit ASC;

/* Q12. HIGH-DISCOUNT LOSS-MAKING PRODUCTS */
SELECT TOP 15
    [Product_Name],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    AVG([Discount]) * 100 AS AvgDiscountPct,
    SUM([Quantity]) AS TotalQuantity
FROM dbo.Orders_Clean
WHERE [Discount] > 0.20
GROUP BY [Product_Name]
HAVING SUM([Profit]) < 0
ORDER BY TotalProfit ASC;
