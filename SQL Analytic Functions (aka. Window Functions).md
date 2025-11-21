Tutorial linkl: https://www.kaggle.com/code/alexisbcook/analytic-functions

### Overview
- Honestly kinda wack, not gunna lie
	- reminds me of the window from "sliding window" algorithm if you're a software engineer
- [[SQL Aggregates]] performs calculations based on sets of rows
- Analytic functions returns a value for each row in

### Syntax Breakdown
![[Screenshot 2025-11-21 at 12.50.56 PM.png]]
- all analytic functions have an `OVER` clause
	- used to specify which rows are used in each calculation
- `OVER` clause has 3 optional parts:
	1. `PARTITION BY` - divides the rows of the table into different groups
	2. `ORDER BY` - defines an ordering within each partition
	3. window frame ("ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - identifies the set of rows used in each calculation
![[Screenshot 2025-11-21 at 1.39.15 PM.png]]

### Window Frame Clause
Some examples:
- `ROWS BETWEEN 1 PRECEDING AND CURRENT ROW` - the previous row and the current row.
- `ROWS BETWEEN 3 PRECEDING AND 1 FOLLOWING` - the 3 previous rows, the current row, and the following row.
- `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` - all rows in the partition.
- And many more...

### 3 types of analytic functions
1. Analytic aggregate functions:
	- MIN(), MAX(), AVG(), SUM(), COUNT()
2. Analytic navigation functions
	1. FIRST_VALUE(), LAST_VALUE() - returns the first or last value in the input
	2. LEAD(), LAG() - return the value on a subsequent or preceding row
3. Analytic numbering functions
	1. ROW_NUMBERS() - return the order in which rows appear in the input (1-based index)
	2. RANK() -  All rows with the same value in the ordering column receive the same rank value, where the next row receives a rank value which increments by the number of rows with the previous rank value

Documentation for analytic functions supported in [Google BigQuery](https://docs.cloud.google.com/bigquery/docs/reference/standard-sql/window-function-calls)
