-- Use CASE statements over built-in if-else functions because
-- 1. Portable: implemented as part of SQL standard across all major SQL variants
-- 2. Built into SQL grammar, can be included in SELECT, INSERT, UPDATE, DELETE

-- Searched Case Expressions: CASE->WHEN->THEN
-- Example 1: Returning teller categories 
SELECT emp_id, start_date, title,
CASE
	WHEN title = 'Head Teller'
		THEN 'Head Teller'
	WHEN title = 'Teller'
		AND YEAR(start_date) >= 2003
		THEN 'Teller Trainee'
	WHEN title = 'Teller'
		AND YEAR(start_date) <= 2002
		THEN 'Experienced Teller'
	WHEN title = 'Teller' 
		THEN 'Teller'
	ELSE 'Non-Teller'
END AS modified_title
FROM employee;

-- Example 2: Returning other types of expressions e.g. subqueries
-- Using subqueries instead of outer joins to return individual and business names
SELECT c.cust_id, c.fed_id,
CASE
	WHEN c.cust_type_cd = 'I' THEN 
		(SELECT CONCAT(i.fname, ' ', i.lname)
		FROM individual AS i
		WHERE i.cust_id = c.cust_id)
	WHEN c.cust_type_cd = 'B' THEN 
		(SELECT b.name
		FROM business AS b
		WHERE b.cust_id = c.cust_id)
	ELSE 'Unknown'
END AS name 
FROM customer AS c;	

-- Simple case expression: compares values V1, V2,..., VN to V0 and does something
-- different depending on how the two values compare. 
SELECT c.cust_id, c.fed_id, 
CASE c.cust_type_cd 
	WHEN 'I' THEN
		(SELECT CONCAT(i.fname, ' ', i.lname)
		FROM individual AS i
		WHERE i.cust_id = c.cust_id)
	WHEN 'B' THEN 
		(SELECT b.name 
		FROM business AS b
		WHERE b.cust_id = c.cust_id)
	ELSE 'Unknown Customer Type'
END AS name 
FROM customer AS c;

/*
	The difference between the former and latter queries is that the former allows us 
	to specify any case expression wrt any column, whereas the latter only allows case 
	expressions involving the value of a specific column (i.e. cust_type_cd). Also the 
	latter only allows for EQUALITY case expressions, whereas the former allows us to use 
	any kind of relational logic in the case expressions.
*/