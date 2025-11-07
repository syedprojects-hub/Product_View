
# Product Performance Analytics View (`products_report`)

## Project Overview

This project builds a SQL analytical view named **`products_report`** to evaluate and monitor product-level performance using transactional sales data.
The view consolidates metrics such as total sales, orders, customers, revenue trends, and product lifecycle activity into a single, query-ready dataset.

---

## Business Objective

Organizations need a consistent method to understand which products generate revenue, how long they remain active in the market, and how they perform relative to others.
This view enables **data-driven product segmentation and revenue optimization** without manual aggregation.

---

## Methodology

1. **Data Integration** – Joined `sales_data` and `products` tables through `product_key`.
2. **Filtering** – Removed incomplete transactions with missing `order_date`.
3. **Aggregation** – Calculated total orders, total sales, total customers, and total quantities per product.
4. **Lifecycle Metrics** – Computed lifespan (in months) and last sale date.
5. **Performance Segmentation** – Categorized products as High, Mid-range, or Low performance based on total sales thresholds.
6. **KPI Computations** – Derived average order revenue, average monthly revenue, and recency in months.

---

## Key Metrics

* **total_sales** – Overall revenue generated per product
* **total_orders** – Number of unique orders containing the product
* **total_customers** – Distinct buyers per product
* **lifespan** – Duration between first and last sale (months)
* **recency_in_months** – Months since the last sale
* **avg_order_revenue** – Total sales divided by total orders
* **avg_monthly_revenue** – Monthly revenue trend
* **product_segment** – Performance classification by sales volume

---

## SQL Highlights

* Implemented **CTEs** (`base_query`, `product_aggregation`) for modular logic.
* Used **aggregate functions** and **date intervals** (`TIMESTAMPDIFF`) for lifecycle metrics.
* Applied **conditional logic** with `CASE WHEN` for product segmentation.
* Ensured **data accuracy** using `NULLIF` and rounded averages for clarity.

---

## Results and Impact

* Provides a **ready-to-query analytical layer** for business intelligence and dashboards.
* Supports **product lifecycle and profitability analysis**.
* Reduces manual data preparation time for performance reporting.
* Enables **data-driven decisions** on restocking, marketing, and discontinuation.

---

## Skills Demonstrated

SQL Data Modeling | Aggregation & CTEs | Business KPI Design | MySQL Functions | Data Analytics | Reporting Automation

---

## Next Steps

1. Integrate with BI tools (Power BI, Tableau) for visualization.
2. Automate view refresh in ETL pipelines.
3. Extend analysis with predictive modeling for product demand or sales forecasting.
4. Combine with `customer_report` for joint product-customer insights.

---

