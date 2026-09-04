USE electronics_retail;

-- Revenue by store

SELECT
    s.store_id,
    s.store_name,
    s.store_type,
    COUNT(*) AS valid_orders,
    SUM(f.quantity) AS valid_quantity,
    ROUND(SUM(f.total_amount), 2) AS valid_revenue,
    ROUND(SUM(f.profit_amount), 2) AS valid_profit,
    ROUND(
        SUM(f.profit_amount)/ NULLIF(SUM(f.total_amount), 0) * 100,2
    ) AS profit_margin_pct
FROM fact_sales AS f
JOIN dim_order AS o
    ON f.order_id = o.order_id
JOIN dim_store AS s
    ON f.store_id = s.store_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY
    s.store_id,
    s.store_name,
    s.store_type
ORDER BY valid_revenue DESC;

--Revenue by store type:

SELECT
    s.store_type,
    COUNT(DISTINCT s.store_id) AS number_of_stores,
    COUNT(*) AS valid_orders,
    SUM(f.quantity) AS valid_quantity,
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
JOIN dim_store AS s
    ON f.store_id = s.store_id
WHERE o.order_status NOT IN ('Cancelled', 'Returned')
GROUP BY s.store_type
ORDER BY valid_revenue DESC;
