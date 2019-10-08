-- The WHERE clause is the mechanism for filtering out unwanted rows from your result set.
-- This is useful because we will not often want to select ALL rows from the dataset.

-- Query that selects only bank tellers from the employee table
SELECT emp_id, fname, lname, start_date, title 
FROM employee
WHERE title = 'Head Teller';

-- Can chain as many conditions as we want in the WHERE clause
SELECT emp_id, fname, lname, start_date, title 
FROM employee
WHERE
	title = 'Head Teller'
	AND start_date > '2001-01-01';

-- Changing the conditional to OR will change the result set
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE 
	title = 'Head Teller'
	OR start_date > '2001-01-01';

-- Use parentheses to group AND and OR conditions in WHERE clause
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE 
	(title = 'Head Teller' AND start_date > '2001-01-01')
	OR (title = 'Teller' AND start_date > '2002-01-01');