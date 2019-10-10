-- All conditions in the WHERE clause of a data statement must evaluate to true 
-- for a non-null result-set.

-- This will return all employees who are tellers and started working before 2007
SELECT * FROM employee 
WHERE 
	title = 'Teller' 
	AND start_date < '2002-01-01';

-- This will return all employees that are either tellers or started working
-- before 2002 OR BOTH. The only way for an employee to be excluded is if the employee
-- is not a teller and was not employed before 2002
SELECT * FROM employee
WHERE
	title = 'Teller'
	OR start_date < '2002-01-01';

-- When three or more conditions, use parentheses. In this case, 2 of the three conditions
-- have to be true for the employee to be a part of the result set.
SELECT emp_id, fname, lname, start_date, end_date 
FROM employee
WHERE end_date IS NULL
	AND (title = 'Teller' OR start_date < '2001-01-01');

-- NOT operator
-- In this case, we are looking for non-terminated employees who are not bank tellers and did not start before 2002.
SELECT emp_id, fname, lname, title, start_date, end_date
FROM employee
WHERE end_date IS NULL
	AND NOT (title = 'Teller' OR start_date < '2002-01-01');

-- Can rewrite the same query to avoid using the NOT operator
SELECT emp_id, fname, lname, start_date, end_date, title
FROM employee
WHERE end_date IS NULL
	AND (title != 'Teller' AND start_date >= '2002-01-01');