-- Returns the first table minus any overlap with the second table.Should return 11 and 12. 
SELECT emp_id 
FROM employee
WHERE assigned_branch_id = 2
	AND (title = 'Teller' OR title = 'Head Teller')
EXCEPT 
SELECT DISTINCT open_emp_id 
FROM account
WHERE open_branch_id = 2;

