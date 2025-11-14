### SELECT
### FROM
### LIMIT

### WHERE

### logic operators (>, < !=, =, <=, >=)
- note, apparently we can use > on type strings, for alphabetical comparison: in SQL, “Ja” > “J”
```sql
SELECT *
FROM tutorial.us_housing_units
WHERE month_name > 'J';
```
### Arithmetic
- you can only add/subtract/multiply/divide values in multiple columns _from the same row_ together
### Logical Operators
- [**`LIKE`**](https://mode.com/sql-tutorial/sql-like) allows you to match similar values, instead of exact values. `ILIKE` is the case sensitive version    
- `%` is wildcard, _ is any character
   ```sql
        SELECT *
        FROM tutorial.billboard_top_100_year_end
        WHERE artist ILIKE 'dr_ke'
        
        SELECT *
        FROM tutorial.billboard_top_100_year_end
        WHERE "group_name" LIKE 'Snoop%'
    ```
        
-  [**`IN`**](https://mode.com/sql-tutorial/sql-in-operator) allows you to specify a list of values you'd like to include.
```sql
/*year rank is any of the values: 1, 2, 3*/
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank IN (1, 2, 3)
```

-  [**`BETWEEN`**](https://mode.com/sql-tutorial/sql-between) allows you to select only rows within a certain range.
```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank BETWEEN 5 AND 10
         
/*equivalent*/
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank >= 5 AND year_rank <= 10
```

- [**`IS NULL`**](https://mode.com/sql-tutorial/sql-is-null) allows you to select rows that contain no data in a given column.
```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist IS NULL
        
/* do not do this, can't do arithmetic on NULL values*/
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist = NULL
```
        
- [**`AND`**](https://mode.com/sql-tutorial/sql-and-operator) allows you to select only rows that satisfy two conditions.
```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012
AND year_rank <= 10
AND "group_name" ILIKE '%feat%'
```
        
- [**`OR`**](https://mode.com/sql-tutorial/sql-or-operator) allows you to select rows that satisfy either of two conditions.
```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
AND ("group_name" ILIKE '%macklemore%' OR "group_name" ILIKE '%timberlake%')
```
        
- [**`NOT`**](https://mode.com/sql-tutorial/sql-not-operator) allows you to select rows that do not match a certain condition.
```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
AND "group_name" NOT ILIKE '%macklemore%'
```

- `ORDER BY`
	- First order by year, then order by year_rank
	- ORDER BY is executed before

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank <= 3
 ORDER BY year DESC, year_rank
```
- Comments
```sql
SELECT *  --This comment won't affect the way the code runs
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
```
- BETWEEN

more on logical operators: https://www.w3schools.com/sql/sql_operators.asp