-- 8-1: Construct a query that counts the number of rows in the account table
SELECT COUNT(*) FROM account;

-- 8-2: Modify query from 8-1 to count number of accounts held by each customer.
-- Show the customer ID and the number of accounts per customer.
SELECT account_id, COUNT(account_id) AS accounts_held
FROM account 
GROUP BY account_id;

-- 8-3: Modify query from 8-2 to include only those customers having at least two accounts.
SELECT account_id, COUNT(account_id) AS accounts_held 
FROM account 
GROUP BY account_id 
HAVING COUNT(account_id) >= 2;

-- 8-4: Find total available balance by product and branch where there is more than one
-- account per product and branch. Order the results by the total balance (highest to lowest).
SELECT product_cd, 
	open_branch_id, 
	COUNT(*) AS num_accs, 
	SUM(avail_balance) AS total_balance
FROM account 							
GROUP BY product_cd, open_branch_id 	/* For each unique combination of branch and product */
HAVING COUNT(*) > 1 					/* More than one acc of this type at this branch */
ORDER BY SUM(avail_balance) DESC;		/* Highest to lowest */