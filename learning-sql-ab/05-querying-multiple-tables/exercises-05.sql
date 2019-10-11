-- Exercise 01 - select names of employees and the branches they work at.
SELECT e.emp_id, e.fname, e.lname, b.name 
FROM employee AS e INNER JOIN branch AS b
	ON e.assigned_branch_id = b.branch_id;

-- Exercise 02 - Query that returns the account ID for each nonbusiness customers with the customers federal ID and name of the product on which the account is based.
SELECT a.account_id, c.fed_id, p.name
FROM account AS a INNER JOIN customer AS c
	ON a.account_id = c.cust_id
	INNER JOIN product AS p
	ON p.product_cd = a.product_cd
WHERE c.cust_type_cd = 'I';

-- Exercise 03 - Query that finds all employees whose supervisor is assigned to a different department. Retrieves employees' ID, first name, last name.
SELECT e.emp_id, e.fname, e.lname, e.dept_id AS emp_dept, 
e.superior_emp_id AS sup_id, e_mgr.dept_id AS mgr_dept_id 
FROM employee AS e INNER JOIN employee AS e_mgr
	ON e.superior_emp_id = e_mgr.emp_id
WHERE e.dept_id != e_mgr.dept_id;

-- Modifying the prev query to get names too 
SELECT e.emp_id, e.fname, e.lname, e.dept_id, d.name AS emp_dept
FROM employee AS e INNER JOIN employee AS e_mgr
	ON e.superior_emp_id = e_mgr.emp_id
	INNER JOIN department AS d 
	ON e.dept_id = d.dept_id
WHERE e.dept_id != e_mgr.dept_id;