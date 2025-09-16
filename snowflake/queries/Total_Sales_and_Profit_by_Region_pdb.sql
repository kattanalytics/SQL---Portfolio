-- Total Sales and Prifot by Region

SELECT Region, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Region
ORDER BY total_sales DESC;
