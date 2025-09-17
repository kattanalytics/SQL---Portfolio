# Snowflake Projects  

This folder contains projects that demonstrate how I use **Snowflake cloud data platform** for querying, data loading, and analysis.  
It highlights my ability to work with cloud data warehouses as part of my goal to become a **Data Support Analyst**.  

---

## 📂 Structure
- **/queries** → SQL queries written and tested in Snowflake.  
- **/results** → Saved outputs of queries (screenshots or CSV exports).  

---

## 🚀 Getting Started
1. Dataset: Loaded the **Superstore Sales** dataset into Snowflake.  
2. Method: Used the **Snowflake Data Loading Wizard** to create a table and import `SampleSuperstore.csv`.  
3. Schema: Data stored in `PORTFOLIO_DB.PUBLIC.ORDERS`.  

---

## 📊 Queries

-  Preview first 10 rows  
  ```sql
SELECT *
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
LIMIT 10;
```
[View Result](preview_first_10_rows_p_db.csv)


-  Total Sales and Profit by Region
```sql
SELECT Region, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Region
ORDER BY total_sales DESC;
```
[View Result](results/total_sales_and_profit_by_region_p_db.csv)


-  Top 10 Products by Sales
```sql
SELECT Product_Name, 
       SUM(Sales) AS total_sales
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 10;
```
[View Result](results/top_10_products_by_sales_p_db.csv)


-  Yearly Sales Trend
```sql
SELECT YEAR(Order_Date) AS order_year, 
       SUM(Sales) AS total_sales
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY order_year
ORDER BY order_year;
```
[View Results](results/yearly_sales_trends_p_db.csv)


-  Customer Ranking by Total Sales    
Business Question: Who are the top 10 customers by total sales, and how do they rank compared to others?
```sql
SELECT 
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;
```
📌 Demonstrates: Window functions (RANK()), aggregation, and ranking logic.

[View Result](results/customer_ranking_p_db.csv)

-  Monthly Sales Trend with Running Total     
Business Question: What is the month-by-month sales trend, and how does the cumulative total grow over time?
```sql
SELECT
    DATE_TRUNC('month', Order_Date) AS Order_Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(SUM(Sales)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)) AS Running_Total
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY Order_Month
ORDER BY Order_Month;
```
📌 Demonstrates: Date functions, aggregation, and windowed running totals.

[View Result](results/monthly_sales_trend_p_db.csv)


-  Profitability by Category + Product Level    
  Business Question: Within each product category, which single product is the most profitable?
```sql
SELECT CATEGORY,
       PRODUCT_NAME,
       SUM(PROFIT) AS TOTAL_PROFIT
FROM PORTFOLIO_DB.PUBLIC.SALES_SUPERSTORE
GROUP BY CATEGORY, PRODUCT_NAME
QUALIFY ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY SUM(PROFIT) DESC) = 1
ORDER BY TOTAL_PROFIT DESC;
```

📌 Demonstrates: Window Functions + Partitioning   

[View Result](profitability_by_category_plus_product_level_p_db.csv)

---


## Azure Integration

This project demonstrates how Snowflake integrates with Microsoft Azure for cloud-based data workflows.  

- **Staging**: A blob container was created in Azure Storage and connected to Snowflake using a secure SAS token. Files (Superstore dataset) were staged into Snowflake through this integration.  
- **Loading**: Data from the staged files was loaded into a Snowflake table (`SUPERSTORE_RAW`) for analysis.  
- **Validation**: Once loaded, the data was queried directly in Snowflake, confirming successful integration and accessibility.  

This workflow highlights my ability to work with **cloud storage and data warehouses together**, preparing data for scalable analytics and pipeline automation.

## 📊 Queries

-  Year-Over-Year Sales Growth
  ```sql
  SELECT 
    YEAR(ORDER_DATE) AS YEAR,
    ROUND(SUM(SALES), 2) AS TOTAL_SALES,
    ROUND(
        (SUM(SALES) - LAG(SUM(SALES)) OVER (ORDER BY YEAR(ORDER_DATE))) 
        / NULLIF(LAG(SUM(SALES)) OVER (ORDER BY YEAR(ORDER_DATE)), 0) * 100, 
        2
    ) AS YOY_GROWTH_PERCENT
  FROM SUPERSTORE_RAW
  GROUP BY YEAR(ORDER_DATE)
  ORDER BY YEAR;
  ```

  📌 Shows growth % by year to highlight trend analysis

[View Result](results/year_over_year_sales_growth_ss_a.csv)


-  Top 10 Customers by Profit
  ```sql
SELECT 
    CUSTOMER_NAME,
    ROUND(SUM(PROFIT), 2) AS TOTAL_PROFIT
FROM SUPERSTORE_RAW
GROUP BY CUSTOMER_NAME
ORDER BY TOTAL_PROFIT DESC
LIMIT 10;
```

 📌 Demonstrates ability to drill down into customer-level profitability

[View Result](results/top_10_customers_by_profit_ss_a.csv)


-  Sales vs. Profit by Category
  ```sql
SELECT 
    CATEGORY,
    ROUND(SUM(SALES), 2) AS TOTAL_SALES,
    ROUND(SUM(PROFIT), 2) AS TOTAL_PROFIT
FROM SUPERSTORE_RAW
GROUP BY CATEGORY
ORDER BY TOTAL_SALES DESC;
```

 📌 Highlights mismatch between sales volume and actual profit

[View Result](results/sales_vs_profit_by_category_ss_a.csv)


-  Monthly Sales Trend (for forecasting prep)
  ```sql
SELECT 
    TO_CHAR(ORDER_DATE, 'YYYY-MM') AS YEAR_MONTH,
    ROUND(SUM(SALES), 2) AS TOTAL_SALES
FROM SUPERSTORE_RAW
GROUP BY YEAR_MONTH
ORDER BY YEAR_MONTH;
```

 📌 Aggregate sales by month, set up time series for BI/forecasting

[View Result](results/monthly_sales_trend(for_fc_prep)_ss_a.cvs)


-  Regional Contribution to Total Sales
  ```sql
SELECT 
    REGION,
    ROUND(SUM(SALES), 2) AS TOTAL_SALES,
    ROUND(
        SUM(SALES) / SUM(SUM(SALES)) OVER () * 100, 
        2
    ) AS PERCENT_OF_TOTAL
FROM SUPERSTORE_RAW
GROUP BY REGION
ORDER BY TOTAL_SALES DESC;
```

 📌 Which region drives revenue? This is common in BI dashboards

[View Result](results/regional_contribution_to_total_sales_ss_a.csv)


