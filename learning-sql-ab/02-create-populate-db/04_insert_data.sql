/* Inserting data into the person table */
INSERT INTO person (person_id, fname, lname, gender, birth_date) 
	VALUES(null, 'William', 'Turner', 'M', '1972-05-27');

/* Examine the data just added to the database */
SELECT person_id, fname lname, birth_date
FROM person;

/* Because we reconfigured the person table to autoincrement its primary key
value, person_id for the newly inserted record will be 1*/

/* Using a WHERE clause to find a specific record */
SELECT person_id, fname, lname, birth_date
FROM person
WHERE person_id = 1;

/* Can actually use any column to search for a specific row */
SELECT person_id, fname, lname, birth_date
FROM person
WHERE lname = 'Turner';

/* Inserting William Turner's data into the favorite food table */
INSERT INTO favorite_food (person_id, food) 
	VALUES(1, 'pizza');

INSERT INTO favorite_food (person_id, food) 
	VALUES(1, 'cookies');

INSERT INTO favorite_food (person_id, food)
	VALUES(1, 'nachos');

/* Examining newly inserted entries in the favorite_food table. Ordered alphabetically */
SELECT food
FROM favorite_food
WHERE person_id = 1
ORDER BY food;

/* Inserting another person into the table */
INSERT INTO person
	(person_id, fname, lname, gender, birth_date, 
	street, city, state, country, postal_code)
VALUES (null, 'Susan', 'Smith', 'F', '1975-11-02', 
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');