-- Exercise 1. A = {L M N O P}, B = {P Q R S T}
/*
	A union B = {L M N O P Q R S T}
	A union all B = {L M N O P P Q R S T}
	A intersect B = {P}
	A except B = {L M N O}
*/

-- Exercise 2 - Query that finds the first and last names of all individual customers along with the first and last names of all employees.
SELECT 'IND' AS 'category', fname AS first_name, lname AS last_name FROM individual 
UNION 
SELECT 'EMP' AS 'category', fname AS first_name, lname AS last_name FROM employee;

-- Exercise 3 - Sort results from exercise 2 by lname column
SELECT 'IND' AS 'category', fname AS first_name, lname AS last_name
FROM individual
UNION
SELECT 'EMP' AS 'category', fname AS first_name, lname AS last_name
FROM employee
ORDER BY last_name;