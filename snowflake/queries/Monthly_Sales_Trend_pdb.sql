What is the month-by-month sales trend, and how does the cumulative total grow over time?
SELECT
    DATE_TRUNC('month', Order_Date) AS Order_Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(SUM(Sales)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)) AS Running_Total
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Order_Month
ORDER BY Order_Month;