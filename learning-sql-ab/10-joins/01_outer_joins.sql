-- What happens when a join condition fails to match for all rows in the tables?
SELECT account_id, cust_id FROM account;
SELECT cust_id FROM customer;

-- As the cust_id in account has all cust_ids from 1 to 13 and because the same IDs
-- are also present in the customer table, the INNER JOIN of these tables will 
-- have no missing rows
SELECT a.account_id, c.cust_id
FROM account AS a INNER JOIN customer AS c 
	ON a.cust_id = c.cust_id;

-- But when we join the account table to the business table? Only 5 rows
SELECT a.account_id, b.cust_id, b.name 
FROM account AS a INNER JOIN business AS b
	ON a.cust_id = b.cust_id;

-- Take a look at the `business` table to see why 
SELECT cust_id, name FROM business;

-- Of the 13 rows in the `customer` table, 4 belong to the `business` table and 
-- one of them (Chilton Engineering) owns 2 different accounts.

-- Use case: want to return ALL accounts, but to include business accounts only 
-- if the account is linked to a business customer
SELECT a.account_id, a.cust_id, b.name 
FROM account AS a LEFT OUTER JOIN business AS b 
	ON a.cust_id = b.cust_id;

-- Outer join that fetches names of individuals instead of businesses
SELECT a.account_id, a.cust_id, CONCAT(i.fname, ' ', i.lname) AS individual_name
FROM account AS a LEFT OUTER JOIN individual AS i 
	ON a.cust_id = i.cust_id;

-- An outer join will return a non-null value for any row in the RIGHT table that
-- matches a specified row in the LEFT table, and will return NULL otherwise. It 
-- will still return all rows that match a condition from the LEFT table.

-- Left outer join: table on the left is responsible for providing all the rows 
-- Table on the right is responsible for providing column values when match is found
SELECT c.cust_id, b.name
FROM customer AS c LEFT OUTER JOIN business AS b 
	ON c.cust_id = b.cust_id;

-- Swapping the order around: now the `business` table provides rows and the
-- `customer` table provides values.
SELECT c.cust_id, b.name 
FROM business AS b LEFT OUTER JOIN customer AS c 
	ON c.cust_id = b.cust_id;

-- What happens when I use the original order but a RIGHT OUTER JOIN
-- Same as previous query: specifying that the `business` table provides the 
-- rows and the `customer` table is used to provide column values where the rows
-- match those provided by the `business` table
SELECT c.cust_id, b.name 
FROM customer AS c RIGHT OUTER JOIN business AS b 
	ON c.cust_id = b.cust_id;


-- Three-way OUTER JOIN: Display names for both individuals and businesses where available
SELECT a.account_id, a.product_cd, 
	CONCAT(i.fname, ' ', i.lname) AS person_name, 
	b.name AS business_name 
FROM account AS a LEFT OUTER JOIN individual AS i
	ON a.cust_id = i.cust_id 
	LEFT OUTER JOIN business AS b 
	ON a.cust_id = b.cust_id;

-- Can use subqueries to limit the number of joins in a single query 
-- Subquery does one OUTER JOIN between account and individual, and the result set
-- does one OUTER join with the containing statement: limiting to 1 OUTER JOIN per query
SELECT account_ind.account_id, account_ind.product_cd,
	account_ind.person_name, 
	b.name AS business_name
FROM 
(SELECT a.account_id, a.product_cd, a.cust_id, 
CONCAT(i.fname, ' ', i.lname) AS person_name 
FROM account AS a LEFT OUTER JOIN individual AS i
	ON a.cust_id = i.cust_id) AS account_ind 
LEFT OUTER JOIN business AS b
ON account_ind.cust_id = b.cust_id;

-- Remember SELF JOINS and how they were a thing? This query had a flaw in that it
-- left out employees who had no supervisor
SELECT e.fname, e.lname, e_mgr.fname AS mgr_fname, e_mgr.lname AS mgr_lname
FROM employee AS e INNER JOIN employee AS e_mgr
	ON e.superior_emp_id = e_mgr.emp_id;

-- SELF OUTER JOINs will return NULL where conditions for a SELF INNER JOIN fail
SELECT e.fname, e.lname, e_mgr.fname AS fname, e_mgr.lname AS mgr_lname 
FROM employee AS e LEFT OUTER JOIN employee AS e_mgr 
	ON e.superior_emp_id = e_mgr.emp_id;

-- What happens when we use a RIGHT OUTER JOIN?
-- NULL in the fname, lname columns for any employees that do not supervise others
-- Similarly, employees that supervise multiple employees will appear multiple times.
SELECT e.fname, e.lname, e_mgr.fname AS fname, e_mgr.lname AS mgr_lname 
FROM employee AS e RIGHT OUTER JOIN employee AS e_mgr 
	ON e.superior_emp_id = e_mgr.emp_id;