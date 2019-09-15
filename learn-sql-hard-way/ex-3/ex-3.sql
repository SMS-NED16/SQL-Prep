/*
	Inserting rows or records of data into data tables.
	Assumes the person and pet databases have already been created
 	by the INSERT INTO command.

	Demonstrates two different syntax for inserting values into a database.
*/

INSERT INTO person(id, first_name, last_name, age)
	VALUES(0, 'Zed', 'Shaw', 37);

INSERT INTO pet(id, name, breed, age, dead) 
	VALUES(0, 'Fluffy', 'Unicorn', 1000, 0);

/*	Shorthand syntax - dangerous because we are not specifying the
	columns we want to update, and is dependent on the implicit
	ordering in the table. 

	If we did not know the column order of the table the statement
	was actually accessing - this could lead to the wrong data
	being inserted.
*/
INSERT INTO pet VALUES(1, 'Gigantor', 'Robot', 1, 1);
