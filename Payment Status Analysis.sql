--Payment Status Distribution
SELECT
    payment_status,
    COUNT(payment_id) AS number_of_payments,
    SUM(payment_amount) AS total_value 
FROM payments
GROUP BY payment_status
ORDER BY number_of_payments DESC;

--Payment Success Rate For Each Method
SELECT
    payment_method,
    COUNT(payment_id) AS total_attempts,
    SUM(CASE WHEN payment_status = 'completed' THEN 1 ELSE 0 END) AS successful_payments,
    SUM(CASE WHEN payment_status = 'failed' THEN 1 ELSE 0 END) AS failed_payments,
    SUM(CASE WHEN payment_status = 'pending' THEN 1 ELSE 0 END) AS pending_payments, -- If applicable
    (SUM(CASE WHEN payment_status = 'completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(payment_id)) AS success_rate_percent
FROM payments
GROUP BY payment_method
ORDER BY total_attempts DESC;

--Monthly Trend In Payment Failures
SELECT
    DATE_FORMAT(payment_date, '%Y-%m-01') AS payment_month,
    COUNT(payment_id) AS total_payments,
    SUM(CASE WHEN payment_status = 'failed' THEN 1 ELSE 0 END) AS failed_payments,
    (SUM(CASE WHEN payment_status = 'failed' THEN 1 ELSE 0 END) * 100.0 / COUNT(payment_id)) AS failure_rate_percent
FROM payments
GROUP BY payment_month
ORDER BY payment_month;
