/* EXERCISES 04 */

-- 4-1: Query that returns all transaction IDs such that the transaction date is after 26th Feb, 2002 and the txn is either a dbt or has amount > 100
SELECT txn_id, txn_date, txn_date, txn_type_cd, amount
FROM transaction
WHERE txn_date < '2002-02-26' 
	AND (txn_type_cd = 'DBT' OR amount > 100);

-- 4-2: 

-- 4-3: Query that retrieves all accounts opened in 2002
SELECT * FROM account WHERE YEAR(open_date) = 2002;

-- 4-4: Finds all nonbusiness customers whose last name contains an `a` in the second position and an `e` anywhere after the a
SELECT c.cust_id, i.fname, i.lname
FROM customer AS c INNER JOIN individual AS i
	ON c.cust_id = i.cust_id
WHERE c.cust_type_cd = 'I' 
	AND i.lname LIKE '_a%e%'; 

-- I found that specifying the 'I' as c.cust_type is not necessary because of the inner join with the individual table.
SELECT c.cust_id, i.fname, i.lname
FROM customer AS c INNER JOIN individual AS i
	ON c.cust_id = i.cust_id
WHERE i.lname LIKE '_a%e%';