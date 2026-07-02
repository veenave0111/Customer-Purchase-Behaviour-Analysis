USE RetailAnalytics;
GO

-- 1. Total revenue
SELECT SUM(P.Price * T.Quantity) AS TotalRevenue
FROM Transactions T
JOIN Products P ON T.ProductID = P.ProductID;

-- 2. Top customers by spending
SELECT C.CustomerName,
       SUM(P.Price * T.Quantity) AS TotalSpent
FROM Customers C
JOIN Transactions T ON C.CustomerID = T.CustomerID
JOIN Products P ON T.ProductID = P.ProductID
GROUP BY C.CustomerName
ORDER BY TotalSpent DESC;

-- 3. Most sold products
SELECT P.ProductName,
       SUM(T.Quantity) AS TotalQuantity
FROM Products P
JOIN Transactions T ON P.ProductID = T.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantity DESC;

-- 4. Revenue by category
SELECT P.Category,
       SUM(P.Price * T.Quantity) AS CategoryRevenue
FROM Products P
JOIN Transactions T ON P.ProductID = T.ProductID
GROUP BY P.Category
ORDER BY CategoryRevenue DESC;

-- 5. Monthly revenue trend
SELECT FORMAT(TransactionDate, 'yyyy-MM') AS Month,
       SUM(P.Price * T.Quantity) AS MonthlyRevenue
FROM Transactions T
JOIN Products P ON T.ProductID = P.ProductID
GROUP BY FORMAT(TransactionDate, 'yyyy-MM')
ORDER BY Month;

-- 6. RFM Analysis (Recency, Frequency, Monetary)
WITH RFM AS (
    SELECT 
        C.CustomerID,
        MAX(TransactionDate) AS LastPurchase,
        COUNT(*) AS Frequency,
        SUM(P.Price * T.Quantity) AS Monetary
    FROM Customers C
    JOIN Transactions T ON C.CustomerID = T.CustomerID
    JOIN Products P ON T.ProductID = P.ProductID
    GROUP BY C.CustomerID
)
SELECT 
    CustomerID,
    DATEDIFF(DAY, LastPurchase, GETDATE()) AS Recency,
    Frequency,
    Monetary
FROM RFM
ORDER BY Monetary DESC;

-- 7. Repeat customers
SELECT C.CustomerName
FROM Customers C
JOIN Transactions T ON C.CustomerID = T.CustomerID
GROUP BY C.CustomerName
HAVING COUNT(*) > 1;

-- 8. Customer retention rate
SELECT 
    (CAST(COUNT(DISTINCT CustomerID) AS FLOAT) /
     (SELECT COUNT(*) FROM Customers)) * 100 AS RetentionRate
FROM Transactions;
