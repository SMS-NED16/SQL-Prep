-- A JOIN is used to retrieve data about the same entity from multiple tables  using a common foreign key.

-- First and last names of all employees along with their departments
SELECT e.fname, e.lname, d.name
FROM employee AS e INNER JOIN department AS d
	ON e.dept_id = d.dept_id; /* dept_id acts as bridge b/w two tables */

-- Cartesian product/Cross Join: what happens when JOIN without foreign key?
SELECT e.fname, e.lname, d.name
FROM employee AS e JOIN department AS d;

-- 54 rows in this result set: each combination of fname and lname from one table and a department from the other table therefore 18 names x 3 depts  = 54. When the query doesn't specify HOW the tables should be joined, the server returns a cartesian product (Every permutation of two tables)

-- Join that specifies HOW the two tables should be joined. As the join type was not defined, the server did an inner join by default.
SELECT e.fname, e.lname, d.name 
FROM employee AS e JOIN department AS d 
	ON e.dept_id = d.dept_id;

-- This is called an INNER JOIN: if foreign key exists in one table but not in the other, then that row is excluded from the result set.
SELECT e.fname, e.lname, d.name
FROM employee AS e INNER JOIN department AS d /* Always define join type */
	ON e.dept_id = d.dept_id;

-- If the foreign key column has the same name in both tables, can use USING
SELECT e.fname, e.lname, d.name 
FROM employee AS e INNER JOIN department AS d
	USING (dept_id); 	/* Parentheses are important */


-- No JOIN keyword: Old syntax
SELECT e.fname, e.lname, d.name
FROM employee AS e, department AS d
WHERE e.dept_id = d.dept_id;

/*
	Advantages of the ANSI syntax (INNER JOIN ... ON ...)
	- Separates join and filter conditions. Less likely to mix the two up.
	- JOIN condition for each pair of tables has a separate ON clause - omission less likely.
	- Portability across DB servers
*/
-- Example: all accounts opened by experienced tellers assigned to Woburn
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account AS a, branch AS b, employee as e
WHERE a.open_emp_id = e.emp_id 
	AND e.start_date < '2003-01-01'
	AND e.assigned_branch_id = b.branch_id
	AND (e.title = 'Teller' OR e.title = 'Head Teller')
	AND b.name = 'Woburn Branch';

-- Difficult to tell what is a filter condition and what is a join, what type of join is used, and if any join queries have been left out. Same query written in SQL 92 syntax
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account AS a INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
	INNER JOIN branch AS b
	ON e.assigned_branch_id = b.branch_id
WHERE e.start_date < '2003-01-01'
	AND (e.title = 'Teller' OR e.title = 'Head Teller')
	AND b.name = 'Woburn Branch';