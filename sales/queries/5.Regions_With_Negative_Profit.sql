-- Regions with Negative Profit

SELECT Region, SUM(Profit) AS Total_Profit
FROM superstore.orders
GROUP BY Region
HAVING Total_Profit < 0
ORDER BY  Total_Profit ASC;
