-- Top 10 Products by Sales


SELECT Product_Name, 
       SUM(Sales) AS total_sales
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 10;
