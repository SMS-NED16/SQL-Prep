-- 10-1: Query that returns all product names along with accounts based on that product.
-- Includes all products, even if no accounts have been opened for that product.
SELECT p.name, p.product_cd, a.account_id 
FROM product AS p LEFT OUTER JOIN account AS a 
	ON p.product_cd = a.product_cd;

-- 10-2: Reformulate your query from 10-1 to use the other outer join type such that
-- the results are identical to those in 10-1.
SELECT p.name, p.product_cd, a.account_id 
FROM account AS a RIGHT OUTER JOIN product AS p
	ON p.product_cd = a.product_cd;

-- 10-3: Outer-join the account tabel to both the individual table and business table
-- such that the result set contains one row per account. 
SELECT a.account_id, a.product_cd, i.fname, i.lname, b.name 
FROM account AS a LEFT OUTER JOIN individual AS i 
	ON a.cust_id = i.cust_id
	LEFT outer JOIN business AS b 
	ON a.cust_id = b.cust_id 
ORDER BY 1;

-- 10-4: Devise a query that will generate the set {1, 2, 3,...,99,100}
SELECT (ones.num + tens.num + hundreds.num)  
FROM 
(
	SELECT 0 AS num UNION ALL
	SELECT 1 AS num UNION ALL
	SELECT 2 AS num UNION ALL
	SELECT 3 AS num UNION ALL
	SELECT 4 AS num UNION ALL
	SELECT 5 AS num UNION ALL
	SELECT 6 AS num UNION ALL
	SELECT 7 AS num UNION ALL
	SELECT 8 AS num
) AS ones 
CROSS JOIN 
(
	SELECT 0 as num UNION ALL
	SELECT 10 as num UNION ALL
	SELECT 20 as num UNION ALL
	SELECT 30 as num UNION ALL
	SELECT 40 as num UNION ALL
	SELECT 50 as num UNION ALL
	SELECT 60 as num UNION ALL
	SELECT 70 as num UNION ALL
	SELECT 80 as num UNION ALL
	SELECT 90 as num
) AS tens 
CROSS JOIN 
(
	SELECT 000 AS num UNION ALL 
	SELECT 100 AS num
) AS hundreds
SELECT (ones.num + tens.num + hundreds.num)  
FROM 
(
	SELECT 0 AS num UNION ALL
	SELECT 1 AS num UNION ALL
	SELECT 2 AS num UNION ALL
	SELECT 3 AS num UNION ALL
	SELECT 4 AS num UNION ALL
	SELECT 5 AS num UNION ALL
	SELECT 6 AS num UNION ALL
	SELECT 7 AS num UNION ALL
	SELECT 8 AS num
) AS ones 
CROSS JOIN 
(
	SELECT 0 as num UNION ALL
	SELECT 10 as num UNION ALL
	SELECT 20 as num UNION ALL
	SELECT 30 as num UNION ALL
	SELECT 40 as num UNION ALL
	SELECT 50 as num UNION ALL
	SELECT 60 as num UNION ALL
	SELECT 70 as num UNION ALL
	SELECT 80 as num UNION ALL
	SELECT 90 as num
) AS tens 
CROSS JOIN 
(
	SELECT 000 AS num UNION ALL 
	SELECT 100 AS num
) AS hundreds
WHERE (ones.num + tens.num + hundreds.num) < 101
ORDER BY 1;

-- Not the best solution because without the filter condition it generates 198 rows
-- We want to generate fewer rows and possibly do without a filter condition.
-- Better solution: fewer cross joins, fewer rows generated, no filter condition
SELECT ones.num + tens.num + 1 
FROM 
(
	SELECT 0 AS num UNION ALL
	SELECT 1 AS num UNION ALL
	SELECT 2 AS num UNION ALL
	SELECT 3 AS num UNION ALL
	SELECT 4 AS num UNION ALL
	SELECT 5 AS num UNION ALL
	SELECT 6 AS num UNION ALL
	SELECT 7 AS num UNION ALL
	SELECT 8 AS num UNION ALL 
	SELECT 9 AS num
) AS ones 
CROSS JOIN 
(
	SELECT 0 as num UNION ALL
	SELECT 10 as num UNION ALL
	SELECT 20 as num UNION ALL
	SELECT 30 as num UNION ALL
	SELECT 40 as num UNION ALL
	SELECT 50 as num UNION ALL
	SELECT 60 as num UNION ALL
	SELECT 70 as num UNION ALL
	SELECT 80 as num UNION ALL
	SELECT 90 as num
) AS tens;