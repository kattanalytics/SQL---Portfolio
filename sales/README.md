# SQL Portfolio – Kathryn Starkey  
## Sales (Superstore) Dataset  

The Superstore Sales dataset is a retail dataset widely used in analytics practice. This project demonstrates how I use SQL to answer real-world business questions such as sales trends, profitability by category, and customer segmentation. By applying filtering, aggregations, subqueries, date functions, and window functions, I show the ability to transform raw transactional data into insights. These are the same skills that support monitoring and troubleshooting in a data warehouse environment, where performance, accuracy, and timely insights are critical.

## Data Import Process

Documenting the import process ensures the dataset can be reloaded consistently, 
which is important for data reliability and reproducibility in real-world analytics workflows.

For practice, I documented two ways to load the dataset into MySQL:

**Option 1 – Import Wizard:**  
Used MySQL Workbench’s *Table Data Import Wizard* to quickly load `SampleSuperstore.csv`.

**Option 2 – SQL Script (for reproducibility):**  
Manually loaded the CSV into the `orders` table using `LOAD DATA INFILE`:

```sql
LOAD DATA LOCAL INFILE 'C:/Users/Kathryn/Documents/SampleSuperstore.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
IGNORE 1 ROWS → skips the header row.

FIELDS TERMINATED BY ',' → handles the CSV format.

ENCLOSED BY '"' → ensures text fields load correctly.

---
## Analysis/ Queries

For each example, you’ll see:

- **The business-style question/problem**  
- **The SQL query I wrote**  
- **A screenshot of the result**  

---

## 1. Basic Filtering and Sorting  

**Question:** What are the top 10 Customers by Total Sales?  
```sql
SELECT `Customer Name`, SUM(Sales) AS Total_Sales
FROM superstore.orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;
```

**Result Screenshot:**
![Top 10 Customers by Total Sales](results/top_sales_by_customer_ss.png)


## 2. Aggregation
   
**Question:** What is the total profit by product category?
```sql
SELECT Category, SUM(Profit) AS Total_Profit
FROM superstore.orders
GROUP BY Category
ORDER BY Total_Profit DESC;
```

**Result Screenshot:**
![Total Profit by Product Category](results/profit_by_category_ss.png)

## 3. Date Functions

**Question:** What is the Monthly Sales Trend?
```sql
SELECT DATE_FORMAT(`Order Date`, '%Y-%m') AS Month,
		SUM(Sales) AS Monthly_Sales
FROM superstore.orders
GROUP BY Month 
ORDER BY Month;
```
**Result Screenshot:**
![Monthly Sales Trend](results/monthly_sales_trends_ss.png)

## 4. Subquery
**Question:** What are the Top 5 Products by Quantity sold?
```sql
SELECT Product_Name, Total_Quantity
FROM (
    SELECT `Product Name` AS Product_Name,
           SUM(Quantity) AS Total_Quantity,
           ROW_NUMBER() OVER (ORDER BY SUM(Quantity) DESC) AS rn
    FROM superstore.orders
    GROUP BY `Product Name`
) ranked
WHERE rn <= 5;
```

**Result Screenshot:**
![Top 5 Products by Quantity Sold](results/top_5_products_by_quantity_sold_ss.png)

## 5. Aggregation with Grouping

**Question:** What Regions have negative profit?
```sql
SELECT Region, SUM(Profit) AS Total_Profit
FROM superstore.orders
GROUP BY Region
HAVING Total_Profit < 0
ORDER BY  Total_Profit ASC;
```

**Result Screenshot:**
![Regions with Negative Profit](results/regions_with_negative_profit_ss.png)

## 6. Window Function (ROW_NUMBER)

**Question:** Who are the top 3 customers by total sales in each region?
```sql
WITH Customer_Sales AS (
    SELECT 
        Region,
        `Customer Name` AS Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Region, `Customer Name`
)
SELECT Region, Customer_Name, Total_Sales
FROM (
    SELECT 
        Region,
        Customer_Name,
        Total_Sales,
        ROW_NUMBER() OVER (PARTITION BY Region ORDER BY Total_Sales DESC) AS rn
    FROM Customer_Sales
) ranked
WHERE rn <= 3
ORDER BY Region, rn;
```

**Result Screenshot:**
![Top 3 Customers By Total Sales in each Region](results/top_3_customers_by_total_sales_in_each_region_ss.png)

---

## Power BI Dashboard

To complement the SQL analysis, I built an interactive Power BI dashboard using the Superstore dataset.  
This dashboard highlights sales trends, profitability, and product performance with KPIs, filters, and visuals.

### Dashboard Preview
![Superstore Dashboard Overview](results/superstore_dashboard_full.png)
This dashboard was built using the Superstore dataset to highlight both high-level KPIs and deeper business insights.
Top row: KPI cards for Total Sales, Profit, Order Count, and Average Order Value, with slicers for Region, and Year.
Middle row: Visuals showing Sales by Region and a Yearly Sales Trend Line chart for deeper analysis.
Bottom row: A Top 10 Products chart and slicers for Region, and Year.
The layout moves from at-a-glance performance (KPIs) → comparisons across sales amd products by regions and year → detailed insights (products and trends). This mirrors how business leaders consume information: big picture first, followed by details that explain the “why.”



Additional screenshots:  
![Top 10 Products](results/top_10_products_by_sales_.png)  

![Sales by Region](results/sales_by_region.png) 





