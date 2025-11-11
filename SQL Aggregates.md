## Aggregate

- [**`COUNT`**](https://mode.com/sql-tutorial/sql-count) counts how many rows are in a particular column.
```sql
/*count all rows where 'high' is not NULL*/
SELECT COUNT(high)
FROM tutorial.aapl_historical_stock_price
```

- [**`SUM`**](https://mode.com/sql-tutorial/sql-sum) adds together all the values in a particular column.
```sql
SELECT SUM(volume)
FROM tutorial.aapl_historical_stock_price
```

- [**`MIN`**](https://mode.com/sql-tutorial/sql-min-max) and [**`MAX`**](https://mode.com/sql-tutorial/sql-min-max) return the lowest and highest values in a particular column, respectively.
```sql
    SELECT MIN(volume) AS min_volume,
    MAX(volume) AS max_volume
    FROM tutorial.aapl_historical_stock_price
```

- [**`AVG`**](https://mode.com/sql-tutorial/sql-avg) calculates the average of a group of selected values.
```sql
/*will ignore rows where 'high' == NULL*/
    SELECT AVG(high)
    FROM tutorial.aapl_historical_stock_price
```

- **Group By**
    - [**SQL aggregate function**](https://mode.com/sql-tutorial/sql-aggregate-functions) like `COUNT`, `AVG`, and `SUM` have something in common: they all aggregate across the entire table. But what if you want to aggregate only part of a table? For example, you might want to count the number of entries for each year.
```sql
SELECT year,
COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY year
 
/*You can group by multiple columns:
get the total count for each <year, month> pair*/
SELECT year, month, COUNT(*) AS count
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
```

- **Having**
	- `Where` does not filter on aggregate columns, `Having` clause does
```sql
/*For each <year, month> pair, 
# find the highest stock that reached $400*/
SELECT year, month, MAX(high) AS month_high
FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
HAVING MAX(high) > 400
ORDER BY year, month
```

- `HAVING` _is the "clean" way to filter a query that has been aggregated, but this is also commonly done using a subquery_

### Execution order
    SELECT
    FROM
    WHERE
    GROUP BY
    HAVING
    ORDER BY