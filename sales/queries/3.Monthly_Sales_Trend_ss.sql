-- Monthly Sales Trend

SELECT DATE_FORMAT(`Order Date`, '%Y-%m') AS Month,
		SUM(Sales) AS Mothly_Sales
FROM superstore.orders
GROUP BY Month 
ORDER BY Month;