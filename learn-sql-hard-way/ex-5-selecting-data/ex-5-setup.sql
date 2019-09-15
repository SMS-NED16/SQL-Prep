/*
	Creating a database with the person and pets 
*/
CREATE TABLE person(
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER
);

CREATE TABLE pet(
	id INTEGER PRIMARY KEY,
	name TEXT,
	breed TEXT,
	age INTEGER,
	dead INTEGER
);

CREATE TABLE person_pet(
	person_id INTEGER,
	pet_id INTEGER
);

/*
	Populating the database with data records
*/
INSERT INTO person (id, first_name, last_name, age)
	VALUES(0, 'Zed', 'Shaw', 37);
	VALUES(1, 'Saad', 'Siddiqui', 23);

INSERT INTO pet (id, name, breed, age, dead)
	VALUES(0, 'Fluffy', 'Unicorn', 1000, 0);
	VALUES(1, 'Gigantor', 'Robot', 1, 1);
	VALUES(2, 'Chubby', 'Calico Cat', 5, 0);
	VALUES(3, 'Gingi', 'Chonky Tabby', 5, 0);
