/*
	FROM clauses define tables used by a query as well as the means of linking
	the tables together. These tables may be 
	- permanent: created using the CREATE TABLE schema statement
	- temporary: result sets returned by a query
	- virtual: created using the CREATE VIEW statement
*/

-- Using a permanent table
SELECT emp_id, fname, lname FROM employee;

-- Using a virtual table with a subquery
/* Subquery returns the id, fname, lname, start date and title. The result 
of the query is stored in a temporary table that is accessible from all other 
query clauses. This table is often given an alias. */
SELECT e.emp_id, e.fname, e.lname 
FROM (SELECT emp_id, fname, lname, start_date, title FROM EMPLOYEE) AS e;

/* Views - virutal, data dictionary, no actual data is stored or replicated 
to be stored in a view. When we make a query on a view, it just looks up the
appropriate data in the appropriate tables. */
CREATE VIEW employee_view AS
SELECT emp_id, fname AS first_name, lname AS last_name,
	YEAR(start_date) AS start_year
FROM employee;

/* No data is created or modified when we make a view. The SELECT statement 
is simply stored for future use. This means we can query the view directly 
instead of writing out the SELECT statement as a subquery again. */
SELECT emp_id, start_year FROM employee_view;

/*
	If data SELECTED from more than one table, conditions used to link the
	tables must be included as well
*/
SELECT employee.emp_id, employee.fname, employee.lname, department.name AS dept_name
FROM employee INNER JOIN department 
ON employee.dept_id = department.dept_id
ORDER BY emp_id;

/* Using table aliases - makes for shorter, more readable code */
SELECT e.emp_id, e.fname, e.lname, d.name AS dept_name 
FROM employee AS e INNER JOIN department AS d
ON e.dept_id = d.dept_id; 


/* Don't need to include the AS keyword */
SELECT e.emp_id, e.fname, e.lname, d.name dept_name
FROM employee e INNER JOIN department d 
ON e.dept_id = d.dept_id;