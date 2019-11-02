-- Use case 1: Result Set Transformations
-- Number of accounts opened in the years 2000 through 2005
SELECT YEAR(open_date) AS year, COUNT(*) AS how_many
FROM account 
WHERE open_date > '1999-12-31'
	AND open_date < '2006-01-01'
GROUP BY YEAR(open_date)
ORDER BY YEAR(open_date);

-- What if we wanted this result set with a single row and multiple columns?
SELECT
	SUM(CASE 
		WHEN EXTRACT(YEAR FROM open_date) = 2000 THEN 1
		ELSE 0
		END) AS year_2000,
	SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2001 THEN 1
		ELSE 0
		END) AS year_2001, 
	SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2002 THEN 1
		ELSE 0
		END) AS year_2002,
	SUM(CASE 
		WHEN EXTRACT(YEAR FROM open_date) = 2003 THEN 1
		ELSE 0
		END) AS year_2003,
	SUM(CASE 
		WHEN EXTRACT(YEAR FROM open_date) = 2004 THEN 1
		ELSE 0 
		END) AS year_2004
FROM account 
WHERE open_date > '1999-12-31' AND open_date < '2006-01-01';

-- Use case 3: Checking for existence of a certain relationship b/w entries
SELECT c.cust_id, c.fed_id, c.cust_type_cd,
CASE
	WHEN EXISTS (SELECT 1 FROM account AS a
		WHERE a.cust_id = c.cust_id
			AND a.product_cd = 'CHK') THEN 'Y'
	ELSE 'N'
END AS has_checking, 
CASE 
	WHEN EXISTS (SELECT 1 FROM account AS a
		WHERE a.cust_id = c.cust_id
			AND a.product_cd = 'SAV') THEN 'Y'
	ELSE 'N'
END AS has_savings
FROM customer AS c;

-- Use case 4: counting number of accounts for each customer up to a limit
SELECT c.cust_id, c.fed_id, c.cust_type_cd,
CASE (SELECT COUNT(*) FROM account AS a
	WHERE a.cust_id = c.cust_id)
	WHEN 0 THEN 'None'
	WHEN 1 THEN '1'
	WHEN 2 THEN '2'
	ELSE '3+'
END AS num_accounts 
FROM customer AS c;

-- Use case 5: Division by zero errors
-- MySQL will reset the value of a calculation to NULL if division by 0 occurs
SELECT 100 / 0;

-- Can use conditional logic to check for division by 0 errors in all denominators
-- Uncorrelated subquery finds total balances of all different types of accounts 
-- Containing statement will then use the result set of the subqueyr as prod_tots
-- To find the available balance of each customer's account as a %age of the total balance
-- for all accounts of that type. It also uses conditional logic to check for cases where
-- the denomintator is 0, and then sets the denom to 1.
SELECT a.cust_id, a.product_cd, a.avail_balance /
CASE 
	WHEN prod_tots.tot_balance = 0 THEN 1
	ELSE prod_tots.tot_balance 
END AS percent_total
FROM account AS a INNER JOIN 
(
	SELECT a.product_cd, SUM(a.avail_balance) AS tot_balance 
	FROM account AS a
	GROUP BY a.product_cd) AS prod_tots
ON a.product_cd = prod_tots.product_cd;