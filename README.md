# Electronics Retail Sales Dashboard

An end-to-end data analytics project using **MySQL, SQL, and Power BI** to analyze electronics retail sales and translate data into actionable business insights.

## Overview

Performed end-to-end analysis of an electronics retail dataset using MySQL and Power BI. Developed a relational database, analyzed key business metrics, and built an interactive dashboard covering sales, customers, products, and stores.

The project focuses on understanding revenue performance, profitability, customer value, product contribution, and store-level performance.

## Dashboard Preview

The Power BI dashboard is organized into four analytical sections:

| Section                  | Focus                                                              |
| ------------------------ | ------------------------------------------------------------------ |
| Executive Overview       | Revenue, profit, orders, monthly trends, and year-over-year growth |
| Customer Analysis        | Customer value, ordering behaviour, and revenue segmentation       |
| Product Analysis         | Product, category, and brand performance                           |
| Store & Channel Analysis | Store-level performance and online versus physical revenue         |

## Key Analysis

* Calculated total orders, quantity, revenue, profit, average order value, and profit margin.
* Analyzed monthly revenue and year-over-year revenue growth.
* Identified top customers based on valid revenue.
* Segmented customers into **High, Medium, and Low Value** groups using revenue quintiles.
* Compared product categories and brands by revenue, quantity, profit, and profitability.
* Analyzed return rates across product categories.
* Compared revenue and profit across individual stores and store types.
* Created an **Online vs Physical** channel comparison.

## Data Source

The dataset was sourced from Kaggle:

**[Online/offline sales data analysis](https://www.kaggle.com/datasets/mayur2303/onlineoffline-sales-data-analysis)**

## Project Structure

```text
electronics-retail-dashboard/
│
├── README.md
│
├── sql/
│   ├── 02_create_tables.sql
│   ├── 03_overview_analysis.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_product_analysis.sql
│   └── 06_store_analysis.sql
│
└── powerbi/
    └── electronics_retail_dashboard.pbix
```

## SQL Analysis

The SQL scripts cover:

1. **Database and table creation** — Relational schema with dimension and fact tables.
2. **Executive overview** — Key metrics, monthly revenue, and year-over-year growth.
3. **Customer analysis** — Customer metrics, top customers, and revenue quintile segmentation.
4. **Product analysis** — Product, category, and brand-level performance.
5. **Store analysis** — Store and store-type revenue and profitability.




