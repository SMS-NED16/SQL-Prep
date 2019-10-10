-- EQUALITY CONDITIONS - Comparing one or more column values with literals or expressions
-- Column literals being equated to the value in a column
SELECT emp_id, fname, lname, title FROM employee WHERE title = 'Teller';
SELECT cust_id, fed_id, city FROM customer WHERE fed_id = '111-11-1111';
SELECT txn_id, txn_type_cd, amount FROM transaction WHERE amount = 375.25;

-- Equating column to the value returned from a subquery
dept_id = (SELECT dept_id FROM department WHERE name = 'Loans');

-- Two equality conditions: Selecting all products that are of a specific product type and joining them where the type_cd record is the same. Doing this only for customer accounts. So selected all customer account type products.
SELECT pt.name AS product_type, p.name AS product
FROM product AS p INNER JOIN product_type AS pt
	ON p.product_type_cd = pt.product_type_cd	/* First equality */
WHERE pt.name = 'Customer Accounts';			/* Second equality */

-- INEQUALITY CONDITION
SELECT pt.name AS product_type, p.name AS product
FROM product AS p INNER JOIN product_type AS pt
	ON p.product_type_cd = pt.product_type_cd
WHERE pt.name <> 'Customer Accounts';

-- Can also use != instead of <> as the not equal operator
SELECT pt.name AS product_type, p.name AS product
FROM product AS p INNER JOIN product_type AS pt
	ON p.product_type_cd = pt.product_type_cd
WHERE pt.name != 'Customer Accounts';

-- Use case: updating data e.g. deleting inactive accounts or closed accounts
DELETE FROM account
WHERE status = 'CLOSED' AND YEAR(close_date) = 1995;

-- MySQL sessions are in auto-commit mode by default. Won't be able to use BEGIN/ROLLBACK transactions to reverse changes. But the author has worked around this by writing queries that don't really make any changes to the original data, just in case. 


-- Range Conditions: <, >, <=, >=, BETWEEN
-- Upper limit for start date
SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date < '2002-01-01'
ORDER BY start_date;

-- Upper AND lower limits for start date
SELECT emp_id, fname, lname, start_date	
FROM employee
WHERE start_date < '2005-01-01' 
	AND start_date >= '2002-01-01';

-- Can also use the BETWEEN operator
SELECT emp_id, fname, lname, start_date
FROM employee
/* Specify lower range first */
WHERE start_date BETWEEN '2002-01-01' and '2003-01-01';

-- If you don't specify the lower bound with the BETWEEN operator first, then the query returns no results. Because a range with upper bound as lower bound argument makes no sense.
SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date BETWEEN '2003-01-01' AND '2002-01-01';


-- This is equivalent to the following query. No query will satisfy this start date condition.
SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date > '2003-01-01' AND start_date <= '2002-01-01';

-- When using the BETWEEN operators, the upper and lower bounds are inclusive. 
-- Query to get employees who started from start of 2002 but before start of 03
SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date BETWEEN '2002-01-01' AND '2002-12-31';

-- Query to get employees who started from beginning of 02 to beginning of 03
SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date BETWEEN '2002-01-01' AND '2003-01-01';

-- Ranges with other numeric columns
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE avail_balance BETWEEN 3000 AND 5000;

-- STRING RANGES
-- Query to find all customers with SSNs beteen 500k and 999-99-9999
SELECT cust_id, fed_id
FROM customer
WHERE cust_type_cd = 'I'
	AND fed_id BETWEEN '500-00-0000' AND '999-99-9999';

-- Knowing the order of characters (collation) in a string is important when using BETWEEN to search for strings.

-- Can use chained conditionals to check for multipled possible values
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd = 'CHK' OR product_cd = 'SAV' 
	OR product_cd = 'CD' OR product_cd = 'MM';

-- But this can get tedious. So use IN operator
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN ('CHK', 'SAV', 'CD', 'MM');

-- Can also select from the result set of a subquery. Since all four products in the previous query were all of account type, we could use a subquery for this type.
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN (
	SELECT  product_cd FROM product
	WHERE product_type_cd = 'ACCOUNT');

-- Can combine IN with NOT
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd NOT IN ('CHK', 'SAV', 'CD', 'MM');

-- Matching conditions - detecting partial string matches
-- Example 1 - Last name begins with a T
SELECT emp_id, fname, lname
FROM employee
WHERE LEFT(lname, 1) = 'T';		/*1st leftmost char is 'T'*/

-- EXAMPLE 2 - Using wildcards and/or regular expressions
/* Can be used for strings
	- beginning or ending with a certain character
	- beginning/ending with a substring
	- containing a certain character anywhere within the string
	- containing a substring anywhere within the string
	- strings with a specific format, regardless of individual characters
Use `_` to indicate exactly one character, and `%` to indicate any number of characters (zero or more)
*/
-- Select all lastnames which contain  `a` in the second position and `e`
-- between any number of other characters. This means one character _ must appear before a, and e can appear between any number of characters (including as the last character)
SELECT lname FROM employee WHERE lname LIKE '_a%e%';

-- F% string beginning with F
-- %t string ending with t
-- %bas% String containing the substring 'bas'
-- __t_  Four character string with a `t` in the third position
-- ___-__-____ 11 character strings with dashes in the fourth and seventh pos

-- EXAMPLE 3 - Find customers whose federal ID matches the SSN format
SELECT cust_id, fed_id 
FROM customer
WHERE fed_id LIKE '___-__-____';

-- EXAMPLE 4 - Multiple search expressions: In this case, we want ID, first name, and last name of all employees whose lastname begins with either F or G (and is thus a string with one F and one G followed by any number of chars) 
SELECT emp_id, fname, lname
FROM employee
WHERE lname LIKE 'F%' OR lname LIKE 'G%';

-- EXAMPLE 5 - Using regular expressions
SELECT emp_id, fname, lname
FROM employee
WHERE lname REGEXP '^[FG]';