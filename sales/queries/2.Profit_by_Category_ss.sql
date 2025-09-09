-- Profit by Catagory

SELECT Category, SUM(Profit) AS Total_Profit
FROM superstore.orders
GROUP BY Category
ORDER BY Total_Profit DESC;