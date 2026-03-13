/*
=====================================================================
                   SQL INTERVIEW PRACTICE QUERIES
=====================================================================
Author: Judith68
Purpose: Sample SQL queries for practice and learning
Note: All table and column names are generic. No real customer data included.
=====================================================================
*/

-------------------------------------------------------------
-- Beginner Level Questions
-------------------------------------------------------------

-- 1. Display all customers
SELECT * 
FROM Customers;

-- 2. Display all products in the Electronics category
SELECT *
FROM Products
WHERE Category = 'Electronics';

-- 3. Show customers from Nigeria
SELECT *
FROM Customers
WHERE Country = 'Nigeria';

-- 4. Find all orders made after 2023-01-01
SELECT *
FROM Orders
WHERE OrderDate >= '2023-01-01';

-- 5. Display product names and prices
SELECT ProductName,
       Currency,
       Price
FROM Products;

-- 6. Find products that cost more than $500
SELECT *
FROM Products
WHERE Price > 500;

-- 7. Show the first 10 orders
SELECT TOP 10 *
FROM Orders;

-- 8. Count total number of customers
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- 8B. Count total number of customers by type
SELECT CustomerType,
       COUNT(*) AS Total_Customers
FROM Customers
GROUP BY CustomerType;

-- 9. Count total number of products
SELECT COUNT(*) AS Total_Products
FROM Products;

-- 9B. Count products by category
SELECT Category,
       COUNT(*) AS Total_Products
FROM Products
GROUP BY Category;

-- 10. Show distinct product categories
SELECT DISTINCT Category
FROM Products;

-------------------------------------------------------------
-- Intermediate Level Questions
-------------------------------------------------------------

-- 11. Find total number of orders placed
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- 12. Calculate total revenue by currency
SELECT P.Currency,
       SUM(OD.TotalAmount) AS Total_Revenue
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.Currency;

-- 13. Find average product price by currency
SELECT Currency,
       AVG(Price) AS Average_Price
FROM Products
GROUP BY Currency;

-- 14. Find total quantity sold
SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM OrderDetails;

-- 15. Show total sales per product
SELECT P.ProductName,
       SUM(OD.TotalAmount) AS Total_Product_Sales
FROM Products P
JOIN OrderDetails OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductName;

-- 16. Show total revenue per category
SELECT P.Category,
       P.Currency,
       SUM(OD.TotalAmount) AS Total_Revenue
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.Category, P.Currency;

-- 17. Count customers by country
SELECT Country,
       COUNT(*) AS Customers_Location
FROM Customers
GROUP BY Country;

-- 18. Show orders with customer names
SELECT O.OrderID,
       CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       O.OrderDate
FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID;

-- 19. Find the most expensive product
SELECT *
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

-- 20. Find the cheapest product
SELECT *
FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);

-------------------------------------------------------------
-- Joins Level Questions
-------------------------------------------------------------

-- 21. List all orders with customer names
SELECT O.*,
       CONCAT(C.FirstName, ' ', C.LastName) AS FullName
FROM Orders O
LEFT JOIN Customers C ON C.CustomerID = O.CustomerID
ORDER BY O.OrderID ASC;

-- 22. Show products purchased in each order
SELECT P.ProductName,
       O.OrderID,
       OD.Quantity,
       OD.TotalAmount
FROM OrderDetails OD
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
ORDER BY O.OrderID, P.ProductName;

-- 23. Show customer name, product name, and quantity purchased
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       P.ProductName,
       SUM(OD.Quantity) AS QuantityPurchased
FROM OrderDetails OD
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY CONCAT(C.FirstName, ' ', C.LastName), P.ProductName;

-- 24. Find total spending per customer
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       SUM(OD.TotalAmount) AS TotalSpending
FROM OrderDetails OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY CONCAT(C.FirstName, ' ', C.LastName);

-- 25. Find top 5 customers by spending
SELECT TOP 5 CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       SUM(OD.TotalAmount) AS TotalSpending
FROM OrderDetails OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY CONCAT(C.FirstName, ' ', C.LastName)
ORDER BY TotalSpending DESC;

-- 26. Find most purchased product
SELECT TOP 1 P.ProductName,
       SUM(OD.Quantity) AS Most_Purchased
FROM OrderDetails OD
JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY Most_Purchased DESC;

