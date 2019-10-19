/*
All subqueries in 02 were noncorrelated i.e. independent of the containing query.
They could be run and their result set examined without running containing query.
Noncorr queries are executed once prior to the execution of containing query,
but the corr query is executed once for each possible row that can be included in
the final result set.
*/

-- Containing query finds all rows in the customer table. Subquery will then 
-- find all cusomters with exactly 2 accounts. Correlated subquery because it
-- refers to the c.cust_id column, which is used in the containing query.
SELECT c.cust_id, c.cust_type_cd, c.city 
FROM customer AS c
WHERE 2 = (SELECT COUNT(*) 
	FROM account AS a 
	WHERE a.cust_id = c.cust_id
);

-- Another correlated subquery example: finds all customers, executes a subquery
-- that finds the total balance for all accounts related with this customer, and then
-- adds them to the final result set if the available balance is between 5k and 10k.
-- The correlated subquery is executed once for each row in the customer table
SELECT c.cust_id, c.cust_type_cd, c.city 
FROM customer AS c 
WHERE (SELECT SUM(a.avail_balance)
	FROM account AS a 
	WHERE a.cust_id = c.cust_id)
BETWEEN 5000 AND 10000;

-- EXISTS operator: returns any rows for which the specified subquery conditions are true
-- I.e. if a row exists that specifies the subquery, it is returned.
SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance 
FROM account AS a 
WHERE EXISTS (SELECT 1
	FROM transaction AS t 
	WHERE t.account_id = a.account_id AND t.txn_date = '2000-01-15');

-- It doesn't matter what we select in the EXISTS query: convention is to specify 1 or *
SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance
FROM account AS a
WHERE EXISTS (SELECT t.txn_id, 'hello', 3.1415927
	FROM transaction AS t
	WHERE t.account_id = a.account_id 
		AND t.txn_date = '2000-01-15');

-- NOT exists: finds all rows that do not exist in the result set of subquery
-- In this case, a roundabout way of finding all non-business customers
SELECT a.account_id, a.product_cd, a.cust_id 
FROM account AS a 
WHERE NOT EXISTS (SELECT 1
	FROM business AS b
	WHERE b.cust_id = a.cust_id);

-- Data manipulation in subqueries: used or update and delete
-- Updates the last_activity_date for each account to the txn_date for that account
-- This is still a correlated subquery. First it finds all accounts, then 
-- subquery finds the maximum value of txn date for all transactions for that account
-- and sets the account's last_activity_date to this value
UPDATE account AS a 
SET a.last_activity_date = 
	(SELECT MAX(t.txn_date) 
	FROM transaction AS t 
	WHERE t.account_id = a.account_id);

-- Safer to check if a transaction exists for an account otherwise will update 
-- last_activity_date to NULL
UPDATE account AS a
SET a.last_activity_date = 
	(SELECT MAX(t.txn_date)
	FROM transaction AS t 
	WHERE t.account_id = a.account_id)
WHERE EXISTS (SELECT 1 
	FROM transaction AS t
	WHERE t.account_id = a.account_id);