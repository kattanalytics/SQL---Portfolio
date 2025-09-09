-- Top 3 Customers by Total Sales in each Region

WITH customer_sales AS (
	SELECT
		Region,
        "Customer Name" AS CustomerName,
        SUM(Sales) AS TotalSales
	FROM orders
    GROUP BY Region, "Customer Name"
)
SELECT Region, CustomerName, TotalSales
FROM (
	SELECT
		Region,
        CustomerName,
        TotalSales,
        ROW_NUMBER() OVER (PARTITION BY Region ORDER BY TotalSales DESC) AS rn
	FROM customer_sales
    ) ranked
    WHERE rn <= 3
    ORDER BY Region, rn;