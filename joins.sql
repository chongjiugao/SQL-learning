-- Joins

SELECT * FROM Parks_and_Recreation.employee_demographics;

SELECT * FROM Parks_and_Recreation.employee_salary;

# INNER JOIN will only return the intersection of the two tables
SELECT * 
FROM Parks_and_Recreation.employee_demographics AS d
INNER JOIN Parks_and_Recreation.employee_salary AS s
ON d.employee_id = s.employee_id
;

-- OUTER JOIN
SELECT *
FROM Parks_and_Recreation.employee_demographics AS d
RIGHT JOIN Parks_and_Recreation.employee_salary AS s
ON d.employee_id = s.employee_id;

-- SELF JOIN
-- Say we want to assign secret santa :)
-- employee with id i will be assigned secret santa i+1
SELECT emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM Parks_and_Recreation.employee_salary AS emp1
JOIN Parks_and_Recreation.employee_salary AS emp2
ON emp1.employee_id + 1 = emp2.employee_id
;

-- JOINING multiple table together
SELECT *
FROM Parks_and_Recreation.employee_demographics as dem
INNER JOIN Parks_and_Recreation.employee_salary as sal
ON dem.employee_id = sal.employee_id
INNER JOIN Parks_and_Recreation.parks_departments AS pd
ON sal.dept_id = pd.department_id;

-- reference table that doesn't change that much
-- no duplicates
SELECT * from Parks_and_Recreation.parks_departments;










