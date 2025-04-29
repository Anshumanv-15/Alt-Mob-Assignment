WITH RankedPayments AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY payment_date DESC, CASE payment_status WHEN 'completed' THEN 1 WHEN 'pending' THEN 2 WHEN 'failed' THEN 3 ELSE 4 END) as rn
    FROM payments
)
SELECT
    co.order_id,
    co.customer_id,
    co.order_date,
    co.order_amount,
    co.order_status,
    rp.payment_date,  
    rp.payment_method,
    rp.payment_status,
    rp.payment_amount
FROM customer_orders co
LEFT JOIN RankedPayments rp ON co.order_id = rp.order_id AND rp.rn = 1
ORDER BY co.order_date DESC; 