-- 27. Find least purchased product
SELECT TOP 1 P.ProductName,
       SUM(OD.Quantity) AS Least_Purchased
FROM OrderDetails OD
JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY Least_Purchased ASC;

-- 28. Show revenue generated by each product
SELECT P.ProductName,
       P.Currency,
       SUM(OD.TotalAmount) AS Total_Revenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName, P.Currency;

-- 29. Find customers who have never placed an order
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS FullName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

-- 30. Show number of orders per customer
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       COUNT(O.OrderID) AS Total_Orders
FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY CONCAT(C.FirstName, ' ', C.LastName);

-------------------------------------------------------------
-- Advanced SQL Questions
-------------------------------------------------------------

-- 31. Rank customers by total spending
WITH CustomerRank AS
(
    SELECT CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
           SUM(OD.TotalAmount) AS TotalSpending,
           RANK() OVER (ORDER BY SUM(OD.TotalAmount) DESC) AS Ranking
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    GROUP BY C.FirstName, C.LastName
)
SELECT *
FROM CustomerRank
ORDER BY Ranking;

-- 32. Find monthly revenue trend
WITH MonthlyTrend AS
(
    SELECT YEAR(O.OrderDate) AS Year,
           MONTH(O.OrderDate) AS Month,
           SUM(OD.TotalAmount) AS Monthly_Revenue
    FROM Orders O
    JOIN OrderDetails OD ON OD.OrderID = O.OrderID
    GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
)
SELECT *
FROM MonthlyTrend
ORDER BY Year, Month;

-- 33. Calculate running total of revenue
SELECT O.OrderDate,
       SUM(OD.TotalAmount) AS Daily_Revenue,
       SUM(SUM(OD.TotalAmount)) OVER(ORDER BY O.OrderDate) AS Running_Revenue
FROM Orders O
JOIN OrderDetails OD ON OD.OrderID = O.OrderID
GROUP BY O.OrderDate
ORDER BY O.OrderDate;

-- 34. Find top selling product in each category
WITH BestProduct AS
(
    SELECT P.Category,
           P.ProductName,
           SUM(OD.Quantity) AS Top_Selling,
           RANK() OVER(PARTITION BY P.Category ORDER BY SUM(OD.Quantity) DESC) AS Top_Product_Rank
    FROM OrderDetails OD
    JOIN Products P ON OD.ProductID = P.ProductID
    GROUP BY P.Category, P.ProductName
)
SELECT Category,
       ProductName,
       Top_Selling
FROM BestProduct
WHERE Top_Product_Rank = 1;

-- 35. Find customers who placed more than 5 orders
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       COUNT(O.OrderID) AS Orders_Placed
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 5;

-- 36. Calculate average order value
WITH AverageOrder AS
(
    SELECT SUM(OD.TotalAmount) / COUNT(DISTINCT O.OrderID) AS Average_Order
    FROM OrderDetails OD
    JOIN Orders O ON O.OrderID = OD.OrderID
)
SELECT Average_Order
FROM AverageOrder;

-- 37. Find the day with the highest sales
SELECT TOP 1
       CAST(O.OrderDate AS DATE) AS Sale_Day,
       SUM(OD.TotalAmount) AS Highest_Sales
FROM OrderDetails OD
JOIN Orders O ON O.OrderID = OD.OrderID
GROUP BY CAST(O.OrderDate AS DATE)
ORDER BY Highest_Sales DESC;

-- 38. Find repeat customers
SELECT C.CustomerID,
       CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       COUNT(O.OrderID) AS TotalOrders
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 1
ORDER BY TotalOrders DESC;

-- 39. Find customer lifetime value
SELECT C.CustomerID,
       CONCAT(C.FirstName, ' ', C.LastName) AS FullName,
       SUM(OD.TotalAmount) AS Customer_Lifetime_Value
FROM OrderDetails OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY Customer_Lifetime_Value DESC;

-- 40. Find percentage contribution of each category to total revenue
SELECT P.Category,
       SUM(OD.TotalAmount) AS Category_Revenue,
       SUM(OD.TotalAmount) * 100.0 / (SELECT SUM(TotalAmount) FROM OrderDetails) AS Percentage_Contribution
FROM OrderDetails OD
JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.Category
ORDER BY Percentage_Contribution DESC;
