-- Filter conditions -> WHERE clause, Join conditions -> ON subclause

-- Correct query: Account ID and product type for all business accounts
SELECT a.account_id, a.product_cd, c.fed_id
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';

-- What happens when filter condition added to the ON subclause?
SELECT a.account_id, a.product_cd, c.fed_id
FROM account AS a INNER JOIN customer AS c
	ON a.cust_id = c.cust_id
		AND c.cust_type_cd = 'B';
/* No WHERE clause, filter condition added as additional condition in JOIN subclause, but the results are the same*/

-- What happens when we put both conditions in the WHERE clause?
SELECT a.account_id, a.product_cd, c.fed_id
FROM account AS a INNER JOIN customer AS c
WHERE a.cust_id = c.cust_id
	AND c.cust_type_cd = 'B';


/* Where we place the conditions makes no difference as far the result is concerned. However, for readable, maintainable queries, we should put the conditions in the right places. JOIN conditions in the ON subclause, and filter conditions in the WHERE subclause.*/