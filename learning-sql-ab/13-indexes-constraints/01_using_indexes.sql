-- Indexes are used to quickly locate rows in a table, after which the server
-- will visit the associated table to extract additional information.
SELECT emp_id, fname, lname 
FROM employee 
WHERE emp_id IN (1, 3, 9, 15);	/* Found using primary key as index */

-- Not necessary to visit the table if index contains all information required by query
SELECT cust_id, SUM(avail_balance) AS tot_bal 
FROM account 
WHERE cust_id IN (1, 5, 9, 11) 
GROUP BY cust_id;

-- How does MySQL query optimizer execute the query? Which index does it use?
EXPLAIN 
SELECT cust_id, SUM(avail_balance) AS tot_bal 
FROM account 
WHERE cust_id IN (1, 5, 9, 11)
GROUP BY cust_id \G;

/*
Expected Output
*************************** 1. row ***************************
id: 1 select_type: SIMPLE
table: account type: index
possible_keys: fk_a_cust_id 
key: fk_a_cust_id
key_len: 4 ref: NULL
rows: 24
Extra: Using where
1 row in set (0.00 sec)

Actual Output
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: account
   partitions: NULL
         type: range
possible_keys: fk_a_cust_id
          key: fk_a_cust_id
      key_len: 4
          ref: NULL
         rows: 8
     filtered: 100.00
        Extra: Using index condition
1 row in set, 1 warning (0.00 sec)
*/

-- Adding a new index to the cust_id and avail_balance columns - multicolumn index
ALTER TABLE account 
ADD INDEX acc_bal_idx (cust_id, avail_balance);

-- How does the query optimizer's behaviour change?
EXPLAIN
SELECT cust_id, SUM(avail_balance) AS tot_bal 
FROM account 
WHERE cust_id IN (1, 5, 9, 11)
GROUP BY cust_id \G;

/*
Output
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: account
   partitions: NULL
         type: range
possible_keys: acc_bal_idx
          key: acc_bal_idx
      key_len: 4
          ref: NULL
         rows: 8
     filtered: 100.00
        Extra: Using where; Using 
*/