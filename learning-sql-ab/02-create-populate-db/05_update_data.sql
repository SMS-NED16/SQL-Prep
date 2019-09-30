/* Updating William Turner's Address */
UPDATE person
SET street = '1225 Tremont St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02318'
WHERE person_id = 1;

/* Can use WHERE clauses to get data for more than one row */
SELECT person_id, fname, lname 
FROM person
WHERE person_id < 10;