# SQL Interview Cheat Sheet

## Table of Contents
1. [Basic Queries](#basic-queries)
2. [Filtering & Conditions](#filtering--conditions)
3. [Aggregations](#aggregations)
4. [Joins](#joins)
5. [Subqueries & CTEs](#subqueries--ctes)
6. [Window Functions](#window-functions)
7. [String Functions](#string-functions)
8. [Date Functions](#date-functions)
9. [Data Types & Constraints](#data-types--constraints)
10. [Common Interview Patterns](#common-interview-patterns)

---

## Basic Queries

### SELECT Statement
```sql
-- Select all columns
SELECT * FROM table_name;

-- Select specific columns
SELECT column1, column2 FROM table_name;

-- Select with aliases
SELECT column1 AS alias1, column2 AS alias2 FROM table_name;

-- Select distinct values
SELECT DISTINCT column1 FROM table_name;

-- Select with calculations
SELECT column1, column2, column1 + column2 AS total FROM table_name;
```

### LIMIT & OFFSET
```sql
-- Limit number of rows
SELECT * FROM table_name LIMIT 10;

-- Skip rows and limit
SELECT * FROM table_name LIMIT 10 OFFSET 20;  -- Skip 20, return 10
```

### ORDER BY
```sql
-- Sort ascending (default)
SELECT * FROM table_name ORDER BY column1;

-- Sort descending
SELECT * FROM table_name ORDER BY column1 DESC;

-- Multiple sort columns
SELECT * FROM table_name ORDER BY column1 DESC, column2 ASC;
```

---

## Filtering & Conditions

### WHERE Clause
```sql
-- Comparison operators: =, !=, <>, <, >, <=, >=
SELECT * FROM table_name WHERE column1 = 'value';
SELECT * FROM table_name WHERE column1 > 100;

-- String comparison (alphabetical)
SELECT * FROM table_name WHERE name > 'J';  -- 'Ja' > 'J'
```

### Logical Operators

#### AND, OR, NOT
```sql
SELECT * FROM table_name 
WHERE column1 = 'value1' AND column2 > 100;

SELECT * FROM table_name 
WHERE column1 = 'value1' OR column2 > 100;

SELECT * FROM table_name 
WHERE NOT column1 = 'value1';
```

#### LIKE & ILIKE (Pattern Matching)
```sql
-- LIKE (case-sensitive), ILIKE (case-insensitive)
-- % matches any sequence of characters
-- _ matches any single character

SELECT * FROM table_name WHERE name LIKE 'John%';      -- Starts with John
SELECT * FROM table_name WHERE name LIKE '%Smith';      -- Ends with Smith
SELECT * FROM table_name WHERE name LIKE '%John%';      -- Contains John
SELECT * FROM table_name WHERE name LIKE 'J_n';         -- J, any char, n
SELECT * FROM table_name WHERE name ILIKE 'john%';      -- Case-insensitive
```

#### IN
```sql
-- Match any value in a list
SELECT * FROM table_name WHERE column1 IN (1, 2, 3, 4);
SELECT * FROM table_name WHERE column1 IN ('A', 'B', 'C');
```

#### BETWEEN
```sql
-- Inclusive range
SELECT * FROM table_name WHERE column1 BETWEEN 10 AND 20;
-- Equivalent to: column1 >= 10 AND column1 <= 20
```

#### IS NULL / IS NOT NULL
```sql
-- Check for NULL values
SELECT * FROM table_name WHERE column1 IS NULL;
SELECT * FROM table_name WHERE column1 IS NOT NULL;

-- ⚠️ Never use = NULL or != NULL (always returns NULL/false)
```

---

## Aggregations

### Aggregate Functions
```sql
-- COUNT: Count rows (NULL values are ignored)
SELECT COUNT(*) FROM table_name;                    -- Count all rows
SELECT COUNT(column1) FROM table_name;              -- Count non-NULL values

-- SUM: Sum of values
SELECT SUM(column1) FROM table_name;

-- AVG: Average (ignores NULL)
SELECT AVG(column1) FROM table_name;

-- MIN/MAX: Minimum/Maximum
SELECT MIN(column1), MAX(column1) FROM table_name;

-- Standard deviation
SELECT STDDEV(column1) FROM table_name;
SELECT STDDEV_POP(column1) FROM table_name;        -- Population stddev
```

### GROUP BY
```sql
-- Group by single column
SELECT column1, COUNT(*) AS count
FROM table_name
GROUP BY column1;

-- Group by multiple columns
SELECT column1, column2, COUNT(*) AS count
FROM table_name
GROUP BY column1, column2;

-- ⚠️ All non-aggregated columns must be in GROUP BY
```

### HAVING
```sql
-- Filter aggregated results (WHERE filters before aggregation)
SELECT column1, COUNT(*) AS count
FROM table_name
GROUP BY column1
HAVING COUNT(*) > 10;

-- Can use aggregate functions in HAVING
SELECT column1, AVG(column2) AS avg_val
FROM table_name
GROUP BY column1
HAVING AVG(column2) > 100;
```

### Query Execution Order
```
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT
```

---

## Joins

### INNER JOIN
```sql
-- Returns only matching rows from both tables
SELECT t1.column1, t2.column2
FROM table1 t1
INNER JOIN table2 t2 ON t1.id = t2.id;

-- Alternative syntax (not recommended)
SELECT t1.column1, t2.column2
FROM table1 t1, table2 t2
WHERE t1.id = t2.id;
```

### LEFT JOIN (LEFT OUTER JOIN)
```sql
-- Returns all rows from left table + matching rows from right
SELECT t1.column1, t2.column2
FROM table1 t1
LEFT JOIN table2 t2 ON t1.id = t2.id;
-- NULL values for non-matching right table rows
```

### RIGHT JOIN (RIGHT OUTER JOIN)
```sql
-- Returns all rows from right table + matching rows from left
SELECT t1.column1, t2.column2
FROM table1 t1
RIGHT JOIN table2 t2 ON t1.id = t2.id;
```

### FULL OUTER JOIN
```sql
-- Returns all rows from both tables
SELECT t1.column1, t2.column2
FROM table1 t1
FULL OUTER JOIN table2 t2 ON t1.id = t2.id;
```

### CROSS JOIN
```sql
-- Cartesian product (all combinations)
SELECT t1.column1, t2.column2
FROM table1 t1
CROSS JOIN table2 t2;
```

### Self Join
```sql
-- Join table to itself
SELECT e1.name AS employee, e2.name AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.id;
```

### Multiple Joins
```sql
SELECT t1.col1, t2.col2, t3.col3
FROM table1 t1
INNER JOIN table2 t2 ON t1.id = t2.id
LEFT JOIN table3 t3 ON t2.id = t3.id;
```

---

## Subqueries & CTEs

### Subqueries in WHERE
```sql
-- Scalar subquery (returns single value)
SELECT * FROM table1
WHERE column1 > (SELECT AVG(column1) FROM table1);

-- IN subquery
SELECT * FROM table1
WHERE column1 IN (SELECT id FROM table2 WHERE condition);

-- EXISTS subquery
SELECT * FROM table1 t1
WHERE EXISTS (SELECT 1 FROM table2 t2 WHERE t2.id = t1.id);
```

### Subqueries in SELECT
```sql
-- Correlated subquery
SELECT column1,
       (SELECT COUNT(*) FROM table2 WHERE table2.id = table1.id) AS count
FROM table1;
```

### Common Table Expressions (CTEs)
```sql
-- WITH clause (CTE)
WITH cte_name AS (
    SELECT column1, column2
    FROM table1
    WHERE condition
)
SELECT * FROM cte_name;

-- Multiple CTEs
WITH cte1 AS (
    SELECT * FROM table1
),
cte2 AS (
    SELECT * FROM table2
)
SELECT * FROM cte1 JOIN cte2 ON cte1.id = cte2.id;

-- Recursive CTE (for hierarchical data)
WITH RECURSIVE hierarchy AS (
    -- Base case
    SELECT id, name, parent_id, 1 AS level
    FROM employees
    WHERE parent_id IS NULL
    
    UNION ALL
    
    -- Recursive case
    SELECT e.id, e.name, e.parent_id, h.level + 1
    FROM employees e
    JOIN hierarchy h ON e.parent_id = h.id
)
SELECT * FROM hierarchy;
```

---

## Window Functions

### Basic Window Functions
```sql
-- ROW_NUMBER: Sequential numbering
SELECT column1,
       ROW_NUMBER() OVER (ORDER BY column2) AS row_num
FROM table_name;

-- RANK: Ranking with gaps (1, 2, 2, 4)
SELECT column1,
       RANK() OVER (ORDER BY column2 DESC) AS rank
FROM table_name;

-- DENSE_RANK: Ranking without gaps (1, 2, 2, 3)
SELECT column1,
       DENSE_RANK() OVER (ORDER BY column2 DESC) AS dense_rank
FROM table_name;

-- PERCENT_RANK: Relative rank (0 to 1)
SELECT column1,
       PERCENT_RANK() OVER (ORDER BY column2) AS pct_rank
FROM table_name;
```

### Aggregate Window Functions
```sql
-- Running totals
SELECT column1, column2,
       SUM(column2) OVER (ORDER BY column1) AS running_total
FROM table_name;

-- Window partitions
SELECT column1, column2,
       SUM(column2) OVER (PARTITION BY column1) AS partition_sum
FROM table_name;

-- Moving averages
SELECT column1, column2,
       AVG(column2) OVER (ORDER BY column1 
                          ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM table_name;
```

### Window Frame Specifications
```sql
-- ROWS BETWEEN
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  -- All previous + current
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING         -- Previous, current, next
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING -- Current + all following

-- RANGE BETWEEN (for values, not rows)
RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
```

### LAG & LEAD
```sql
-- Previous/Next row values
SELECT column1, column2,
       LAG(column2, 1) OVER (ORDER BY column1) AS prev_value,
       LEAD(column2, 1) OVER (ORDER BY column1) AS next_value
FROM table_name;
```

### FIRST_VALUE & LAST_VALUE
```sql
SELECT column1, column2,
       FIRST_VALUE(column2) OVER (PARTITION BY column1 ORDER BY column2) AS first_val,
       LAST_VALUE(column2) OVER (PARTITION BY column1 ORDER BY column2 
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val
FROM table_name;
```

---

## String Functions

### Common String Functions
```sql
-- LENGTH / LEN
SELECT LENGTH('Hello');  -- Returns 5

-- UPPER / LOWER
SELECT UPPER('hello'), LOWER('HELLO');

-- TRIM / LTRIM / RTRIM
SELECT TRIM('  hello  ');      -- 'hello'
SELECT LTRIM('  hello');        -- 'hello'
SELECT RTRIM('hello  ');        -- 'hello'

-- SUBSTRING / SUBSTR
SELECT SUBSTRING('Hello World', 1, 5);  -- 'Hello'
SELECT SUBSTRING('Hello World', 7);     -- 'World'

-- REPLACE
SELECT REPLACE('Hello World', 'World', 'SQL');  -- 'Hello SQL'

-- CONCAT / ||
SELECT CONCAT('Hello', ' ', 'World');  -- 'Hello World'
SELECT 'Hello' || ' ' || 'World';      -- 'Hello World'

-- SPLIT_PART (PostgreSQL)
SELECT SPLIT_PART('a,b,c', ',', 2);  -- 'b'

-- POSITION / CHARINDEX
SELECT POSITION('World' IN 'Hello World');  -- Returns 7
```

---

## Date Functions

### Date Extraction
```sql
-- EXTRACT
SELECT EXTRACT(YEAR FROM date_column) AS year,
       EXTRACT(MONTH FROM date_column) AS month,
       EXTRACT(DAY FROM date_column) AS day,
       EXTRACT(DOW FROM date_column) AS day_of_week  -- 0=Sunday
FROM table_name;

-- DATE_PART (PostgreSQL)
SELECT DATE_PART('year', date_column) AS year;

-- YEAR, MONTH, DAY (SQL Server)
SELECT YEAR(date_column), MONTH(date_column), DAY(date_column);
```

### Date Arithmetic
```sql
-- Add/Subtract intervals
SELECT date_column + INTERVAL '1 day';
SELECT date_column + INTERVAL '1 month';
SELECT date_column - INTERVAL '7 days';

-- DATEADD (SQL Server)
SELECT DATEADD(day, 1, date_column);
SELECT DATEADD(month, -1, date_column);

-- DATEDIFF
SELECT DATEDIFF('day', start_date, end_date);
SELECT DATEDIFF('month', start_date, end_date);
```

### Date Formatting
```sql
-- TO_CHAR (PostgreSQL)
SELECT TO_CHAR(date_column, 'YYYY-MM-DD');
SELECT TO_CHAR(date_column, 'Month DD, YYYY');

-- FORMAT (SQL Server)
SELECT FORMAT(date_column, 'yyyy-MM-dd');
```

### Current Date/Time
```sql
-- PostgreSQL
SELECT CURRENT_DATE;
SELECT CURRENT_TIMESTAMP;
SELECT NOW();

-- SQL Server
SELECT GETDATE();
SELECT GETUTCDATE();
```

---

## CASE Statements

### Basic CASE
```sql
SELECT column1,
       CASE 
           WHEN column1 > 100 THEN 'High'
           WHEN column1 > 50 THEN 'Medium'
           ELSE 'Low'
       END AS category
FROM table_name;
```

### CASE with Aggregates
```sql
-- Conditional counting
SELECT 
    COUNT(CASE WHEN status = 'Active' THEN 1 END) AS active_count,
    COUNT(CASE WHEN status = 'Inactive' THEN 1 END) AS inactive_count
FROM table_name;

-- Data pivoting
SELECT 
    SUM(CASE WHEN year = 2020 THEN sales END) AS sales_2020,
    SUM(CASE WHEN year = 2021 THEN sales END) AS sales_2021,
    SUM(CASE WHEN year = 2022 THEN sales END) AS sales_2022
FROM sales_table
GROUP BY region;
```

---

## Data Types & Constraints

### Common Data Types
```sql
-- Numeric
INTEGER / INT
BIGINT
SMALLINT
DECIMAL(p, s) / NUMERIC(p, s)  -- p=precision, s=scale
FLOAT / REAL
DOUBLE PRECISION

-- String
VARCHAR(n)      -- Variable length, max n
CHAR(n)         -- Fixed length n
TEXT            -- Unlimited length

-- Date/Time
DATE
TIME
TIMESTAMP
TIMESTAMPTZ     -- With timezone

-- Boolean
BOOLEAN / BOOL

-- JSON (PostgreSQL)
JSON
JSONB
```

### Constraints
```sql
-- Primary Key
CREATE TABLE table_name (
    id INTEGER PRIMARY KEY
);

-- Foreign Key
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id)
);

-- NOT NULL
CREATE TABLE table_name (
    name VARCHAR(100) NOT NULL
);

-- UNIQUE
CREATE TABLE table_name (
    email VARCHAR(100) UNIQUE
);

-- CHECK
CREATE TABLE table_name (
    age INTEGER CHECK (age >= 0)
);

-- DEFAULT
CREATE TABLE table_name (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## Common Interview Patterns

### Find Duplicates
```sql
-- Using GROUP BY
SELECT column1, COUNT(*) AS count
FROM table_name
GROUP BY column1
HAVING COUNT(*) > 1;

-- Using window functions
SELECT column1, column2
FROM (
    SELECT column1, column2,
           ROW_NUMBER() OVER (PARTITION BY column1 ORDER BY column2) AS rn
    FROM table_name
) t
WHERE rn > 1;
```

### Find Nth Highest/Lowest
```sql
-- Nth highest using window function
SELECT column1, column2
FROM (
    SELECT column1, column2,
           DENSE_RANK() OVER (ORDER BY column2 DESC) AS rk
    FROM table_name
) t
WHERE rk = 3;  -- 3rd highest

-- Alternative using LIMIT
SELECT column2
FROM table_name
ORDER BY column2 DESC
LIMIT 1 OFFSET 2;  -- 3rd highest (0-indexed offset)
```

### Running Totals / Cumulative Sums
```sql
SELECT date, amount,
       SUM(amount) OVER (ORDER BY date) AS running_total
FROM transactions;
```

### Compare Current vs Previous Row
```sql
SELECT date, value,
       LAG(value, 1) OVER (ORDER BY date) AS prev_value,
       value - LAG(value, 1) OVER (ORDER BY date) AS difference
FROM table_name;
```

### Top N per Group
```sql
-- Using window functions
SELECT name, category, price
FROM (
    SELECT name, category, price,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS rn
    FROM products
) t
WHERE rn <= 3;  -- Top 3 per category
```

### Self-Referencing (Hierarchical)
```sql
-- Find all subordinates of a manager
WITH RECURSIVE subordinates AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id = 1  -- Starting manager
    
    UNION ALL
    
    SELECT e.id, e.name, e.manager_id
    FROM employees e
    JOIN subordinates s ON e.manager_id = s.id
)
SELECT * FROM subordinates;
```

### Pivot Data
```sql
-- Using CASE (manual pivot)
SELECT 
    region,
    SUM(CASE WHEN year = 2020 THEN sales END) AS sales_2020,
    SUM(CASE WHEN year = 2021 THEN sales END) AS sales_2021,
    SUM(CASE WHEN year = 2022 THEN sales END) AS sales_2022
FROM sales
GROUP BY region;
```

### Find Missing Values / Gaps
```sql
-- Find missing IDs
WITH all_ids AS (
    SELECT generate_series(1, 100) AS id  -- PostgreSQL
)
SELECT a.id
FROM all_ids a
LEFT JOIN table_name t ON a.id = t.id
WHERE t.id IS NULL;
```

### Calculate Percentiles
```sql
-- Using window functions
SELECT column1,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY column2) OVER () AS median,
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY column2) OVER () AS p90
FROM table_name;
```

### Find Consecutive Records
```sql
-- Find consecutive login days
WITH numbered AS (
    SELECT user_id, login_date,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn
    FROM logins
),
datediff AS (
    SELECT user_id, login_date, rn,
           login_date - INTERVAL '1 day' * rn AS grp
    FROM numbered
)
SELECT user_id, COUNT(*) AS consecutive_days
FROM datediff
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;  -- At least 3 consecutive days
```

---

## Performance Tips

### Indexes
```sql
-- Create index
CREATE INDEX idx_name ON table_name(column1);

-- Composite index
CREATE INDEX idx_composite ON table_name(column1, column2);

-- Partial index
CREATE INDEX idx_partial ON table_name(column1) WHERE column2 > 100;
```

### Query Optimization
- Use `EXPLAIN` or `EXPLAIN ANALYZE` to see query plan
- Avoid `SELECT *` - select only needed columns
- Use appropriate indexes on JOIN and WHERE columns
- Filter early with WHERE before JOINs
- Use LIMIT when possible
- Avoid functions on indexed columns in WHERE clauses

---

## Quick Reference

### NULL Handling
```sql
-- COALESCE: Return first non-NULL value
SELECT COALESCE(column1, column2, 'default') FROM table_name;

-- NULLIF: Return NULL if values match
SELECT NULLIF(column1, 0) FROM table_name;  -- NULL if column1 = 0

-- ISNULL (SQL Server) / IFNULL (MySQL)
SELECT ISNULL(column1, 0) FROM table_name;
```

### Set Operations
```sql
-- UNION: Combine results (removes duplicates)
SELECT column1 FROM table1
UNION
SELECT column1 FROM table2;

-- UNION ALL: Combine results (keeps duplicates)
SELECT column1 FROM table1
UNION ALL
SELECT column1 FROM table2;

-- INTERSECT: Common rows
SELECT column1 FROM table1
INTERSECT
SELECT column1 FROM table2;

-- EXCEPT / MINUS: Rows in first but not second
SELECT column1 FROM table1
EXCEPT
SELECT column1 FROM table2;
```

---

## Common Interview Questions

1. **Find the second highest salary**
2. **Delete duplicates keeping one**
3. **Find employees who earn more than their managers**
4. **Calculate running totals**
5. **Find customers who never ordered**
6. **Get top 3 products per category**
7. **Calculate month-over-month growth**
8. **Find consecutive login days**
9. **Pivot rows to columns**
10. **Find median salary**

---

*Good luck with your interview! 🚀*

