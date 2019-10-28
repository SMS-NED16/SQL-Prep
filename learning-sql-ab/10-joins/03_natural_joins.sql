-- A NATURAL JOIN relies on the database engine to decide which type of join to use 
-- for a given combination of tables. Relies on identical column names in the tables
SELECT a.account_id, a.cust_id, c.cust_type_cd, c.fed_id 
FROM account AS a NATURAL JOIN customer AS c;

-- This returns the same result as 
SELECT a.account_id, a.cust_id, c.cust_type_cd, c.fed_id 
FROM account AS a INNER JOIN customer AS c 
	ON a.cust_id = c.cust_id;

-- The join condition of `a.cust_id = c.cust_id` was automatically determined by
-- the database engine because both tables had the same column name.

-- What happens when column names don't match? CROSS JOIN
SELECT a.account_id, a.cust_id, a.open_branch_id, b.name 
FROM account AS a NATURAL JOIN branch AS b;

-- 24 rows in the account table, 4 rows in the branch table, two tabels cross joined
-- so 24 x 4 = 96 rows in the result set. Same as 
SELECT a.account_id, a.cust_id, a.open_branch_id, b.name 
FROM account AS a CROSS JOIN branch AS b;

-- Probably best to avoid NATURAL JOINs and explicitly define the kind of JOIN to use