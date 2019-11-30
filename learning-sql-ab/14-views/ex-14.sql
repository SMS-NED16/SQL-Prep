-- 14-1 Employee-superior view: shows the supervisor for each employee w/o using WHERE
CREATE VIEW emp_supervisor_vw 
(
	supervisor_name, 
	employee_name 
)
AS 
SELECT 
	CONCAT(emp_super.fname, ' ', emp_super.lname) AS supervisor_name,
	CONCAT(emp.fname, ' ', emp.lname) AS employee_name
	FROM employee AS emp_super
	RIGHT OUTER JOIN employee AS emp
		ON emp_super.emp_id = emp.superior_emp_id;

-- 14-2: Generate report showing name, city of each branch + total balances of all accounts
-- opened at the branch.
CREATE VIEW branch_summary_vw
(
	branch_name,
	branch_city,
	total_balance
)
AS
SELECT b.name, b.city, SUM(a.avail_balance)
FROM branch AS b INNER JOIN account AS a 
	ON b.branch_id = a.open_branch_id 
GROUP BY b.name, b.city;
