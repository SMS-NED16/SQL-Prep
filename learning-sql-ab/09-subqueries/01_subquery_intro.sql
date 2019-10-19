-- Basic subquery to find the accound_id, product_cd, customer_id and available balance
-- for the account with the largest ID
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE account_id = (SELECT MAX(account_id) FROM account);

-- The subquery itself just returns the highest account_id from account
SELECT MAX(account_id) FROM account;

-- Because this subquery returns a single value, it's equivalent to 
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE account_id = 29;

-- Not the same as the most recently opened account
SELECT account_id, product_cd, cust_id, open_date, avail_balance
FROM account
WHERE open_date = (SELECT MAX(open_date) FROM account);