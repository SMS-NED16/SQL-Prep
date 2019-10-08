-- GROUP BY query is used with an aggregator function to return a modified result set
-- Allows us to modify the data prior to being returned as a result set.


-- Query that uses GROUP BY to count the total number of employees of each title
SELECT e.title, COUNT(e.title)
FROM employee AS e
GROUP BY e.title;
-- +--------------------+----------------+
-- | title              | COUNT(e.title) |
-- +--------------------+----------------+
-- | President          |              1 |
-- | Vice President     |              1 |
-- | Treasurer          |              1 |
-- | Operations Manager |              1 |
-- | Loan Manager       |              1 |
-- | Head Teller        |              4 |
-- | Teller             |              9 |
-- +--------------------+----------------+
-- 7 rows in set (0.00 sec)

-- Query that counts all employees in each department

/*Select name of department, count of employee ids with alias*/
SELECT d.name, COUNT(e.emp_id) AS num_employees

/*From the department table with alias `d` joined with the employee table with alias `e`*/
FROM department AS d INNER JOIN employee AS e

/*Join is done using the department id column in both tables*/
ON d.dept_id = e.dept_id 

/* Group the counts according to the department names*/
GROUP BY d.name;

/* Modify the last query to select only those departments with more than 2 employees */
SELECT d.name, COUNT(e.emp_id) AS num_employees
FROM department as d INNER JOIN employee as e
ON d.dept_id = e.dept_id 
GROUP BY d.name 
HAVING COUNT(e.emp_id) > 2;
-- +----------------+---------------+
-- | name           | num_employees |
-- +----------------+---------------+
-- | Operations     |            14 |
-- | Administration |             3 |
-- +----------------+---------------+