/* 
	SELECT is the last clause to be executed in SELECT query because before 
	anything can be selected, the SQL engine must know the combinations of data
	that CAN be selected.
*/

/* Show me all the columns and all the rows in the `department` table*/
SELECT * 
FROM department;

-- Can specify which columns to select 
SELECT dept_id, name
FROM department; 

SELECT name 
FROM department;

-- The SELECT clause determines which of all possible columns should be included
-- in the query's result set.

-- Demonstrating the use of a table column, a literal, experssion, and built-in function
SELECT emp_id, 'ACTIVE', emp_id * 3.14159, UPPER(lname) 
FROM employee;

-- Can skip the FROM clause entirely when using built-in functions
SELECT VERSION(), USER(), DATABASE();

-- Can add a column alias to temporarily rename columns in a result set. This is
-- commonly done when the column is poorly named, or when a new column is generated
-- from existing data.
SELECT emp_id, 
	'ACTIVE' status, 
	emp_id * 3.14159 empid_x_pi, 
	UPPER(lname) last_name_upper, 
FROM employee;

-- Using the AS keyword to specify column aliases: improves readability
SELECT emp_id,
	'ACTIVE' AS status,
	emp_id * 3.14159 AS empid_x_pi, 
	UPPER(lname) AS last_name_upper
FROM employee;

-- Some queries can return duplicate rows of data: some customers have more than
-- one account, so this query returns multiple rows with the same cust_id
SELECT cust_id FROM account;

-- Use the DISTINCT keyword
SELECT DISTINCT cust_id FROM account;

/*
	Use of DISTINCT keyword requires the data to be sorted before distinct
	values can be identified, which may be slow on large databases. So just using
	DISTINCT to confirm presence of duplicates may not be the best solution in some cases.
	Better to think about whether the column/table/database can possibly have duplicates.
*/
