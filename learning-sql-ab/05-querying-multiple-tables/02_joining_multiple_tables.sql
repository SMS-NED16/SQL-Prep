-- Two table join
SELECT a.account_id, c.fed_id
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';

-- Three tables: two join clauses, two on clauses, two join types
-- Modifying prev query to include name of employee who opened B account
SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
	INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

-- Order of inner joins does not make a difference
SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM customer AS c INNER JOIN account AS a
	ON a.cust_id = c.cust_id
	INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM employee AS e INNER JOIN account AS a
	ON e.emp_id = a.open_emp_id
	INNER JOIN customer AS c
	ON c.cust_id = a.cust_id
WHERE c.cust_type_cd = 'B';

/* The order of tables does not make a difference because SQL is a nonprocedural language. We only describe what we DB objects we want to retrive and the DB objects involved in fetching them, but not HOW the DB Server should fetch the result set. This means the DB server makes decisions about the order in which tables will be joined (to maximise efficiency). The table that it chooses as the first table in the JOIN is called the driving table.*/

-- Can specify driving table in MySQL
SELECT STRAIGHT_JOIN a.account_id, c.fed_id, e.fname, e.lname
FROM customer AS c INNER JOIN account AS a
	ON a.cust_id = c.cust_id
	INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';


-- The same query written with a subquery
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account AS a INNER JOIN
/* Subquery that returns a result set with EMPLOYEE data - namely, id and branch id for all tellers/head tellers that started before 2003*/
	(SELECT emp_id, assigned_branch_id
	FROM employee
	WHERE start_date < '2003-01-01'
		AND (title = 'Teller' OR title = 'Head Teller')) AS e
ON a.open_emp_id = e.emp_id 
/* Second subquery selects branches */
INNER JOIN
	(SELECT branch_id 
	FROM branch
	WHERE name = 'Woburn Branch') AS b
ON e.assigned_branch_id = b.branch_id;

-- Subquery 1: All employee and branch IDs for experienced tellers
SELECT emp_id, assigned_branch_id
FROM employee
WHERE start_date < '2003-01-01'
	AND (title = 'Teller' OR title = 'Head Teller');

-- Subquery 2: Branch ID of Woburn Branch
SELECT branch_id FROM branch WHERE name = 'Woburn Branch';

-- Using the same table twice
SELECT a.account_id, e.emp_id, b_a.name AS open_branch, b_e.name AS emp_branch
FROM account AS a INNER JOIN branch AS b_a
	ON a.open_branch_id = b_a.branch_id
	INNER JOIN employee AS e
	ON a.open_emp_id = e.emp_id
	INNER JOIN branch AS b_e
	ON e.assigned_branch_id = b_e.branch_id
WHERE a.product_cd = 'CHK';