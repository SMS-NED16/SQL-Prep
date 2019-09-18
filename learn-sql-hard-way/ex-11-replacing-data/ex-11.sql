/*
	Demonstrating the use of REPLACE and INSERT to do an `atomic` update
	of existing records in the database. 
*/

/* This should fail because the primary key 0 is already taken */
INSERT INTO person (id, first_name, last_name, age) 
	VALUES(0, 'Frank', 'Smith', 100);

/* We can force it by doing an INSERT or REPLACE */
INSERT OR REPLACE INTO person (id, first_name, last_name, age) 
	VALUES(0, 'Frank', 'Smith', 100);

SELECT * FROM person;

/* And shorthand for that is just REPLACE */
REPLACE INTO person (id, first_name, last_name, age) 
	VALUES (0, 'Zed', 'Shaw', 37);

/* Now you can see I'm back */
SELECT * FROM person;