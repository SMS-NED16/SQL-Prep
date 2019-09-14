/* Creating one table isn't too useful. Using the same SQL file to make three tables in a single SQL database.
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

CREATE TABLE person_pet (
	person_id INTEGER,
	pet_id INTEGER
);
