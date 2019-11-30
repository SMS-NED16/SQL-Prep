-- 13-1: Modify the account table so that customers may not have 
-- more than one account for each product.
/*
First, need to make sure that there is only one cust_id entry in the entire table per customer
Secondly, also need to make sure that that this is mapped to a single unique product_cd
*/
ALTER TABLE account 
ADD CONSTRAINT account_unq1 UNIQUE (cust_id, product_cd);

-- 13-2: Generate a multicolumn index on the `transaction` table that could be used by 
-- both of the following scripts.
/*
SELECT txn_date, account_id, txn_type_cd, amount
FROM transaction
WHERE txn_date > cast('2008-12-31 23:59:59' as datetime);

SELECT txn_date, account_id, txn_type_cd, amount
FROM transaction
WHERE txn_date > cast('2008-12-31 23:59:59' as datetime)
AND amount < 1000;
*/

/*
The first thing common to both queries is that they use the txn_date, so must
facilitate efficient lookup for date. The second query also uses amount, so this
is an additional second arg. 

Since just need to facilitate lookup, and don't need to ensure uniqueness, we can use 
an INDEX rather than a CONSTRAINT. 

A multicolumn constraint in which txn_date comes first, and then the amount (because we
both queries require dates, only one requires amount, and not on its own).
*/
CREATE INDEX txn_idx01 
ON transaction (txn_date, amount);