-- One way of verifying how many accounts have been opened by each bank teller
-- Is to print all open_emp_ids: not scalable, will be tedious if accounts/emps increase
SELECT open_emp_id FROM account;	

-- Ask DB server to group accounts by their open_emp_ids
SELECT open_emp_id FROM account GROUP BY open_emp_id;

-- This gives the same results as 
SELECT DISTINCT open_emp_id FROM account;	

-- Use COUNT() - an aggregate function to count how many rows belong to each GROUP BY category
SELECT open_emp_id, COUNT(*) 	/*COUNT(*) counts number of rows in each group */
FROM account 
GROUP BY open_emp_id;

-- Results are the same as this. What does it mean for COUNT(*) to count everything in the group?
SELECT open_emp_id, COUNT(open_emp_id)
FROM account
GROUP BY open_emp_id;

-- Combining GROUP BY clauses with COUNT
-- The following query won't work. GROUP BY runs after WHERE has been evaluated, so can't
-- add filter conditions to WHERE clause. TLDR: Cannot refer to aggregate functions in WHERE.
SELECT open_emp_id, COUNT(*) AS how_many
FROM account
WHERE COUNT(*) > 4
GROUP BY open_emp_id;

-- If a filter condition applies to groups and not raw data, use HAVING clause
-- This works, because the filtering is done AFTER the group by runs and applies to the 
-- results of the GROUP by query and not to raw data itself.
SELECT open_emp_id, COUNT(*) AS how_many 
FROM account
GROUP BY open_emp_id 
HAVING COUNT(*) > 4;