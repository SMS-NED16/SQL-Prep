/* Nonunique Primary Keys
   If a primary key has already been assigned to a row in the table,
   any query that attempts to INSERT or UPDATE a row to assign the
   same key to another row will cause an error.

   This ensures that the PRIMARY KEY is always unique, and can be used
   to uniquely identify its associated record in the database.
*/
INSERT INTO person (person_id, fname, lname, gender, birth_date)
	VALUES(1, 'Charles', 'Fulton', 'M', '1968-01-15');

-- ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'

/*	Nonexistent Foreign Key
	What happens when we try to insert a record into a table with
	a foreign key that doesn't exist in the specified second table?	
*/
INSERT INTO favorite_food (person_id, food)
	VALUES(999, 'lasagna');

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint 
-- fails (`lrngsql_02`.`favorite_food`, CONSTRAINT `fk_fav_food_person_id` 
-- FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`))

/*
Before we can enter the person id 999 into the fav_food table, we must 
create a person with this id in the person table. This means the fav_food
table is the child table i.e. it is dependent on the parent table for some
of its data.
/*

/* 
	Column Value Violations
	Have configured the gender column to have only M/F as acceptable values.
	What happens when we try to violate this constraint?
*/
UPDATE person SET gender = 'Z' WHERE person_id = 1;
-- ERROR 1265 (01000): Data truncated for column 'gender' at row 1


/*
	INVALID DATE CONVERSIONS
	If the format in which the date is specified is not the same as the
	DATE type used when creating the schema, we get an error
*/
UPDATE person
SET birth_date = 'DEC-21-1980'
WHERE person_id = 1;

/* Workaround is to always use the str_to_date function and explicitly define the format */
UPDATE person
SET birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE person_id = 1;