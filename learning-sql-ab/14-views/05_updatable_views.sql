/*
Views can be updated if 
- No aggregate functions are used.
- The view does not use GROUP BY or HAVING clauses.
- No subqueries in the SELECT or FROM clause, and any subqueries in the 
WHERE clause do not refer to tables in the FROM clause (non-correlated).
- The view does not use UNION, UNION ALL, or DISTINCT. 
- FROM clause contains at least one table or updatable view.
- FROM clause uses only inner joins if multiple tables used.
*/

-- UPDATING SIMPLE VIEWS
-- Recall the simple `customer_vw` we created at the beginning of the chapter
CREATE VIEW customer_vw 
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
SELECT cust_id 
	concat('ends in ', substr(fed_id, 8, 4)) AS fed_id, 
	cust_type_cd, 
	address,
	city,
	state,
	postal_code
FROM customer;

/*
This view can be updated because
- it queries at least one table.
- it does not use any joins (so no need to worry about INNER/OUTER joins)
- it does not use GROUP BY or HAVING clauses
- it does not use aggregate functions.
- No subqueries in the SELECT or FROM clause
	- and no WHERE clause to worry about correlated subqueries
*/
UPDATE customer_vw
SET city = 'Wooburn' 
WHERE city = 'Woburn';		/* Spelling of Woburn changed*/

-- Confirm the change affected the view
SELECT DISTINCT city FROM customer_vw;

-- Remember that this change will also affect the underlying table 
SELECT DISTINCT city FROM customer;

-- Won't be able to modify `fed_id` because it is derived: 
-- no matching column to update in underlying table
UPDATE customer_vw 
SET city = 'Woburn', fed_id = '999999999'
WHERE city = 'Wooburn';

-- Cannot insert data through views that contain derived columns, even if derived data
-- is not being inserted. 
INSERT INTO customer_vw(cust_id, cust_type_cd, city)
VALUES (9999, 'I', 'Worcester');

-- Complex views will often combine data from multiple tables
CREATE VIEW business_customer_vw1 /* Another business customer view already existed in my session*/
(
	cust_id, 
	fed_id, 
	address,
	city,
	state,
	postal_code, 
	business_name, 
	state_id, 
	incorp_date
)
AS 
SELECT cst.cust_id, cst.fed_id, cst.address, cst.city, cst.state, cst.postal_code,
	bsn.name, bsn.state_id, bsn.incorp_date 
FROM customer AS cst INNER JOIN business AS bsn 
	ON  cst.cust_id = bsn.cust_id 
WHERE cust_type_cd = 'B';

/*
Is this view updatable?
- Even though it draws data from 2 different tables, it uses an INNER JOIN.
- It doesn't use any aggregate functions. 
- It doesn't use any GROUP BY or HAVING clauses.
- It does query at least one table. 
- It doesn't use any subqueries in the SELECT or FROM clause, and also doesn't include
any query in the WHERE clause.

So yes, this is an updatable view. Specifically, this view can be used to update 
data in the business and/or the individual tables.
*/

-- Updates only the `individual`/`customer` table
UPDATE business_customer_vw1 
SET postal_code = '99999'
WHERE cust_id = 10;

-- Updates only the `business` table
UPDATE business_customer_vw1
SET incorp_date = '2008-11-17'
WHERE cust_id = 10;

-- Can we update both simultaneously? No.
UPDATE business_customer_vw1
SET postal_code = '88888', incorp_date = '2008-10-31'
WHERE cust_id = 10;

-- So can update all underlying tables in a view, but not with a single statement.

-- What about inserting data?
-- This works because it updates a single table - in this case, the customer table
INSERT INTO business_customer_vw1
	(cust_id, fed_id, address, city, state, postal_code)
VALUES (99, '04-9999999', '99 Main St.', 'Peabody', 'MA', '01975');

-- This does not work because even though the `business` table does have `cust_id`,
-- in the view definition, `cust_id` is mapped to the `customer` table.
-- So technically, it attempts to update two tables with a single statement, which is why it fails.
INSERT INTO business_customer_vw1
	(cust_id, business_name, state_id, incorp_date)
	VALUES(99, 'Ninety-Nine Restaurant', '99-999-999', '1999-01-01');