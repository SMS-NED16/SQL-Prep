-- UNION ALL: Finds all rows belonging to two different sets. Does not check for duplicates. Num_rows in result set = rows in A + rows in B.

-- EXAMPLE 1: Selects both individual and business customers from individual. Don't remove duplicates because UNION ALL.
/* Selects 'IND' type_cd, their cust_id, and last name from individual */
SELECT 'IND' type_cd, cust_id, lname AS name
FROM individual
UNION ALL 	/* Perform a union with the corresponding cols from business*/
SELECT 'BUS' type_cd, cust_id, name
FROM business;


-- EXAMPLE 2: To demonstrate that UNION ALL does not remove duplicates, we are doing an additional UNION ALL with the same column from business. The result set will contain two copies of the data from the business table.
SELECT 'IND' type_cd, cust_id, lname AS name
FROM individual
UNION ALL
SELECT 'BUS' type_cd, cust_id, name 
FROM business
UNION ALL
SELECT 'BUS' type_cd, cust_id, name 
FROM business;

-- EXAMPLE 3: Another query that returns duplicate data
SELECT emp_id 
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
UNION ALL
/* The following query will return a duplicate row */
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

-- +--------+
-- | emp_id |
-- +--------+
-- |     10 |
-- |     11 |
-- |     12 |
-- |     10 |
-- +--------+

-- UNION: Same as UNION, will return rows from both sets, but will remove duplicates (but not ALL duplicates)
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
UNION
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

-- +--------+
-- | emp_id |
-- +--------+
-- |     10 |
-- |     11 |
-- |     12 |
-- +--------+