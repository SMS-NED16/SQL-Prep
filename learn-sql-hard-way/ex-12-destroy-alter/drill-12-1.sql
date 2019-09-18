/* Generates a fresh database of person, pet, and person_pet tables*/

/*
 Drop any existing tables in the database - start from scratch.
 Modification here is the IF EXISTS clauses - they make sure the
 SQL script does not attempt to delete a table that isn't present
 in the database. 
*/
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS pet;
DROP TABLE IF EXISTS person_pet;

/* Creating table schema */
CREATE TABLE person (
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER
);

CREATE TABLE pet (
	id INTEGER PRIMARY KEY,
	name TEXT,
	breed TEXT,
	age INTEGER,
	dead INTEGER
);

CREATE TABLE person_pet (
	person_id INTEGER,
	pet_id INTEGER
);

/* Populate database with entries/records */
INSERT INTO person (id, first_name, last_name, age) VALUES
	(0, 'Zed', 'Shaw', 37),
	(1, 'Saad', 'Siddiqui', 23);

INSERT INTO pet (id, name, breed, age, dead) VALUES
	(0, 'Fluffy', 'Unicorn', 1000, 0),
	(1, 'Gigantor', 'Robot', 1, 1),
	(2, 'Chubby', 'Calico Cat', 5, 1),
	(3, 'Gingi', 'Tabby Cat', 5, 1);

INSERT INTO person_pet (person_id, pet_id) VALUES
	(0, 0), (0, 1),
	(1, 2), (1, 3);

/* Echoing data to confirm proper insertion */
SELECT * FROM person;

SELECT * FROM pet;

SELECT * FROM person_pet;