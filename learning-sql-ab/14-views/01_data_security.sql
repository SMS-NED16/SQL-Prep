/*
The first use case for a view was demonstrated in the previous example.
We want to give the user a public interface to private data not only which data
the user is able to access/modify, but also how they are able to do so. 

This is part of a larger use case for views called "Data Security" - we don't want 
to give SELECT access to all columns (or even all rows) of a table to a user, especially
when data is sensitive e.g. credit card information. Violates privacy policy and laws.

The solution is to (partially) omit the sensitive data.
*/

-- Constraining rows: a view that will allow users to access information about business customers only
-- The WHERE clause in the following VIEW creation limits row access to only business customers
CREATE VIEW business_customer_vw 
(
	cust_id, 
	fed_id, 
	cust_type_cd, 
	address,
	city,
	state,
	zipcode
)
AS 
SELECT cust_id,
	concat('end in ', substr(fed_id, 8, 4)) AS fed_id,
	cust_type_cd, 
	address,
	city, 
	state,
	postal_code
FROM customer 
-- This makes all the difference
WHERE cust_type_cd = 'B';
