-- Order Fulfillment Analysis
SELECT
    order_status,
    COUNT(order_id) AS number_of_orders
FROM customer_orders
GROUP BY order_status
ORDER BY number_of_orders DESC;

--Monthly Rvenue Trend
SELECT
    DATE_FORMAT(co.order_date, '%Y-%m-01') AS order_month,
    SUM(co.order_amount) AS total_revenue,
    COUNT(DISTINCT co.order_id) AS number_of_orders
FROM customer_orders co
JOIN payments p ON co.order_id = p.order_id
WHERE p.payment_status = 'completed' -- Considering only successfully paid orders for revenue
GROUP BY order_month
ORDER BY order_month;

--Average Order Value(AOV) for completed payments
SELECT
    SUM(co.order_amount) / COUNT(DISTINCT co.order_id) AS average_order_value
FROM customer_orders co
JOIN payments p ON co.order_id = p.order_id
WHERE p.payment_status = 'completed';
