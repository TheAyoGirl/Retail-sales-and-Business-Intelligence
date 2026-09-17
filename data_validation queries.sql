USE RetailSalesBI;
GO

/* ============================================================
   03_DATA_VALIDATION.SQL
   Retail Sales & Business Intelligence
   ============================================================ */

/* 1. SOURCE TABLE ROW COUNTS */
SELECT 'Orders' AS TableName, COUNT(*) AS Row_Count FROM dbo.Orders
UNION ALL
SELECT 'Returns', COUNT(*) FROM dbo.Returns
UNION ALL
SELECT 'People', COUNT(*) FROM dbo.People;

/* 2. SAMPLE DATA CHECK */
SELECT TOP 5 *
FROM dbo.Orders;

/* 3. DUPLICATE ORDER + PRODUCT COMBINATIONS */
SELECT COUNT(*) AS DuplicateOrderRows
FROM (
    SELECT [Order_ID], [Product_ID], COUNT(*) AS cnt
    FROM dbo.Orders
    GROUP BY [Order_ID], [Product_ID]
    HAVING COUNT(*) > 1
) d;

/* 4. UNMATCHED RETURNS — RAW ORDERS */
SELECT COUNT(*) AS UnmatchedReturns
FROM dbo.Returns r
LEFT JOIN dbo.Orders o ON r.[Order_ID] = o.[Order_ID]
WHERE o.[Order_ID] IS NULL;

/* 5. SHOW REPEATED ORDER + PRODUCT COMBINATIONS */
SELECT [Order_ID], [Product_ID], COUNT(*) AS Occurrences
FROM dbo.Orders
GROUP BY [Order_ID], [Product_ID]
HAVING COUNT(*) > 1
ORDER BY Occurrences DESC;

/* 6. INSPECT REPEATED TRANSACTIONS */
SELECT [Order_ID], [Product_ID], [Product_Name], [Quantity],
       [Sales], [Discount], [Profit]
FROM dbo.Orders
WHERE [Order_ID] IN (
    SELECT [Order_ID]
    FROM dbo.Orders
    GROUP BY [Order_ID], [Product_ID]
    HAVING COUNT(*) > 1
)
ORDER BY [Order_ID], [Product_ID];

/* 7. IDENTIFY EXACT DUPLICATE TRANSACTION ROWS */
SELECT [Order_ID], [Product_ID], [Product_Name], [Quantity],
       [Sales], [Discount], [Profit], COUNT(*) AS DuplicateCount
FROM dbo.Orders
GROUP BY [Order_ID], [Product_ID], [Product_Name], [Quantity],
         [Sales], [Discount], [Profit]
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;

/* 8. CURRENT RAW ORDER ROW COUNT */
SELECT COUNT(*) AS CurrentRows
FROM dbo.Orders;

/* 9. CREATE CLEAN ANALYTICAL TABLE */
SELECT *
INTO dbo.Orders_Clean
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY [Order_ID], [Product_ID], [Product_Name],
                            [Quantity], [Sales], [Discount], [Profit]
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM dbo.Orders
) x
WHERE rn = 1;

ALTER TABLE dbo.Orders_Clean
DROP COLUMN rn;

/* 10. CLEAN TABLE ROW COUNT */
SELECT COUNT(*) AS CleanRows
FROM dbo.Orders_Clean;

/* 11. CONFIRM CLEAN TABLE EXISTS */
SELECT OBJECT_ID('dbo.Orders_Clean') AS TableExists;

/* 12. FINAL CLEAN ROW COUNT */
SELECT COUNT(*) AS CleanRows
FROM dbo.Orders_Clean;

/* 13. UNIQUE ORDERS, CUSTOMERS AND PRODUCTS */
SELECT COUNT(DISTINCT [Order_ID]) AS UniqueOrders,
       COUNT(DISTINCT [Customer_ID]) AS UniqueCustomers,
       COUNT(DISTINCT [Product_ID]) AS UniqueProducts
FROM dbo.Orders_Clean;

/* 14. UNMATCHED RETURNS — CLEAN ORDERS */
SELECT COUNT(*) AS UnmatchedReturns
FROM dbo.Returns r
LEFT JOIN dbo.Orders_Clean o ON r.[Order_ID] = o.[Order_ID]
WHERE o.[Order_ID] IS NULL;
