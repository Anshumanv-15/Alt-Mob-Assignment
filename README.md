# Alt Mobility - Data Analyst Intern Assignment

## Project Overview

This project fulfills the requirements for the Data Analyst Intern assignment at Alt Mobility. The primary goal was to analyze customer order, payment, and retention data to extract actionable insights, identify trends, and showcase technical skills in SQL and data visualization using Power BI. The analysis focuses on understanding order fulfillment, customer behavior, payment success, and long-term customer retention.

## Data Sources

The analysis is based on two primary CSV files:

1.  **`customer_orders.csv`**: Contains details about customer orders, including order ID, customer ID, order date, amount, status, and shipping address.
2.  **`payments.csv`**: Contains details about payment attempts associated with orders, including payment ID, order ID, payment date, amount, method, and status ('completed', 'failed', 'pending').

*   **Key Relationship:** The tables are joined using the `order_id` column.

## Tools Used

*   **SQL (MySQL Dialect):** Used for initial data exploration and addressing specific analytical questions related to order status, customer segmentation, payment analysis, and generating structured reports (Tasks 1-4).
*   **Microsoft Power BI:** Used for data modeling (via DAX), advanced analysis (especially cohort retention), and creating interactive visualizations and dashboards.

## Analysis Approach

### SQL Queries 

SQL was employed to perform the initial analytical tasks as outlined in the assignment brief:

1.  **Order and Sales Analysis:**
    *   Queries were written to determine the distribution of `order_status`.
    *   Monthly revenue trends were analyzed by joining orders with *completed* payments and aggregating `order_amount` by month.
    *   Average Order Value (AOV) for successfully paid orders was calculated.
2.  **Customer Analysis:**
    *   Queries explored the distribution of orders per customer.
    *   Repeat customers (those with > 1 order) were identified using `GROUP BY` and `HAVING`.
    *   Monthly new customer acquisition trends were analyzed by finding the `MIN(order_date)` per customer.
3.  **Payment Status Analysis:**
    *   Queries determined the distribution of `payment_status` across all attempts.
    *   Payment success rates were calculated per `payment_method` using `CASE WHEN` statements.
    *   Monthly trends in payment failures were investigated.
4.  **Order Details Report:**
    *   A comprehensive query using `LEFT JOIN` (or potentially `ROW_NUMBER` for latest payment status) was designed to combine order and relevant payment information for a detailed overview.

### Power BI Analysis & Visualizations 

Power BI was used to build upon the initial SQL exploration and create the final interactive dashboard and cohort analysis. Key steps included:

1.  **Data Loading & Transformation:** Loaded CSV files, ensuring correct data types, especially handling the `DD-MM-YYYY` date format using locale settings during import.
2.  **DAX Calculations:** Created calculated columns and measures to enable deeper analysis:
    *   `Customer First Purchase Date`: Determined the first order date for each unique customer.
    *   `Cohort Month`: Grouped customers based on the month of their first purchase.
    *   `Months Since First Order`: Calculated the time difference in months between a customer's first order and subsequent orders.
    *   `Total Customers`: Count of all unique customers.
    *   `Repeat Customers`: Count of customers with more than one order.
    *   `Overall Retention Rate`: Percentage of customers who are repeat buyers (`[Repeat Customers] / [Total Customers]`).
    *   `Retained Customers This Month`: Count of unique customers active in a given month whose first purchase was *before* that month.
    *   `Active Customers in Cohort`: Count of unique customers from a specific cohort active in a specific month offset.
3.  **Visualizations:**

    *   **Page 1: Dashboard Overview**
        *   **Gauge Chart (Overall Customer Retention Rate):** Displays the calculated `Overall Retention Rate` (shown as 60.02% in the screenshot) as a key performance indicator (KPI), providing a quick view of the percentage of customers making repeat purchases.
        *   **Column Chart (Retained Customers by Month):** Shows the trend of `Retained Customers This Month` over the calendar months. Helps visualize the monthly volume of repeat customer activity.
        *   **Column Chart (Retained Customers by Year):** Aggregates the `Retained Customers` by year, showing the longer-term trend in repeat business volume.

    *   **Page 2: Customer Cohort Retention Analysis (Task 5)**
        *   **Matrix (Heatmap):** Visualizes customer retention by cohort.
            *   **Rows:** `Cohort Month` (Month of first purchase).
            *   **Columns:** `Months Since First Order` (0, 1, 2,...).
            *   **Values:** `Active Customers in Cohort` (The number of unique customers from the cohort who made a purchase in that subsequent month). Conditional formatting is applied to the cell background (color intensity) based on this value, creating a heatmap effect to easily spot patterns in retention over time and across different cohorts.
