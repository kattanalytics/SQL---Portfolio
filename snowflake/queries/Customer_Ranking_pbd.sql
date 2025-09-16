Who are the top 10 customers by total sales, and how do they rank compared to others?
SELECT 
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;
