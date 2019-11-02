-- Updates the avail_balance for an account for a transaction based on 
-- availability of funds
UPDATE account 
	SET last_activity_date = CURRENT_TIMESTAMP(),
	pending_balance = pending_balance +
	(
		SELECT t.amount *
		CASE t.txn_type WHEN 'DBT' THEN -1 ELSE 1 END 
		FROM transaction as t
		WHERE t.txn_id = 999
	), 
	avail_balance = avail_balance + 
	(
		SELECT 
			CASE 
				WHEN t.funds_avail_date > CURRENT_TIMESTAMP() THEN 0
				ELSE t.amount * 
					CASE t.txn_type_cd WHEN 'DBT' THEN -1 ELSE 1 END
			END 
		FROM transaction AS t
		WHERE t.txn_id = 999
	)
WHERE account.account_id = (
	SELECT t.account_id 
	FROM transaction AS t 
	WHERE t.txn_id = 999
);

-- Display `Unknown` instead of a NULL for a field that is blank
SELECT emp_id, fname, lname,
CASE 
	WHEN title IS NULL THEN 'Unknown'
	ELSE title 
END AS title 
FROM employee;
