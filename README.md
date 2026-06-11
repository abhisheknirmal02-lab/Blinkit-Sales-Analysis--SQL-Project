# 🛒 Blinkit Sales Analysis — SQL Project

> A structured SQL project analysing **8,523 retail sales records** from Blinkit (India's quick-commerce platform) across outlet types, locations, item categories, fat content, and establishment years — using PostgreSQL.

---

## 📌 Project Overview

Blinkit operates thousands of dark stores across India's Tier 1, 2, and 3 cities. This project explores its retail sales dataset using pure SQL — no BI tool, no Python. The goal was to answer real business questions about outlet performance, product mix, and customer ratings through progressively complex queries.

**26 queries. 10 sections. One table. All SQL.**

---

## 🗂️ Dataset

| Attribute | Detail |
|---|---|
| Source | Blinkit Retail Sales Dataset (Kaggle) |
| Records | 8,523 rows |
| Table | `retail_sales` |
| Tool | PostgreSQL |

---

## 🧩 SQL Concepts Used

- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
- `CASE WHEN` for conditional aggregation and pivot tables
- `UPDATE` + `CASE WHEN` for data cleaning
- `CAST` + `DECIMAL` for formatted numeric output
- **Window Functions** — `SUM() OVER()` for sales percentage share
- **FILTER clause** (PostgreSQL) — cleaner alternative to `CASE WHEN` pivot
- `COUNT`, `SUM`, `AVG`, `DISTINCT`
- `LIMIT` for top-N results

---

## 📋 Business Questions Answered

### 🧹 Data Exploration & Cleaning
| # | Question |
|---|---|
| Q1 | Retrieve all raw records for initial data exploration |
| Q2 | How many total records are in the dataset? |
| Q3 | Standardise inconsistent `item_fat_content` values (LF, low fat, reg) |

### 📊 KPI Overview — All Years
| # | Question |
|---|---|
| Q4 | What is the total sales revenue (in Millions)? |
| Q5 | What is the average sales value per item? |
| Q6 | What is the total number of items in the dataset? |
| Q7 | What is the overall average customer rating? |

### 📅 KPI Overview — Year Filter (2022)
| # | Question |
|---|---|
| Q8 | Total sales for outlets established in 2022? |
| Q9 | Average sales for outlets established in 2022? |
| Q10 | Item count for outlets established in 2022? |

### 📈 Outlet Establishment Year Analysis
| # | Question |
|---|---|
| Q11 | KPIs (sales, avg sales, items, rating) by establishment year — ranked by revenue |
| Q12 | Year-over-year sales trend (chronological) |

### 🏪 Outlet Size Analysis
| # | Question |
|---|---|
| Q13 | Total sales and % share for each outlet size (Small / Medium / High) |

### 🥗 Fat Content Analysis
| # | Question |
|---|---|
| Q14 | Which fat content type — Low Fat or Regular — generates more sales? |
| Q15 | Full KPIs broken down by fat content (all years) |
| Q16 | Fat content KPIs for outlets established in 2022 |
| Q17 | Fat content KPIs in Thousands for outlets established in 2022 |

### 🍎 Item Type Analysis
| # | Question |
|---|---|
| Q18 | Which product categories generate the most sales overall? |
| Q19 | Top 5 best-selling item types in outlets established in 2022 |

### 📍 Outlet Location Analysis
| # | Question |
|---|---|
| Q20 | KPIs for each outlet location tier (Tier 1 / 2 / 3) |
| Q21 | Sales % share by location type for outlets established in 2022 |
| Q22 | Sales breakdown by location type + item type (combined grouping) |
| Q23 | Low Fat vs Regular sales pivot by location type (CASE WHEN) |
| Q24 | Low Fat vs Regular sales pivot by location type (FILTER clause) |
| Q25 | Full KPIs by location type + fat content combined |

### 🏬 Outlet Type Analysis
| # | Question |
|---|---|
| Q26 | Total sales, % share, avg sales, items, and rating by outlet type (Grocery Store / Supermarket Type 1/2/3) |

---

## 🔍 Sample Query — Sales % Share by Outlet Size (Window Function)

```sql
SELECT 
    outlet_size,
    CAST(SUM(sales) AS DECIMAL(10,2))                                        AS Total_Sales,
    CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER()) AS DECIMAL(10,2))    AS Sales_Percentage
FROM retail_sales
GROUP BY outlet_size
ORDER BY Total_Sales DESC;
```

---

## 🔍 Sample Query — Fat Content Pivot by Location Type (FILTER clause)

```sql
SELECT 
    outlet_location_type,
    SUM(sales) FILTER (WHERE item_fat_content = 'Low Fat') AS Low_Fat,
    SUM(sales) FILTER (WHERE item_fat_content = 'Regular') AS Regular
FROM retail_sales
GROUP BY outlet_location_type
ORDER BY outlet_location_type;
```

---

## 🚀 How to Run

1. Load the Blinkit retail sales dataset into PostgreSQL
2. Run **Q3 first** (Data Cleaning) — standardises `item_fat_content` before any analysis
3. Run any other query independently after that

---

## 📁 File Structure

📄 [Blinkit_SQL_Project.sql](https://github.com/abhisheknirmal02-lab/Blinkit-Sales-Analysis--SQL-Project/blob/main/Blinkit_SQL_Project.sql) — All 26 queries across 10 sections  
📋 [Blinkit_SQL_Project.docx](https://github.com/abhisheknirmal02-lab/Blinkit-Sales-Analysis--SQL-Project/blob/main/Blinkit_SQL_Project..docx) — Query documentation with result screenshots  
📝 README.md — Project documentation

---

## 💡 Key Findings

- **8,523 items** analysed across all outlet types and locations
- **Low Fat** items consistently outsell Regular items across all location tiers
- **Supermarket Type 1** accounts for the highest share of total sales among all outlet types
- **Tier 3** locations contribute a surprisingly strong revenue share despite lower urbanisation
- The **FILTER clause** (Q24) produces identical results to the `CASE WHEN` pivot (Q23) — but with cleaner, more readable SQL
- **Window functions** (Q13, Q21, Q26) eliminate the need for subqueries when calculating percentage share

---

## 🛠️ Tools

- **PostgreSQL**
- Dataset sourced from **Kaggle**

---

## 👤 Author

**Abhishek Nirmal**  
Aspiring Data Analyst | Power BI · SQL · Python · Advanced Excel  
📎 [GitHub](https://github.com/abhisheknirmal02-lab) | [LinkedIn](https://www.linkedin.com/in/abhishek-nirmal-3b6325370/)

---

*If you found this project useful, a ⭐ would mean a lot!*
