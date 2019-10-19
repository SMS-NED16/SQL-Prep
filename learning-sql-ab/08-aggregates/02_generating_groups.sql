-- Single Column Grouping: Finding total balances for the each product
SELECT product_cd, SUM(avail_balance) AS product_balance
FROM account
GROUP BY product_cd;		/* Single column */

-- Multicolumn Grouping: Finding total balances for each product at each branch
SELECT product_cd, open_branch_id, SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd, open_branch_id
ORDER BY product_cd;

-- In comparison, a single column grouping for the same columns would look like this
SELECT product_cd, open_branch_id, SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd 
ORDER BY product_cd;

-- Error: Nonaggregated column open_branch_id is compatible with the GROUP BY clause specified

-- Can also group via expressions: groups employees by the year they started working at the bank
SELECT EXTRACT(YEAR FROM start_date) AS year,
	COUNT(*) AS how_many
FROM employee
GROUP BY EXTRACT(YEAR FROM start_date);

-- What if we wanted total balance for each distinct branch/product combo as well as 
-- total balance for each distinct product?
-- Method 1: Run separate queries and merge results
SELECT product_cd, open_branch_id,
	SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd, open_branch_id;

SELECT product_cd, SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd;

-- Method 2: Use rollup
SELECT product_cd, open_branch_id, SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd, open_branch_id WITH ROLLUP;

/*
The rollup will generate 7 additional rows in the result set: one for each of the 
6 different types of accounts (which will have NULL as open_branch_id) and one for the 
sum total of all accounts (which will have NULL fro product_cd and open_branch_id).
*/

-- If we also want the total_balance for all branches as well as product_types, use WITH CUBE
-- WITH CUBE is not implemented as part of MySQL 8.7
SELECT product_cd, open_branch_id, SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd WITH CUBE;