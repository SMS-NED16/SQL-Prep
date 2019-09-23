/* 
	Drop all existing entries in the dataset. Shouldn't do this 
	because the whole point of the COMMIT/ROLLBACK/COMMIT commands
	is to avoid trashing the database in case of errors. But I'm doing 
	it for simplicity's sake.
*/
DROP TABLE person;


/* Creating a test database */
CREATE table person(
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER
);

INSERT INTO person (id, first_name, last_name, age) VALUES
	(0, 'Saad', 'Siddiqui', 23),
	(1, 'Faiq', 'Siddiqui', 21),
	(2, 'Waleed', 'Hasan', 21),
	(3, 'Haseeb', 'Qadri', 20),
	(4, 'Rehman', 'Gul', 21);

/* Before any changes were made to the database */
SELECT * FROM person;

/* Experimenting with BEGIN/COMMIT/ROLLBACK TRANSACTION */
/* Successful transaction that will be committed */
BEGIN TRANSACTION;
UPDATE person SET first_name = 'Syed Abdul Haseeb' WHERE id = 3;
COMMIT TRANSACTION;

/* Echo the results of the `person` table to confirm */
SELECT * FROM person;

/* Unsuccessful transaction that will be rolled back */
BEGIN TRANSACTION ;

/* Will fail - `person` does not contain a `dob` column */
UPDATE person SET dob = '03-03-1999' WHERE id = 3;
ROLLBACK TRANSACTION;

/* Echo the contents of the `person` table to make sure */
SELECT * FROM person;