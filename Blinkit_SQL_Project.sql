-- ============================================================
-- 🛒 BLINKIT SALES ANALYSIS — SQL PROJECT
-- Author  : Abhishek Shivmangal Nirmal
-- Tool    : PostgreSQL
-- Dataset : Blinkit Retail Sales Data (8,523 records)
-- GitHub  : https://github.com/abhisheknirmal02-lab
-- ============================================================


-- ============================================================
-- 📋 SECTION 1 : DATA EXPLORATION
-- ============================================================

-- Q1. Retrieve all records from the dataset to explore the raw data.
SELECT * FROM retail_sales;

-- Q2. How many total records (rows) are present in the dataset?
SELECT COUNT(*) FROM retail_sales;


-- ============================================================
-- 🧹 SECTION 2 : DATA CLEANING
-- ============================================================

-- Q3. Standardize the 'Item Fat Content' column — 
--     fix inconsistent values like 'LF', 'low fat', and 'reg'
--     to uniform labels 'Low Fat' and 'Regular'.
UPDATE retail_sales
SET item_fat_content = 
    CASE
        WHEN item_fat_content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN item_fat_content = 'reg'              THEN 'Regular'
        ELSE item_fat_content
    END;


-- ============================================================
-- 📊 SECTION 3 : KEY PERFORMANCE INDICATORS (KPIs)
-- ============================================================

