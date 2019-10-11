-- Sorting compound query results
SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller' 
UNION 
SELECT open_emp_id, open_branch_id 
FROM account 
WHERE product_cd = 'SAV'
ORDER BY emp_id;

/*
	The first query selects the ID of employee and assigned branch for all bank tellers.
*/
SELECT emp_id, assigned_branch_id 
FROM employee
WHERE title = 'Teller';
-- +--------+--------------------+
-- | emp_id | assigned_branch_id |
-- +--------+--------------------+
-- |      7 |                  1 |
-- |      8 |                  1 |
-- |      9 |                  1 |
-- |     11 |                  2 |
-- |     12 |                  2 |
-- |     14 |                  3 |
-- |     15 |                  3 |
-- |     17 |                  4 |
-- |     18 |                  4 |
-- +--------+--------------------+

/*
	The second query gets id of the employee who opened the account and the branch ID for all savings accounts.
*/
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV';
-- +-------------+----------------+
-- | open_emp_id | open_branch_id |
-- +-------------+----------------+
-- |          10 |              2 |
-- |          10 |              2 |
-- |           1 |              1 |
-- |          16 |              4 |
-- +-------------+----------------+

-- Using UNION ALL. Suppresses the duplicate entries in second query.
SELECT emp_id, assigned_branch_id FROM employee WHERE title = 'Teller' 
UNION
SELECT open_emp_id, open_branch_id FROM account WHERE product_cd = 'SAV';

-- +--------+--------------------+
-- | emp_id | assigned_branch_id |
-- +--------+--------------------+
-- |      7 |                  1 |
-- |      8 |                  1 |
-- |      9 |                  1 |
-- |     11 |                  2 |
-- |     12 |                  2 |
-- |     14 |                  3 |
-- |     15 |                  3 |
-- |     17 |                  4 |
-- |     18 |                  4 |
-- |     10 |                  2 |
-- |      1 |                  1 |
-- |     16 |                  4 |
-- +--------+--------------------+

-- ORDER BY emp_id column
-- +--------+--------------------+
-- | emp_id | assigned_branch_id |
-- +--------+--------------------+
-- |      1 |                  1 |
-- |      7 |                  1 |
-- |      8 |                  1 |
-- |      9 |                  1 |
-- |     10 |                  2 |
-- |     11 |                  2 |
-- |     12 |                  2 |
-- |     14 |                  3 |
-- |     15 |                  3 |
-- |     16 |                  4 |
-- |     17 |                  4 |
-- |     18 |                  4 |
-- +--------+--------------------+

-- Can't ORDER BY a column in the second query of a compound query
SELECT emp_id, assigned_branch_id FROM employee WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id FROM account WHERE product_cd = 'SAV'
ORDER BY open_emp_id;		/* Error! */

-- Solution - use common aliases
SELECT emp_id AS employee_ID, assigned_branch_id FROM employee WHERE title = 'Teller'
UNION
SELECT open_emp_id AS employee_ID, open_branch_id FROM account WHERE product_cd ='SAV'
ORDER BY employee_ID;


-- Order of Operations/Operation Precedence
-- First query
SELECT cust_id 
FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION ALL /* Will not remove duplicates */
-- Second query
SELECT a.cust_id 
FROM account AS a INNER JOIN branch AS b
	ON a.open_branch_id = b.branch_id 
WHERE b.name = 'Woburn Branch'
UNION	/* Will remove duplicates */
-- Third query
SELECT cust_id 
FROM account 
WHERE avail_balance BETWEEN 500 AND 2500;

-- First compound query - UNION ALL/UNION
SELECT cust_id FROM account WHERE product_cd IN ('SAV', 'MM')
UNION ALL
SELECT a.cust_id FROM account AS a INNER JOIN branch AS b
	ON a.open_branch_id = b.branch_id WHERE b.name = 'Woburn Branch'
UNION
SELECT cust_id FROM account WHERE avail_balance BETWEEN 500 AND 2500
ORDER BY cust_id;

-- Second compund query - UNION/UNION ALL
SELECT cust_id FROM account WHERE product_cd IN ('SAV', 'MM') 
UNION
SELECT a.cust_id FROM account AS a INNER JOIN branch AS b 
	ON a.open_branch_id = b.branch_id  WHERE b.name = 'Woburn Branch'
UNION ALL 
SELECT cust_id FROM account WHERE avail_balance BETWEEN 500 AND 2500
ORDER BY cust_id;