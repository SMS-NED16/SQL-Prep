CREATE TABLE person(
	id INTEGER PRIMARY KEY,
	first TEXT,
	last TEXT,
	age INTEGER,
	dob DATETIME
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
	pet_id INTEGER,
	purchased_on DATETIME
);

INSERT INTO person(id, first, last, age, dob) VALUES
	(0, 'Zed', 'Shaw', 37, '01-01-1982'),
	(1, 'Saad', 'Siddiqui', 23, '06-05-1996');

INSERT INTO pet(id, name, breed, age, dead) VALUES
	(0, 'Fluffy', 'Unicorn', 1000, 0),
	(1, 'Gigantor', 'Robot', 1, 1),
	(2, 'Chubby', 'Calico Cat', 5, 1),
	(3, 'Gingi', 'Tabby Cat', 5, 0);

INSERT INTO person_pet(person_id, pet_id, purchased_on) VALUES
	(0, 0, '01-01-2015'),
	(0, 1, '01-01-2016'),
	(1, 2, '01-01-2006'),
	(1, 3, '01-01-2015');