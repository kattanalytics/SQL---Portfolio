-- Yearly Sales Trend


SELECT YEAR(Order_Date) AS order_year, 
       SUM(Sales) AS total_sales
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY order_year
ORDER BY order_year;

