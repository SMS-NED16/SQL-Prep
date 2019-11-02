-- 01: Rewriting a query of simple case expressions to use searched case expressions
-- With as few WHEN clauses as possible
-- Original Query
SELECT emp_id, title, 
CASE title
	WHEN 'President' THEN 'Management'
	WHEN 'Vice President' THEN 'Management'
	WHEN 'Treasurer' THEN 'Management'
	WHEN 'Loan Manager' THEN 'Management'
	WHEN 'Operations Manager' THEN 'Operations'
	WHEN 'Head Teller' THEN 'Operations'
	WHEN 'Teller' THEN 'Operations'
	ELSE 'Unknown'
END AS employee_type
FROM employee;

-- My solution: searched query because now it uses a WHEN ___ IN CASE expression
-- Instead of just using equality like a simple case expression
SELECT emp_id, title, 
CASE
	WHEN title IN ('President', 'Vice President', 'Loan Manager', 'Treasurer')
		THEN 'Management'
	WHEN title IN ('Teller', 'Head Teller', 'Operations Manager')
		THEN 'Operations'
ELSE 'Unknown'
END AS employee_type
FROM employee;


-- 02: Rewrite the following query so that the result set contains a single row 
-- with four columns (one for each branch). Name the four columbs branch_1 through branch_4.
-- Original query
SELECT open_branch_id, COUNT(*) 
FROM account 
GROUP BY open_branch_id;

-- My solution
SELECT
	SUM(CASE WHEN open_branch_id = 1 THEN 1 ELSE 0 END) AS branch_1, 
	SUM(CASE WHEN open_branch_id = 2 THEN 1 ELSE 0 END) AS branch_2,
	SUM(CASE WHEN open_branch_id = 3 THEN 1 ELSE 0 END) AS branch_3,
	SUM(CASE WHEN open_branch_id = 4 THEN 1 ELSE 0 END) AS branch_4
FROM account;