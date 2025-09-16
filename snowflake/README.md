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