-- Q4. What is the total sales revenue generated (in Millions)?
SELECT CAST(SUM(sales) / 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM retail_sales;

-- Q5. What is the average sales value per item?
SELECT CAST(AVG(sales) AS DECIMAL(10,1)) AS Avg_Sales
FROM retail_sales;

-- Q6. What is the total number of items available in the dataset?
SELECT COUNT(*) AS No_of_Items
FROM retail_sales;

-- Q7. What is the overall average customer rating across all products?
SELECT CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales;


-- ============================================================
-- 📅 SECTION 4 : YEAR-WISE FILTERED KPIs (Outlet Est. Year 2022)
-- ============================================================

-- Q8. What is the total sales revenue for outlets established in 2022?
SELECT CAST(SUM(sales) / 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM retail_sales
WHERE outlet_establishment_year = 2022;

-- Q9. What is the average sales value for outlets established in 2022?
SELECT CAST(AVG(sales) AS DECIMAL(10,1)) AS Avg_Sales
FROM retail_sales
WHERE outlet_establishment_year = 2022;

-- Q10. How many items are sold through outlets established in 2022?
SELECT COUNT(*) AS No_of_Items
FROM retail_sales
WHERE outlet_establishment_year = 2022;


-- ============================================================
-- 📈 SECTION 5 : OUTLET ESTABLISHMENT YEAR ANALYSIS
-- ============================================================

-- Q11. What are the total sales, average sales, item count, and 
--      average rating for each outlet establishment year?
--      (Sorted by highest total sales)
SELECT 
    outlet_establishment_year,
    CAST(SUM(sales)    AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)    AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                             AS No_of_Items,
    CAST(AVG(rating)   AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY outlet_establishment_year
ORDER BY Total_Sales DESC;

-- Q12. How have total sales trended year-over-year by outlet establishment year?
--      (Sorted chronologically)
SELECT 
    outlet_establishment_year,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales
FROM retail_sales
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year ASC;


-- ============================================================
-- 🏪 SECTION 6 : OUTLET SIZE ANALYSIS
-- ============================================================

-- Q13. What is the total sales and percentage share of sales 
--      for each outlet size (Small / Medium / High)?
SELECT 
    outlet_size,
    CAST(SUM(sales) AS DECIMAL(10,2))                                        AS Total_Sales,
    CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER()) AS DECIMAL(10,2))    AS Sales_Percentage
FROM retail_sales
GROUP BY outlet_size
ORDER BY Total_Sales DESC;


-- ============================================================
-- 🥗 SECTION 7 : FAT CONTENT ANALYSIS
-- ============================================================

-- Q14. Which fat content type (Low Fat vs Regular) generates more sales?
SELECT 
    item_fat_content,
    CAST(SUM(sales) AS DECIMAL(10,2)) AS Sales
FROM retail_sales
GROUP BY item_fat_content
ORDER BY Sales DESC;

-- Q15. What are the detailed KPIs (sales, avg sales, item count, rating)
--      broken down by fat content type?
SELECT 
    item_fat_content,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY item_fat_content
ORDER BY Total_Sales DESC;

-- Q16. What are the fat content KPIs specifically for 
--      outlets established in 2022?
SELECT 
    item_fat_content,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
WHERE outlet_establishment_year = 2022
GROUP BY item_fat_content
ORDER BY Total_Sales DESC;

-- Q17. What are the fat content KPIs (in Thousands) for 
--      outlets established in 2022?
SELECT 
    item_fat_content,
    CAST(SUM(sales) / 1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    CAST(AVG(sales)        AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                                 AS No_of_Items,
    CAST(AVG(rating)       AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
WHERE outlet_establishment_year = 2022
GROUP BY item_fat_content
ORDER BY Total_Sales_Thousands DESC;


-- ============================================================
-- 🍎 SECTION 8 : ITEM TYPE ANALYSIS
-- ============================================================

-- Q18. Which item categories (e.g. Fruits, Dairy, Snacks) 
--      generate the most sales overall?
SELECT 
    item_type,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY item_type
ORDER BY Total_Sales DESC;

-- Q19. What are the top 5 best-selling item types in outlets 
--      established in 2022?
SELECT 
    item_type,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
WHERE outlet_establishment_year = 2022
GROUP BY item_type
ORDER BY Total_Sales DESC
LIMIT 5;


-- ============================================================
-- 📍 SECTION 9 : OUTLET LOCATION ANALYSIS
-- ============================================================

-- Q20. What are the total sales, average sales, item count, and 
--      average rating for each outlet location type (Tier 1/2/3)?
SELECT 
    outlet_location_type,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY outlet_location_type
ORDER BY Total_Sales DESC;

-- Q21. What is the sales percentage share for each outlet location type
--      for outlets established in 2022?
SELECT 
    outlet_location_type,
    CAST(SUM(sales)                                                       AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER())                   AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(sales)                                                       AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                                                                                AS No_of_Items,
    CAST(AVG(rating)                                                      AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
WHERE outlet_establishment_year = 2022
GROUP BY outlet_location_type
ORDER BY Total_Sales DESC;

-- Q22. How do sales break down by both outlet location type 
--      AND item type combined?
SELECT 
    outlet_location_type,
    item_type,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY outlet_location_type, item_type
ORDER BY Total_Sales DESC;

-- Q23. How do Low Fat vs Regular sales compare 
--      across each outlet location type? (Using CASE WHEN)
SELECT 
    outlet_location_type,
    SUM(CASE WHEN item_fat_content = 'Low Fat'  THEN sales ELSE 0 END) AS Low_Fat,
    SUM(CASE WHEN item_fat_content = 'Regular'  THEN sales ELSE 0 END) AS Regular
FROM retail_sales
GROUP BY outlet_location_type
ORDER BY outlet_location_type;

-- Q24. How do Low Fat vs Regular sales compare across outlet 
--      location types? (Using PostgreSQL FILTER clause — cleaner syntax)
SELECT 
    outlet_location_type,
    SUM(sales) FILTER (WHERE item_fat_content = 'Low Fat') AS Low_Fat,
    SUM(sales) FILTER (WHERE item_fat_content = 'Regular') AS Regular
FROM retail_sales
GROUP BY outlet_location_type
ORDER BY outlet_location_type;

-- Q25. How do fat content sales break down by outlet location 
--      type AND fat content combined?
SELECT 
    outlet_location_type,
    item_fat_content,
    CAST(SUM(sales)  AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(sales)  AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                           AS No_of_Items,
    CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY outlet_location_type, item_fat_content
ORDER BY Total_Sales ASC;


-- ============================================================
-- 🏬 SECTION 10 : OUTLET TYPE ANALYSIS
-- ============================================================

-- Q26. What are the total sales, sales percentage, average sales,
--      item count, and average rating for each outlet type
--      (Grocery Store / Supermarket Type 1/2/3)?
SELECT 
    outlet_type,
    CAST(SUM(sales)                                                    AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER())                AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(sales)                                                    AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*)                                                                             AS No_of_Items,
    CAST(AVG(rating)                                                   AS DECIMAL(10,2)) AS Avg_Rating
FROM retail_sales
GROUP BY outlet_type
ORDER BY Total_Sales DESC;


-- ============================================================
-- ✅ END OF BLINKIT SQL ANALYSIS PROJECT
-- 26 Queries | 10 Sections | 8,523 Records
-- ============================================================
