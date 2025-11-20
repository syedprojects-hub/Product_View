-- Creates a product performance view in MySQL
CREATE VIEW product_report AS

-- Step 1: Extract sales and product information needed for analysis
WITH base_query AS (
    SELECT
        f.order_number,        -- Order ID associated with transaction
        f.order_date,          -- Date when the sale occurred
        f.customer_key,        -- Customer involved in the purchase
        f.sales_amount,        -- Revenue from the order line
        f.quantity,            -- Units sold in the order
        p.product_key,         -- Product identifier
        p.product_name,        -- Name of the product
        p.category,            -- Product category
        p.subcategory,         -- Product subcategory
        p.cost                 -- Cost to company
    FROM sales f
    LEFT JOIN products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL    -- Ensures only valid dated records
),

-- Step 2: Aggregate data to get product-level metrics
product_aggregations AS (
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,

        -- Duration between first and last recorded sale
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,

        MAX(order_date) AS last_sale_date,        -- Latest sale activity

        COUNT(DISTINCT order_number) AS total_orders,    -- Number of orders
        COUNT(DISTINCT customer_key) AS total_customers, -- Number of buyers
        SUM(sales_amount) AS total_sales,                -- Total revenue
        SUM(quantity) AS total_quantity,                 -- Total units sold

        -- Average selling price (sale amount divided by quantity)
        ROUND(
            AVG((sales_amount) / NULLIF(quantity, 0)),
            1
        ) AS avg_selling_price

    FROM base_query
    GROUP BY product_key, product_name, category, subcategory, cost
)

-- Step 3: Output aggregated metrics with product segmentation
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,

    -- Months since the most recent sale
    TIMESTAMPDIFF(MONTH, last_sale_date, CURDATE()) AS recency_in_months,

    -- Categorization based on revenue performance
    CASE
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,

    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,

    -- Average revenue per order
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue,

    -- Revenue spread across active months
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue

FROM product_aggregations;
