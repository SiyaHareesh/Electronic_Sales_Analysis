USE electronics_retail;

--Calculation of key metrics

SELECT 
 COUNT(*) AS total_orders,  # Total order = total sales as established
 SUM(f.quantity) AS total_quantity,
 SUM(f.total_amount) AS total_revenue,
 SUM(f.profit_amount) AS total_profit,
 AVG(f.total_amount) AS avg_order_value
FROM fact_sales as f
JOIN dim_order as o
 ON f.order_id=o.order_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned');

--Calculation of profit margin

SELECT
    ROUND(
        SUM(f.profit_amount)
        / NULLIF(SUM(f.total_amount), 0) * 100,
        2
    ) AS profit_margin_pct
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned');

--Monthly Revenue 
  
SELECT 
    YEAR(d.full_date) AS sales_year,
    MONTHNAME(d.full_date) AS sales_month,
    DATE_FORMAT(d.full_date, '%Y-%m') AS month_label,
    COUNT(*) AS monthly_orders,
    SUM(f.total_amount) AS monthly_revenue
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
JOIN dim_date AS d
    ON f.date_id = d.date_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY
    YEAR(d.full_date),
    MONTH(d.full_date),
    MONTHNAME(d.full_date),
    DATE_FORMAT(d.full_date, '%Y-%m')
ORDER BY
    sales_year,
    MONTH(d.full_date);

--YoY Revenue
  
 WITH yearly_revenue AS (
    SELECT
        YEAR(d.full_date) AS sales_year,
        SUM(f.total_amount) AS total_revenue
    FROM fact_sales AS f
    JOIN dim_order AS o
        ON f.order_id = o.order_id
    JOIN dim_date AS d
        ON f.date_id = d.date_id
    WHERE o.order_status NOT IN ('Cancelled', 'Returned')
    GROUP BY YEAR(d.full_date)
)
SELECT
    sales_year,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY sales_year))
        / NULLIF(LAG(total_revenue) OVER (ORDER BY sales_year),0 ) * 100,2
    ) AS yoy_revenue_growth_pct
FROM yearly_revenue
ORDER BY sales_year;

