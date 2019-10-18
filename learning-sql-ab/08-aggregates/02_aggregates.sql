-- Aggregate functions will perform a specific operation over all rows in a group
-- They will oftne return a numeric quantity. Common ones are min, max, avg, count, sum.
-- This query shows the results of all these agg functions applied to balance col of all 
-- checking accounts in the bank database.
SELECT MAX(avail_balance) AS max_balance,
	MIN(avail_balance) AS min_balance, 
	AVG(avail_balance) AS avg_balance, 
	SUM(avail_balance) AS total_balance, 
	COUNT(*) AS num_accounts
FROM account
WHERE product_cd = 'CHK';

-- Implicit group: when no group by is specified
-- Explicit group: when we specify col name(s) for group by operation
SELECT product_cd, 
	MAX(avail_balance) AS max_balance,
	MIN(avail_balance) AS min_balance,
	AVG(avail_balance) AS avg_balance,
	SUM(avail_balance) AS total_balance, 
	COUNT(*) AS num_accounts
FROM account 
GROUP BY product_cd;

-- When a GROUP BY column is specified, query knows to group together rows having 
-- the same value in the product_cd col first and then to apply the five aggregate functions
-- to each of the six groups in the product_cd col.

-- Fetchs list of all accounts opened and the ID of the employee who opened them
SELECT account_id, open_emp_id 
FROM account 
ORDER BY open_emp_id;

-- Modifying this query to try and get the count of employees who opened accounts
SELECT COUNT(open_emp_id) FROM account;
SELECT COUNT(*) FROM account;		/* Generates the same result as this query */

-- Modifying the query further to find the number of distinct employees who opened accs
-- Using the DISTINCT keyword, COUNT() is able to remove duplicates from the final tally.
SELECT COUNT(DISTINCT open_emp_id) FROM account;

-- Can use expressions as arguments for aggregate functions as well
SELECT MAX(pending_balance - avail_balance) AS max_uncleared
FROM account;

-- Dealing with NULLs
-- Making a temporary table with NULL values to demonstrate their effect on aggregates
CREATE TABLE number_tbl
	(val SMALLINT);
INSERT INTO number_tbl VALUES (1);
INSERT INTO number_tbl VALUES (3);
INSERT INTO number_tbl VALUES (5);

-- Performing the five common aggregate functions on this table
SELECT COUNT(*) AS num_rows, 
	COUNT(val) AS num_vals, 
	SUM(val) AS total, 
	MAX(val) AS max_val, 
	AVG(val) AS avg_val 
FROM number_tbl;

-- What happens when we insert NULL?
INSERT INTO number_tbl VALUES (NULL);

-- Now the results of the aggregate function will have changed
/*
+----------+----------+-------+---------+---------+
| num_rows | num_vals | total | max_val | avg_val |
+----------+----------+-------+---------+---------+
|        4 |        3 |     9 |       5 |  3.0000 |
+----------+----------+-------+---------+---------+
*/

-- COUNT(*) returns the number of rows in the result set, but COUNT(val) returns the 
-- number of non-NULL values in the val column. COUNT(*) is NOT the same as COUNT(some_col).
