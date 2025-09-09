-- Top 5 Products by Quantity Sold

SELECT `Product Name`, SUM(Quantity) AS Total_Quantity
FROM superstore.orders
GROUP BY `Product Name`
ORDER BY Total_Quantity DESC
LIMIT 5;