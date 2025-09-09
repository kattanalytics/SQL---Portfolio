-- Top Customers by Sales

SELECT `Customer Name`, SUM(Sales) AS Total_Sales
FROM superstore.orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;