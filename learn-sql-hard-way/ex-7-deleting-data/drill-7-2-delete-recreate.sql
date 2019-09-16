/*
	Practice script to create and populate a DB 
	Then deletes dead pets before re-inserting them
*/
/* Dropping all newly created tables */
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
	(2, 'Chubby', 'Calico', 5, 1);

INSERT INTO person_pet(person_id, pet_id) VALUES
	(0, 0),
	(0, 1),
	(1, 2);

/* DISPLAYING ALL DATA */
SELECT * FROM person;
SELECT * FROM pet;
SELECT * FROM person_pet;


/* CONFIRMING THAT THERE ARE PETS TO DELETE */
SELECT * FROM pet WHERE dead = 1;

/* REMOVING ALL DEAD PETS */
DELETE FROM pet where dead = 1;

/* ECHOING TO ENSURE PETS DELETED */
SELECT * FROM pet;

/* INSERTING DELETED PETS */
INSERT INTO pet (id, name, breed, age, dead) VALUES 
	(1, 'Gigantor', 'Robot', 1, 0),
	(2, 'Chubby', 'Calico Cat', 5, 0);

/* ECHOING INSERTION */
SELECT * FROM pet;