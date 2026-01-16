Session 03: Data Analysis with SQL | Part I

● Tables customers, products, and sales already exist
● Their schemas and columns are already documented
● Your task is not discovery, but improvement, enforcement, and optimization

Task 1 | Enforce Missing Business Rules with ALTER TABLE
Business rules:

● Employees emails must be unique
ALTER TABLE employees
ADD CONSTRAINT uq_employees_email UNIQUE (email);

● Employee phone numbers must be mandatory
ALTER TABLE employees
ALTER COLUMN phone_number SET NOT NULL;

● Product prices must be non-negative
ALTER TABLE products
ADD CONSTRAINT chk_products_price CHECK (price >= 0);

● Sales totals must be non-negative
ALTER TABLE sales
ADD CONSTRAINT chk_sales_total CHECK (total_sales >= 0);

Task 2 | Add a New Analytical Attribute

The business now wants to analyze sales performance by channel.

Add a new column to the sales table:

Column name: sales_channel
Allowed values: 'online', 'store'

ALTER TABLE sales
ADD COLUMN sales_channel TEXT;

Add a constraint to enforce valid values.

ALTER TABLE sales
ADD CONSTRAINT chk_sales_channel
CHECK (sales_channel IN ('online', 'store'));

Populate the column with sample values.

UPDATE sales
SET sales_channel = 'online'
WHERE transaction_id % 2 = 0;

-- This allows analysis by sales channel (online/store)

Task 3 | Add Indexes for Query Performance
Based on common analytical queries, create indexes on columns that are frequently used for: - joins - grouping - filtering

CREATE INDEX idx_sales_product_id
ON sales (product_id);

CREATE INDEX idx_sales_customer_id
ON sales (customer_id);

CREATE INDEX idx_products_category
ON products (category);

Task 4 | Validate Index Usage with EXPLAIN
Run EXPLAIN on an aggregation query that is commonly used in reporting.

EXPLAIN
SELECT
  product_id,
  SUM(total_sales) AS total_revenue
FROM sales
GROUP BY product_id;

-- Sequential scan may be used if table is small
-- Index may not always be leveraged for aggregation
-- Planner chooses cheapest estimated execution plan

Task 5 | Reduce Query Cost by Refining SELECT
Rewrite a reporting query to avoid unnecessary data retrieval.

SELECT *
FROM sales;


SELECT
  transaction_id,
  product_id,
  total_sales
FROM sales;

-- Only needed columns are retrieved, reducing memory and I/O
-- SELECT * might still be acceptable in quick ad-hoc queries

Task 6 | ORDER BY and LIMIT for Business Questions

SELECT
  product_id,
  SUM(total_sales) AS total_revenue
FROM sales
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 5;

-- Sorting cost depends on number of products
-- Index on product_id helps aggregation but not sorting directly

Task 7 | DISTINCT vs GROUP BY (Efficiency Comparison)
Retrieve unique combinations of category and price using both approaches.

Using DISTINCT:

EXPLAIN
SELECT DISTINCT
  category,
  price
FROM products;

Using GROUP BY:

EXPLAIN
SELECT
  category,
  price
FROM products
GROUP BY category, price;

-- Interpretation:
-- Plans are often similar
-- Estimated cost is usually slightly lower for GROUP BY
-- PostgreSQL can optimize DISTINCT as a GROUP BY internally

Task 8 | Constraint Enforcement Test
Attempt to violate at least two constraints you added earlier and observe the errors.

UPDATE products
SET price = -5
WHERE product_id = 101;

-- CHECK constraint prevents negative prices
-- NOT NULL ensures required data is present
-- This protects data quality and business rules

Task 9 | Reflection (Short Answer)

-- Highest business value constraints: unique emails, NOT NULL phone numbers, CHECK for prices/totals
-- Priority index in production: idx_sales_product_id (used in most joins and aggregations)
-- Signals for optimization: slow query runtime, sequential scans on large tables, high memory usage
