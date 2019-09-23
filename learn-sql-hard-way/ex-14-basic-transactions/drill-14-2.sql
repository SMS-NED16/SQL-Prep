/* Experimenting with UPDATES and INSERTS */

/* Before any changes in the database */
SELECT * FROM person;

/* UPDATE */
BEGIN TRANSACTION;
UPDATE person SET first_name = 'M. Waleed' WHERE first_name = 'Waleed';
COMMIT TRANSACTION;
SELECT * FROM person;


BEGIN TRANSACTION;
UPDATE person SET dob = '06-06-1996' WHERE id = 0;
ROLLBACK TRANSACTION;
SELECT * FROM person;

/* INSERT */
BEGIN TRANSACTION;
INSERT INTO person(id, first_name, last_name, age) VALUES
	(5, 'Malik', 'Zain', 21);
COMMIT TRANSACTION;
SELECT * FROM person;

BEGIN TRANSACTION;
/* This will fail because of a primary key conflict */
INSERT INTO person(id, first_name, last_name, age) VALUES 
	(5, 'Rameez', 'Khan', 21);
ROLLBACK TRANSACTION;
SELECT * FROM person;