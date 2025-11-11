### CASE
- SQL’s logic statement
- `CASE` goes in the SELECT clause
- `CASE` must include `WHEN` `THEN` `END`
- `ELSE` statement is optional

```sql
/*player_name, year, is_a_senior
A             2021.  yes
B             2021. 
CASE checks each row to see if the row meets the condidtion "year = SR"
if so, print YES in the "is_a_senior" column*/
SELECT player_name,
year,
CASE WHEN year = 'SR' THEN 'yes'
ELSE NULL END AS is_a_senior
FROM benn.college_football_players
```

- Multiple CASE statement

```sql
/*Case statements will get evaluated in the order that they're written*/
SELECT player_name, weight,
CASE WHEN weight > 250 THEN 'over 250'
	WHEN weight > 200 THEN '201-250'
	WHEN weight > 175 THEN '176-200'
	ELSE '175 or under' END AS weight_group
FROM benn.college_football_players

/*Best practice is to create statements that don't overlap*/
SELECT player_name,
weight,
CASE WHEN weight > 250 THEN 'over 250'
WHEN weight > 200 AND weight <= 250 THEN '201-250'
WHEN weight > 175 AND weight <= 200 THEN '176-200'
ELSE '175 or under' END AS weight_group
FROM benn.college_football_players
```

- You can use `AND` and `OR` with `CASE` statement

```sql
SELECT player_name,
CASE WHEN year = 'FR' AND position = 'WR' THEN 'frosh_wr'
ELSE NULL END AS sample_case_statement
FROM benn.college_football_players
```

- `CASE` combined with [[SQL Aggregates]]

```sql
/*Only count rows that fullfills a condition
GROUP BY is executed before COUNT*/
SELECT CASE WHEN year = 'FR' THEN 'FR'
			WHEN year = 'SO' THEN 'SO'
			WHEN year = 'JR' THEN 'JR'
			WHEN year = 'SR' THEN 'SR'
			ELSE 'No Year Data' END AS year_group,
COUNT(year) AS count # count the rows where year is not NULL
FROM benn.college_football_players
GROUP BY year_group


/* Or a poorly written version*/
SELECT CASE WHEN year = 'FR' THEN 'FR'
			WHEN year = 'SO' THEN 'SO'
			WHEN year = 'JR' THEN 'JR'
			WHEN year = 'SR' THEN 'SR'
			ELSE 'No Year Data' END AS year_group,
COUNT(year) AS count
FROM benn.college_football_players
GROUP BY CASE WHEN year = 'FR' THEN 'FR'
WHEN year = 'SO' THEN 'SO'
WHEN year = 'JR' THEN 'JR'
WHEN year = 'SR' THEN 'SR'
ELSE 'No Year Data' END
```

- `CASE` inside aggregate functions

```sql
/*Data pivoting, making the year values as column header
FR, SO, JR, SR
1.  12. 23. 2 */*
SELECT COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count
FROM benn.college_football_players
