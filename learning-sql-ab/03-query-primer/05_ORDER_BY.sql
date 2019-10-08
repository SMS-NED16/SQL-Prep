-- ORDER BY clause is the mechanism for sorting your result set using either raw
-- colun data or expressions based on column data.

-- Result set of a SQL query will not be in any particular order.
SELECT open_emp_id, product_cd FROM account;

-- Can use the ORDER BY clause to specify which column's values to use for sorting result set
SELECT open_emp_id, product_cd 
FROM account
ORDER BY open_emp_id;	/* Ascending default */

-- Second ORDER BY column so that each customer's accounts are in ascending order
SELECT open_emp_id, product_cd 
FROM account 
ORDER BY open_emp_id, product_cd;

-- What happens when we use the distinct clause
SELECT DISTINCT open_emp_id, product_cd 
FROM account
ORDER BY open_emp_id, product_cd;

-- Specify ascending or descending order by the `asc` or `desc` keywords
SELECT account_id, product_cd, open_date, avail_balance
FROM account
ORDER BY avail_balance DESC;

-- Adding expressions to ORDER BY - when we want to sort based on data that isn't present in the table
-- Sorting customers by the last three digits of their federal ID
SELECT cust_id, cust_type_cd, city, state, fed_id
FROM customer
ORDER BY RIGHT(fed_id, 3);	/* RIGHT is a function that gets the rightmost chars */

-- Order based on the position of the column in the query's SELECT clause
SELECT emp_id, title, start_date, fname, lname
FROM employee
ORDER BY 2, 5;		/*Sort by 2nd and 5th columns - title, lname*/

-- Good for adhoc queries, but when writing code better to use column names