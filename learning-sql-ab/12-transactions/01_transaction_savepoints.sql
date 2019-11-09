-- Savepoints allow the transaction to be rolled back to a point other than
-- than the beginning of the transaction. This means not all the work in the 
-- transaction will be lost.
START TRANSACTION;

UPDATE product 
SET date_retired = CURRENT_TIMESTAMP()
WHERE product_cd = 'XYZ';

-- Defined a save point in the middle of the transaction
SAVEPOINT before_close_accounts;

-- Second part of the transaction
UPDATE account 
SET status = 'CLOSED', close_date = CURRENT_TIMESTAMP(), 
	last_activity_date = CURRENT_TIMESTAMP()
WHERE product_cd = 'XYZ';

ROLLBACK TO SAVEPOINT before_close_accounts;
COMMIT;

-- Due to the rollback, the 'XYZ' product will have closed, but none of the
-- accounts of that product will have been affected.