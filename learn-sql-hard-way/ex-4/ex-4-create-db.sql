/*
	Create a database of `person` and `pet` data  tables linked together
	by the referential table `person_pet`. 
*/

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

/*
	Creating relation table
*/
CREATE TABLE person_pet (
	person_id iNTEGER,
	pet_id INTEGER
);
