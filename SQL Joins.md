### Joins Intro
- We want to work with data from multiple tables at once
```sql
SELECT teams.conference AS conference,
       AVG(players.weight) AS average_weight
       
 /*We gave these tables aliases - easier to work with this way*/
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
  /*ON indicates how these two tables relate to each other*/
    ON teams.school_name = players.school_name
 GROUP BY teams.conference
 ORDER BY AVG(players.weight) DESC
```

### Real data could be messy 
Say we have the following two tables:
1. teams table: school, team_name
2. players table: school, height, weight

Data isn't always clean:
- What if there are duplicated school names in `teams` table? 
	- Say, Michael Campanaro went to "Wake Forest"
	- Say there are 3 rows of "Wake Forest" in `teams` table.
	- we don't want three rows with Michael Campanaro in the joined table!  
- What if a player goes to a school that isn't in the teams table?

It's often the case that one or both tables being joined contain rows that don't have matches in the other table!
- That's why we need inner and outer joins!

### INNER JOIN
- INNER joins eliminate rows from both tables that do not satisfy the join condition set forth in the `ON` statement
- Mathematical term: intersection of two tables
- Syntax is `INNER JOIN` or `JOIN`


![[Screenshot 2025-11-12 at 10.35.07 AM.png]]
-  Joining tables with identical column names
	- when you include 2 columns of the same name -- the results will simply show the same value set for both columns **even if the two columns should contain different data
	- Avoid duplicate columns by renaming one of them

### OUTER JOIN![[Screenshot 2025-11-12 at 10.52.32 AM.png]]
- LEFT JOIN / OUTER LEFT JOIN: returns unmatched rows from left table, as well as matched rows in both tables
- RIGHT JOIN / OUTER RIGHT JOIN: returns unmatched rows from right table, as well as matched rows in both
- FULL OUTER JOIN / OUTER JOIN: returns unmatched rows from both tables, as well as matched rows in both tables

### LEFT JOIN
- will return all rows in the table in the `FROM` clause

### RIGHT JOIN
- pretty rarely used because you can just switch the two joined table names in a LEFT JOIN, lol 
- Convention of always using LEFT JOIN --> make queries easier to read and audit

### SQL Joins Using WHERE or ON
 **Filtering in the ON clause** 
 ```sql
SELECT 
	companies.permalink AS companies_permalink, 
	companies.name AS companies_name, 
	acquisitions.company_permalink AS acquisitions_permalink,
	acquisitions.acquired_at AS acquired_date 
FROM tutorial.crunchbase_companies companies 
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions ON companies.permalink = acquisitions.company_permalink 
AND acquisitions.company_permalink != '/company/1000memories' 
ORDER BY companies_permalink
 ```
 - `AND` is evaluated before we join the two tables
 - You can think of this as "filtering before joining" or "filtering on one table"


**Filtering in the WHERE clause** 
```sql
SELECT 
companies.permalink AS companies_permalink, 
companies.name AS companies_name, 
acquisitions.company_permalink AS acquisitions_permalink, acquisitions.acquired_at AS acquired_date 
FROM tutorial.crunchbase_companies companies 
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions 
ON companies.permalink = acquisitions.company_permalink 
WHERE acquisitions.company_permalink != '/company/1000memories' 
OR acquisitions.company_permalink IS NULL ORDER BY
```
- You can think of this as "filtering after joining" or "filtering on the joint table"

### Full Outer Join 
- commonly used in conjunction with [[SQL Aggregates]] to understand the amount of overlap between two tables
```sql
SELECT 
COUNT(CASE WHEN companies.permalink IS NOT NULL AND acquisitions.company_permalink IS NULL THEN companies.permalink ELSE NULL END) AS companies_only, 
COUNT(CASE WHEN companies.permalink IS NOT NULL AND acquisitions.company_permalink IS NOT NULL THEN companies.permalink ELSE NULL END) AS both_tables, 
COUNT(CASE WHEN companies.permalink IS NULL AND acquisitions.company_permalink IS NOT NULL THEN acquisitions.company_permalink ELSE NULL END) AS acquisitions_only 

FROM tutorial.crunchbase_companies companies 
FULL JOIN tutorial.crunchbase_acquisitions acquisitions 
ON companies.permalink = acquisitions.company_permalink
```

### SQL Self Join
- A join statement, where the table is joined with itself
```sql
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City  
FROM Customers A, Customers B  
WHERE A.CustomerID <> B.CustomerID  
AND A.City = B.City  
ORDER BY A.City;
```

### SQL UNION
https://www.w3schools.com/sql/sql_union.asp
- UNION: will only selects unique values
- UNION ALL: will keep duplicates
- the data types of both columns must be the same, but the column names can be different
```sql
SELECT City, Country FROM Customers  
WHERE Country='Germany'  
UNION  
SELECT City, Country FROM Suppliers  
WHERE Country='Germany'  
ORDER BY City;
```