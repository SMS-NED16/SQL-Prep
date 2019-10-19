/* A noncorrelated subquery is one that does not refer to any information in the 
containing statement. It is independent, can be executed alone.

When a query returns a table with a single row and column, it is called a scalar
subquery. This query can be used with relational operators. 
*/

-- Non-correlated scalar subquery: returns details for all accounts NOT opened by
-- the Head Teller at the Woburn branch. This works because there is only one 
-- head teller in each branch, so the subquery will always return only 1 row and col
SELECT account_id, product_cd, cust_id, avail_balance
FROM account 
WHERE open_emp_id != 
	(SELECT e.emp_id
	FROM employee AS e INNER JOIN branch AS b
		ON e.assigned_branch_id = b.branch_id 
	WHERE e.title = 'Head Teller' AND b.city = 'Woburn')

-- Is the subquery actually a scalar? Yes. It returns the ID of the head teller
-- at the Woburn branch.
SELECT e.emp_id 
FROM employee AS e INNER JOIN branch AS b
	ON e.assigned_branch_id = b.branch_id 
WHERE e.title = 'Head Teller' AND b.city = 'Woburn';

-- This subquery is non-scalar: it returns multiple rows since multiple tellers
SELECT e.emp_id 
FROM employee AS e INNER JOIN branch AS b
	ON e.assigned_branch_id = b.branch_id 
WHERE e.title = 'Teller' AND b.city = 'Woburn';

-- So this subquery can't be used as part of a relational statement
-- ERROR 1242 (21000): Subquery returns more than 1 row
SELECT account_id, product_cd, cust_id, avail_balance
FROM account 
WHERE open_emp_id != 
	(SELECT e.emp_id 
	FROM employee AS e INNER JOIN branch AS b 
		ON e.assigned_branch_id = b.branch_id 
	WHERE e.title = 'Teller' AND b.city = 'Woburn');

-- The solution for this problem is to use the IN operator. The result of this query
-- shows that all accounts were opened by employees with ids other than 11 or 12
-- i.e. employees other than the tellers at 
SELECT account_id, product_cd, cust_id, open_emp_id, avail_balance
FROM account 
WHERE open_emp_id NOT IN 
	(SELECT e.emp_id 
	FROM employee AS e INNER JOIN branch AS b
		ON e.assigned_branch_id = b.branch_id 
	WHERE e.title = 'Teller' AND b.city = 'Woburn');

-- Multiple row, single column queries
-- Checking whether a single value is found in a set of values using IN
SELECT branch_id, name, city 
FROM branch
WHERE name in ('Headquarters', 'Quincy Branch');

-- This query does the same thing, but is not scalable: can't have separate condition
-- for each of the hundreds of possible values
SELECT branch_id, name, city 
FROM branch 
WHERE name = 'Headquarters' OR name = 'Quincy Branch';

-- In fact, more common to create a set for use with IN with a subquery
SELECT emp_id, fname, lname, title 
FROM employee
WHERE emp_id IN (SELECT superior_emp_id 
	FROM employee);

-- Can add DISTINCT to the subquery SELECT statement, but it makes no difference
-- for the results of the containining query. DISTINCT require sorting, so slower?
SELECT emp_id, fname, lname, title 
FROM employee 
WHERE emp_id IN 
	(SELECT DISTINCT superior_emp_id 
		FROM employee);

-- Using the NOT IN operator to check whether a value does not exist in a set
-- This query will find all employees who do not supervise people 
SELECT emp_id, fname, lname, title 
FROM employee 
WHERE emp_id NOT IN 
	(SELECT superior_emp_id 
	FROM employee 
	WHERE superior_emp_id IS NOT NULL);

-- ALL operator: finds all employees whose IDs are not equal to any non NULL id
-- In other words, it finds all employees that don't supervise other employees
SELECT emp_id, fname, lname, title
FROM employee 
WHERE emp_id <> ALL (SELECT superior_emp_id
	FROM employee 
	WHERE superior_emp_id IS NOT NULL);

-- Be careful of NULLs
SELECT emp_id, fname, lname, title 
FROM employee 
WHERE emp_id NOT IN (1, 2, NULL);	/* Equating with NULL leads to unknown */

-- The subquery finds the balances of all of frank tucker's accounts
SELECT a.product_cd, a.avail_balance, i.fname, i.lname 
FROM account AS a INNER JOIN individual AS i
	ON a.cust_id = i.cust_id 
WHERE i.fname = 'Frank' AND i.lname = 'Tucker';

-- Combining this with the ALL operator ensures that every acct in the result set
-- has balance less than ALL of Frank Tucker's Accounts
-- Another use case for the ALL operator: all accts with balance < Frank Tucker
SELECT a.account_id, a.cust_id, a.product_cd, a.avail_balance
FROM account AS a
WHERE a.avail_balance < ALL(SELECT a.avail_balance 
	FROM account AS a INNER JOIN individual AS i
		ON a.cust_id = i.cust_id 
	WHERE i.fname = 'Frank' AND i.lname = 'Tucker'
);

-- One is  BUS account, so can't use fname, lname for inner join

-- ANY operator: condition evaluates to TRUE as soon as a single comparison is true
-- Basically, any account with avail_balance > 1057.75 i.e. accounts with balance
-- more than ANY of Frank's accounts. = ANY is the same as using IN.
SELECT account_id, cust_id, product_cd, avail_balance
FROM account 
WHERE avail_balance > ANY (SELECT a.avail_balance 
	FROM account AS a INNER JOIN individual AS i 
		ON a.cust_id = i.cust_id 
	WHERE i.fname = 'Frank' AND i.lname = 'Tucker'
);

-- Multiple, single column queries
-- Single query that combines results from two subqueries: accounts opened by tellers
-- or head tellers in the Woburn branch
SELECT account_id, product_cd, cust_id 
FROM account 
-- First subquery is scalar noncorr query that returns branch ID of Woburn
WHERE open_branch_id = (SELECT branch_id 
	FROM branch 
	WHERE name = 'Woburn Branch')	
-- Second subquery returns set of emp_ids that are tellers or head tellers
AND open_emp_id IN (SELECT emp_id 
	FROM employee 
	WHERE title = 'Teller' OR title = 'Head Teller');

SELECT branch_id FROM branch WHERE name = 'Woburn Branch';
SELECT emp_id FROM employee WHERE title = 'Teller' OR title = 'Head Teller';

-- Can also achieve the same results using a single, multicolumn query
-- The query combines columns from two different tables using a single subquery
SELECT account_id, product_cd, cust_id 
FROM account 
WHERE (open_branch_id, open_emp_id) IN 
	(SELECT b.branch_id, e.emp_id
		FROM branch AS b INNER JOIN employee AS e 
			ON b.branch_id = e.assigned_branch_id
		WHERE b.name = 'Woburn Branch' 
			AND (e.title = 'Teller' OR e.title = 'Head Teller'));