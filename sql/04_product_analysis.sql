USE electronics_retail;

-- Product-wise Analysis

SELECT
    f.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    p.brand,
    COUNT(*) AS valid_orders,
    SUM(f.quantity) AS valid_quantity,
    ROUND(SUM(f.total_amount), 2) AS valid_revenue,
    ROUND(SUM(f.profit_amount), 2) AS valid_profit,
    ROUND(AVG(f.total_amount), 2) AS avg_order_value
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
JOIN dim_product AS p
    ON f.product_id = p.product_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY
    f.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    p.brand
ORDER BY valid_revenue DESC;

--Revenue By Category

SELECT
    p.category,
    COUNT(*) AS valid_orders,
    SUM(f.quantity) AS valid_quantity,
    ROUND(SUM(f.total_amount), 2) AS valid_revenue
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
JOIN dim_product AS p
    ON f.product_id = p.product_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY p.category
ORDER BY valid_revenue DESC;

-- Profit Margin by Category

SELECT
    p.category,
    ROUND(SUM(f.total_amount), 2) AS valid_revenue,
    ROUND(SUM(f.profit_amount), 2) AS valid_profit,
    ROUND(
        SUM(f.profit_amount)
        / NULLIF(SUM(f.total_amount), 0) * 100,
        2
    ) AS profit_margin_pct
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
JOIN dim_product AS p
    ON f.product_id = p.product_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY p.category
ORDER BY profit_margin_pct DESC;

--Brandwise Analysis

SELECT
    p.brand,
    COUNT(*) AS valid_orders,
    SUM(f.quantity) AS valid_quantity,
    ROUND(SUM(f.total_amount), 2) AS valid_revenue,
    ROUND(SUM(f.profit_amount), 2) AS valid_profit,
    ROUND(
        SUM(f.profit_amount)
        / NULLIF(SUM(f.total_amount), 0) * 100,
        2
    ) AS profit_margin_pct,
    ROUND(
        SUM(f.total_amount) / NULLIF(COUNT(*), 0),
        2
    ) AS avg_order_value
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
JOIN dim_product AS p
    ON f.product_id = p.product_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY p.brand
ORDER BY valid_revenue DESC;
