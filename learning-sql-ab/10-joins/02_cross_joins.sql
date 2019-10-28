-- A CROSS JOIN is a cartesian product of two tables: a join in which every row
-- in one table is joined with every other row in another table without any condition
-- INNER JOIN without any join condition specified
SELECT pt.name, p.product_cd, p.name 
FROM product AS p INNER JOIN product_type AS pt;

-- CROSS JOIN returns the same result set
SELECT pt.name, p.product_cd, p.name 
FROM product AS p CROSS JOIN product_type AS pt;

-- Use case for CROSS JOINs
-- Create a subquery to classify customers based on their available balance
SELECT 'Small Fry' AS name, 0 AS low_limit, 4999.99 AS high_limit
UNION ALL 
SELECT 'Average Joes' AS name, 5000 AS low_limit, 9999.99 AS high_limit 
UNION ALL 
SELECT 'Heavy Hitters' AS name, 10000 AS low_limit, 9999999.99 AS high_limit;

-- Manually creating temporary classification tables can be tedious e.g. if we want
-- to create a query that generates a row for every day in 2008 but DB does not 
-- contain a table with this data
SELECT '2008-01-01' AS dt 
UNION ALL 
SELECT '2008-01-02' AS dt
UNION ALL
SELECT '2008-01-03' AS dt 
UNION ALL 
SELECT '2008-01-04' AS dt 
UNION ALL;

-- And so on: but this would require UNION ALL of 366 select statements!

-- Strategy 2: Generate a table with 366 rows and a single column containing a number
-- between 0 and 366, and add that number of days to 'January 1, 2008'
-- This is done by concatenating numbers through CROSS JOINs
-- This will generate numbers from 0 to 399, and we can filter the ones we don't need
SELECT ones.num + tens.num + hundreds.num 
FROM
(
	SELECT 0 num UNION ALL
	SELECT 1 num UNION ALL
	SELECT 2 num UNION ALL 
	SELECT 3 num UNION ALL 
	SELECT 4 num UNION ALL 
	SELECT 5 num UNION ALL 
	SELECT 6 num UNION ALL 
	SELECT 7 num UNION ALL 
	SELECT 8 num UNION ALL 
	SELECT 9 num
) AS ones 
CROSS JOIN 
(
	SELECT 0 num UNION ALL
	SELECT 10 num UNION ALL
	SELECT 20 num UNION ALL
	SELECT 30 num UNION ALL
	SELECT 40 num UNION ALL
	SELECT 50 num UNION ALL
	SELECT 60 num UNION ALL
	SELECT 70 num UNION ALL
	SELECT 80 num UNION ALL
	SELECT 90 num
) AS tens 
CROSS JOIN 
(
	SELECT 0 num UNION ALL 
	SELECT 100 num UNION ALL 
	SELECT 200 num UNION ALL 
	SELECT 300 num
) AS hundreds 
ORDER BY 1;

-- Create a DAY using these numbers, add them to January 1, 2008, and filter result
-- This is a good use case of CROSS JOINs
SELECT DATE_ADD('2008-01-01',
	INTERVAL (ones.num + tens.num + hundreds.num) DAY) AS dt 
FROM 
(
	SELECT 0 num UNION ALL
	SELECT 1 num UNION ALL
	SELECT 2 num UNION ALL 
	SELECT 3 num UNION ALL 
	SELECT 4 num UNION ALL 
	SELECT 5 num UNION ALL 
	SELECT 6 num UNION ALL 
	SELECT 7 num UNION ALL 
	SELECT 8 num UNION ALL 
	SELECT 9 num
) AS ones 
CROSS JOIN 
(
	SELECT 0 num UNION ALL
	SELECT 10 num UNION ALL
	SELECT 20 num UNION ALL
	SELECT 30 num UNION ALL
	SELECT 40 num UNION ALL
	SELECT 50 num UNION ALL
	SELECT 60 num UNION ALL
	SELECT 70 num UNION ALL
	SELECT 80 num UNION ALL
	SELECT 90 num
) AS tens 
CROSS JOIN 
(
	SELECT 0 num UNION ALL 
	SELECT 100 num UNION ALL 
	SELECT 200 num UNION ALL 
	SELECT 300 num
) AS hundreds 
WHERE DATE_ADD('2008-01-01', 
	INTERVAL(ones.num + tens.num + hundreds.num) DAY) < '2009-01-01'
ORDER BY 1;

-- Can now use this table to find any transactions that occurred in the year 2008
-- Changing to 2003 so that we can get some non-zero values
SELECT days.dt, COUNT(t.txn_id)
FROM transaction AS t RIGHT OUTER JOIN 
(
	SELECT DATE_ADD('2002-01-01',
	INTERVAL (ones.num + tens.num + hundreds.num) DAY) AS dt 
FROM 
(
	SELECT 0 num UNION ALL
	SELECT 1 num UNION ALL
	SELECT 2 num UNION ALL 
	SELECT 3 num UNION ALL 
	SELECT 4 num UNION ALL 
	SELECT 5 num UNION ALL 
	SELECT 6 num UNION ALL 
	SELECT 7 num UNION ALL 
	SELECT 8 num UNION ALL 
	SELECT 9 num
) AS ones 
CROSS JOIN 
(
	SELECT 0 num UNION ALL
	SELECT 10 num UNION ALL
	SELECT 20 num UNION ALL
	SELECT 30 num UNION ALL
	SELECT 40 num UNION ALL
	SELECT 50 num UNION ALL
	SELECT 60 num UNION ALL
	SELECT 70 num UNION ALL
	SELECT 80 num UNION ALL
	SELECT 90 num
) AS tens 
CROSS JOIN 
(
	SELECT 0 num UNION ALL 
	SELECT 100 num UNION ALL 
	SELECT 200 num UNION ALL 
	SELECT 300 num
) AS hundreds 
WHERE DATE_ADD('2008-01-01', 
	INTERVAL(ones.num + tens.num + hundreds.num) DAY) < '2003-01-01'
)AS days
ON days.dt = t.txn_date
GROUP BY days.dt 
ORDER BY 1;
