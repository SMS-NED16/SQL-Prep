/*
Data in a table is often split into two or more tables to improve database performance.
For instance, if there are too many transactions, we may want to split the transactions into
two separate tables: `current` for the last 6 months of transactions, and `historic` for all others.

If a customer wants transaction data that spans this entire period, we will have to join the two
tables and present their data as a single view.
*/
CREATE VIEW transaction_vw
(
	txn_date,
	account_id,
	txn_type_cd,
	amount,
	teller_emp_id, 
	execution_branch_id,
	funds_avail_date
)
AS
SELECT txn_date, account_id, txn_type_cd, amount, teller_emp_id,
	execution_branch_id, funds_avail_date
FROM transaction_historic
UNION ALL
SELECT txn_date, account_id, txn_type_cd, amount, teller_emp_id, 
	execution_branch_id, funds_avail_date 
FROM transaction_current;