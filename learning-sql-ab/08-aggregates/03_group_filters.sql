-- Recall that the HAVING clause is used for applying filter conditions to data returned by grouping
SELECT product_cd, SUM(avail_balance) AS product_balance 
FROM account 
WHERE status = 'ACTIVE'					/* Filters raw data before it is grouped */
GROUP BY product_cd 
HAVING SUM(avail_balance) >= 10000;		/* Filters result set of grouping after data grouped */

-- Cannot refer to an aggregate function in a query's WHERE clause
SELECT product_cd, SUM(avail_balance) AS product_balance
FROM account
WHERE status = 'ACTIVE'
	AND SUM(avail_balance) >= 10000
GROUP BY product_cd;					/* Query will fail */

-- However, we can refer to an aggregate function that is not present in the SELECT clause
SELECT product_cd, SUM(avail_balance) AS product_balance
FROM account
WHERE status = 'ACTIVE'
GROUP BY product_cd 
HAVING MIN(avail_balance) >= 1000
	AND MAX(avail_balance) <= 10000;

-- Query generates SUM(avail_balance) for all products, but HAVING clause filters the result set
-- by removing any products whose balance is < 1k or > 10k