-- INTERSECT operation not defined in MySQL. But using it anyway.

-- Finds ID and name of employees who are also customers. No such entries exists. So empty result set.
SELECT emp_id, fname, lname
FROM employee
INTERSECT
SELECT cust_id, fname, lname
FROM individual;

-- Non-empty result set.
SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
INTERSECT
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;