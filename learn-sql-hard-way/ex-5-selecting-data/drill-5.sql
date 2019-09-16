/* A query that finds all pets older than 10 years */
SELECT * FROM pet WHERE age > 10;

/* A query that finds all people older than me */
SELECT * FROM person WHERE age > 
(SELECT age FROM person WHERE first_name == 'Saad');

/* A query that finds all people younger than me */
SELECT * FROM person WHERE age < 
(SELECT age FROM person WHERE first_name == 'Saad');

/* A query that uses more than one test in the WHERE clause */
SELECT * FROM pet WHERE age > 3 AND dead == 0;

/* A query that uses 3 columns and uses both AND and OR operators */
SELECT * FROM person WHERE (first_name == 'Saad' OR last_name == 'Siddiqui') AND age == 23;