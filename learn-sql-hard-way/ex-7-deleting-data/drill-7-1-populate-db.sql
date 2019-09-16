/* This command drops all the tables that we will recreate. 
 This means we don't need to run rm -rf .db before running the 
 sqlite script */

DROP TABLE person;
DROP TABLE pet;
DROP TABLE person_pet;

/* CREATING TABLES */
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

/* INSERTING VALUES INTO THE DATABASE */
INSERT INTO person (id, first_name, last_name, age) VALUES
	(0, 'Zed', 'Shaw', 37),
	(1, 'Saad', 'Siddiqui', 23);

INSERT INTO pet (id, name, breed, age, dead) VALUES
	(0, 'Fluffy', 'Unicorn', 1000, 0),
	(1, 'Gigantor', 'Robot', 1, 1),
	(2, 'Chubby', 'Calico Cat', 5, 1),
	(3, 'Gingi', 'Tabby Cat', 5, 0);

INSERT INTO person_pet (person_id, pet_id) VALUES 
	(0, 0),
	(0, 1),
	(1, 2),
	(1, 3);

/* DEMONSTRATING THE USE OF DELETE */
/* First, make sure there are dead pets to delete */
SELECT name, age FROM pet WHERE dead = 1;

/* RIP Robot */
DELETE FROM pet WHERE dead = 1;

/* Make sure the robot is gone */
SELECT * FROM pet;

/* Resurrecting the robot */
INSERT INTO pet VALUES (1, 'Gigantor', 'Robot', 1, 0);

/* The robot lives! */
SELECT * FROM pet;