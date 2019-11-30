/*
A view is a public interface to private data held in tables. Instead of giving users
complete, unrestricted access to entire data in table(s), create a named query - a view -
that they can use to access a subset of that data.

No data storage involved. Unlike indexes and constraints, they are not tables, and so don't
require disk spce. 
*/

-- Example: creating a custom view for customer table that hides social security nums and corporate identifiers
CREATE VIEW customer_vw
-- This part of the statement lists the column names for the view
(
	cust_id, 
	fed_id, 
	cust_type_cd,
	address,
	city,
	state,
	zipcode		/*Column names in views need not be same as table's*/
)
AS
-- This part of the statement defines how to get data from table for each column in the view
SELECT cust_id,
	/*Only last 4 digits of SSN*/
	concat('ends in ', substr(fed_id, 8, 4)) AS fed_id, 
	cust_type_cd,
	address, 
	city, 
	state,
	postal_code
FROM customer;

-- No query will be run when this VIEW is created. Instead, it will only be stored
-- as a VIEW that can be queried for later use.
SELECT cust_id, fed_id, cust_type_cd 
FROM customer_vw;	/*Querying the view, not the original table!*/

-- The actual query that is executed is a combination of the SELECT query and the 
-- CREATE VIEW query used to define the view. The equivalent query is 
SELECT cust_id, 
	concat('ends in ', substr(fed_id, 8, 4)) AS fed_id, 
	cust_type_cd 
FROM customer;

-- To the user, a VIEW is practically the same as a TABLE
DESCRIBE customer_vw;

-- Can use any SELECT statement clause when querying a view 
SELECT cust_type_cd, COUNT(*)
FROM customer_vw
WHERE state = 'MA'
GROUP BY cust_type_cd 
ORDER BY 1;

-- Can also join views to other tables, or other views 
SELECT cst.cust_id, cst.fed_id, bus.name 
FROM customer_vw AS cst INNER JOIN business AS bus 
	ON cst.cust_id = bus.cust_id;