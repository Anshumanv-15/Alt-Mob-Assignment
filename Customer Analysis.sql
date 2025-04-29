--Orders Per Customer
WITH CustomerOrderCounts AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM customer_orders
    GROUP BY customer_id
)
SELECT
    total_orders,
    COUNT(customer_id) AS number_of_customers
FROM CustomerOrderCounts
GROUP BY total_orders
ORDER BY total_orders;

--Repeat Customers
SELECT
    customer_id,
    COUNT(order_id) AS number_of_orders
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY number_of_orders DESC;

--New Customer Aquisition
WITH FirstOrder AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM customer_orders
    GROUP BY customer_id
)
SELECT
    DATE_FORMAT(first_order_date, '%Y-%m-01') AS acquisition_month,
    COUNT(customer_id) AS new_customers
FROM FirstOrder
GROUP BY acquisition_month
ORDER BY acquisition_month;
