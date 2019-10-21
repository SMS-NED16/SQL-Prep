-- Since FROM clause specifies tables from which to SELECT rows, we can use
-- a subquery in the FROM clause as long as it is **non-correlated**. 
SELECT d.dept_id, d.name, e_cnt.how_many AS num_employees
FROM department AS d INNER JOIN 
	(SELECT dept_id, COUNT(*) AS how_many 
		FROM employee 
		GROUP BY dept_id) AS e_cnt 
	ON d.dept_id = e_cnt.dept_id;

-- Data Fabrication: creating new data that doesn't exist elsewhere in the db
-- Can create categories of customers using UNION ALL in a subquery, and then classify
-- customers on the basis of these categories
SELECT 'Small Fry' AS name, 0 AS low_limit, 4999.99 AS high_limit 
UNION ALL 	/* Will not remove duplicates */
SELECT 'Average Joes' AS name, 5000 AS low_limit, 9999.99 AS high_limit 
UNION ALL 	
SELECT 'Heavy Hitters' AS name, 10000 AS low_limit, 9999999.99 AS high_limit;

SELECT groups.name, COUNT(*) AS num_customers
FROM 
(
SELECT SUM(a.avail_balance) AS cust_balance 
FROM account AS a INNER JOIN product AS p 
	ON a.product_cd = p.product_cd 
WHERE p.product_type_cd = 'ACCOUNT'
GROUP BY a.cust_id
) AS cust_rollup
INNER JOIN
(
	SELECT 'Small Fry' AS name, 0 AS low_limit, 4999.99 AS high_limit
	UNION ALL
	SELECT 'Average Joes' AS name, 5000 AS low_limit, 9999.99 AS high_limit 
	UNION ALL
	SELECT 'Heavy Hitters' AS name, 10000 AS low_limit, 999999999.99 AS high_limit
) AS groups 
ON cust_rollup.cust_balance BETWEEN groups.low_limit AND groups.high_limit 
GROUP BY groups.name;

-- Task oriented subqueries: This query groups the total deposits handled by an employee
-- in a given account type at a given branch. 
SELECT p.name AS product, b.name AS branch,
	CONCAT(e.fname, ' ', e.lname) AS name,
	SUM(a.avail_balance) AS total_deposits
FROM account AS a INNER JOIN employee AS e 
	ON a.open_emp_id = e.emp_id 
	INNER JOIN branch AS b 
	ON a.open_branch_id = b.branch_id 
	INNER JOIN product AS p 
	ON a.product_cd = p.product_cd 
WHERE p.product_type_cd = 'ACCOUNT'
GROUP BY p.name, b.name, e.fname, e.lname 
ORDER BY 1, 2;

-- Product, branch name, and employee name are just used for display purposes: the
-- same information is available (albeit as foreign keys) in the account table
SELECT product_cd, open_branch_id AS branch_id, open_emp_id AS emp_id, 
	SUM(avail_balance) AS total_deposits
FROM account
GROUP BY product_cd, open_branch_id, open_emp_id;

-- So we can actually get the strings for foreign keys using a subquery in the FROM
-- clause of the containing query along with INNER JOINs
SELECT p.name AS product, b.name AS branch, CONCAT(e.fname, ' ', e.lname) AS name,
	account_groups.tot_deposits 	/*account_groups is alias for subquery result set*/
FROM 
	(SELECT product_cd, open_branch_id AS branch_id, open_emp_id AS emp_id, 
		SUM(avail_balance) AS tot_deposits
	FROM account 
	GROUP BY product_cd, open_branch_id, open_emp_id) AS account_groups 
/* Subquery ends here, inner joins to find strings based on foreign keys */
INNER JOIN employee AS e ON e.emp_id = account_groups.emp_id 
INNER JOIN branch AS b ON b.branch_id = account_groups.branch_id 
INNER JOIN product AS p ON p.product_cd = account_groups.product_cd 
WHERE p.product_type_cd = 'ACCOUNT';

/*
The previous query has two major advantages
- It avoids creating a new, temporary table to store the sum of available deposits
grouped by account type, branch, and employee. This is good DB practice.
- It also executes faster because joins are done using, at most, two digit integer keys
instead of entire strings.
*/

-- Subqueries in filter conditions: subquery finds the maximum number of accts
-- opened by a single employee. This number is used as a filter condition to lookup
-- the open_emp_id of this employee in the containing query.
SELECT open_emp_id, COUNT(*) AS how_many 
FROM account 
GROUP BY open_emp_id 
HAVING COUNT(*) = (SELECT MAX(emp_cnt.how_many)
	FROM (SELECT COUNT(*) AS how_many 
		FROM account 
		GROUP BY open_emp_id) AS emp_cnt);