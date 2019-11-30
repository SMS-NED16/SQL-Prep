/*
Another use case for views is to hide complexity: if a query draws on multiple tables and 
uses complicated aggregation functions, it's just easier to wrap its result set in a single view.
The DB user don't need to worry about HOW the result set was derived, but rather how to use it.

In this case, we're wrapping the result set of a monthly query that finds the total employees,
total transactions, and total number of active accounts of a branch for each month.

Saving the result as a view means the user does not have to navigate four different tables to get the data.
*/

CREATE VIEW branch_activity_vw 
(
	branch_name, 
	city,
	state,
	num_employees,
	num_active_accounts,
	tot_transactions
)
AS
-- This part of the query gets data directly from the br table
SELECT br.name, br.city, br.state,
-- First subquery: number of employees at that branch
(
	SELECT COUNT(*) 
	FROM employee AS emp
	WHERE emp.assigned_branch_id = br.branch_id
) AS num_emps, 
-- Second subquery: number of active accounts that were opened at that branch
(
	SELECT COUNT(*)
	FROM account AS acnt
	WHERE acnt.status = 'ACTIVE' AND acnt.open_branch_id = br.branch_id
) AS num_accounts, 
-- Number of transactions at that branch
(
	SELECT COUNT(*)
	FROM transaction AS txn 
	WHERE txn.execution_branch_id = br.branch_id
) AS num_txns
FROM branch as br;

-- These are all scalar subqueries, which will return a single value.