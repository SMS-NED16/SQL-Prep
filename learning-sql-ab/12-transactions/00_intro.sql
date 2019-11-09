-- Example of a transaction that transfers money between accounts. If even
-- one step of the entire process fails, the transaction will rollback all changes
START TRANSACTION;

-- Withdraw money from the first account, making sure balance is sufficient
UPDATE account SET avail_balance = avail_balance - 500 
WHERE account_id = 9988
	AND avail_balance > 500;

IF <exactly one row was updated by the previous statement> THEN
-- Deposit money in the second account 
	UPDATE account SET avail_balance = avail_balance + 500 
		WEHRE account_id = 9988;

IF <exactly one row was updated by the previou statement> THEN
-- Everything worked, make the changes permanent 
	COMMIT;
ELSE 
-- Something went wrong. Undo all changes in this transation
	ROLLBACK;
ENDIF
ELSE
	-- Insufficient funds or error encountered during update 
	ROLLBACK;
END IF;

-- Author recommends turning off all implicit transactions every time we log in
-- This means we will have explicitly specify beginning and end of transaction blocks
-- and explicitly commit changes before they become permanent.
SET AUTOCOMMIT=0

