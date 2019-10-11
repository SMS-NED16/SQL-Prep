/* Self join: when a table is joined to itself using a self-referential foreign key. E.g. in employee table, there is a key called "superior_emp_id"*/
SELECT e.fname, e.lname, e_mgr.fname AS mgr_fname, e_mgr.lname AS mgr_lname
FROM employee AS e INNER JOIN employee AS e_mgr
	ON e.superior_emp_id = e_mgr.emp_id;


/* Confirming with emp_ids */
SELECT e.fname, e.lname, e.superior_emp_id, 
	e_mgr.emp_id AS mgr_id, e_mgr.fname AS mgr_fname, e_mgr.lname AS mgr_lname
FROM employee AS e INNER JOIN employee AS e_mgr
	ON e.superior_emp_id = e_mgr.emp_id;