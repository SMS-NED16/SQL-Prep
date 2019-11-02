-- Conditional Logic: choose a different path based on conditions of execution
-- E.g. return fname/lname if individual and business_name if business
-- Possible to do this with OUTER JOIN: caller will look at cust_type_cd and decide
-- which table to join. This is less than ideal: lots of NULLs in each column
SELECT c.cust_id, c.fed_id, c.cust_type_cd, 
	CONCAT(i.fname, ' ', i.lname) AS indiv_name,
	b.name AS business_name 
FROM customer AS c LEFT OUTER JOIN individual AS i
	ON c.cust_id = i.cust_id 
	LEFT OUTER JOIN business AS b 
	ON c.cust_id = b.cust_id;

-- Alternatively, can use CASE expresssions to determine cust type and return strings
-- Much better result set: no NULL values
SELECT c.cust_id, c.fed_id,
	CASE 
		WHEN c.cust_type_cd = 'I'
			THEN CONCAT(i.fname, ' ', i.lname) 
		WHEN c.cust_type_cd = 'B'
			THEN b.name 
		ELSE 'Unknown'
	END AS name
FROM customer AS c LEFT OUTER JOIN individual AS i
	ON c.cust_id = i.cust_id 
	LEFT OUTER JOIN business AS b 
	ON c.cust_id = b.cust_id;