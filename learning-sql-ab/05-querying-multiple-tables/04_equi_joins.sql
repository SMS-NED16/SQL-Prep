-- Equijoins: the ON clause is always an equality comparator. Ranges of values => nonequi-joins. In this case, we are trying to find employees who started working at the bank during the time that the 'no-fee checking' product was being offered. 
SELECT e.emp_id, e.fname, e.lname, e.start_date
FROM employee AS e INNER JOIN product AS p
	ON e.start_date >= p.date_offered
	AND e.start_date <= p.date_retired
WHERE p.name = 'no-fee checking';

-- Self non-equi-join: Pairing employees for chess tournaments. Can't pair an employee against itself. However, this will generate redundant reverse pairings
SELECT e1.fname, e1.lname, 'VS' AS 'vs', e2.fname, e2.lname 
FROM employee AS e1 INNER JOIN employee AS e2
	ON e1.emp_id != e2.emp_id 
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

-- One solution: pair employees with those with IDs higher than them
SELECT e1.fname, e1.lname, 'VS' AS vs, e2.fname, e2.lname
FROM employee AS e1 INNER JOIN employee AS e2
	ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';