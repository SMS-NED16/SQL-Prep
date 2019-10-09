-- EXERCISE 3-1: Retrieve employee ID, first name, last name, for all bank employees.
-- Sort by last name and then by first name.
SELECT emp_id, fname, lname
FROM employee
ORDER BY lname, fname;

-- Makes the ordering more apparent
SELECT emp_id, lname, fname
FROM employee
ORDER BY lname, fname;

-- EXERCISE 3-2: Retrieve account ID, customer ID, and available balance
-- for all accouns whose status equals 'ACTIVE' and whose available balance
-- is greater than USD 2.5k
SELECT account_id, cust_id AS customer_id, avail_balance AS available_balance
FROM account
WHERE 
	status = 'ACTIVE' 
	AND avail_balance > 2500;

/* Manually verify results by echoing status and sorting by balance */
SELECT account_id, cust_id AS customer_id, status, avail_balance AS available_balance
FROM account
WHERE 
	status = 'ACTIVE'
	AND avail_balance > 2500
ORDER BY avail_balance;

-- EXERCISE 3-3: Write a query against the account table that returns the IDs of the employees
-- who opened the accounts. Include a single row for each distinct employee.
-- Just asks for unique IDs, not other information. So no JOIN required.
SELECT DISTINCT emp_open_id FROM account;

-- EXERCISE 3-4: Write a query that uses an INNER JOIN to retrieve the customer id and available balance
-- for all products containing the word 'ACCOUNT', sorted by the product name and customer ID.
SELECT p.product_cd, a.cust_id, a.avail_balance
FROM product AS p INNER JOIN account AS a
	ON p.product_cd = a.product_cd
WHERE p.product_type_cd = 'ACCOUNT'
ORDER BY p.product_cd, a.cust_id;

/*
	This query selects the product_cd column from the product table where the product is a type 
	of account, and finds the customer ID and available balance for these accounts using an INNER JOIN
	with the account table wit the product_cd as a FOREIGN KEY. 

	It then sorts the result set first by the product_cd and then by the customer_id.
*/