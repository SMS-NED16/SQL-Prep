/*
	Selecting data from the database with a SELECT query
*/


/*	Selecting all columns for all rows in the table `person`*/
SELECT * FROM person;

/*	Selecting only `name` and `age` columns from all rows in `pet` */
SELECT name, age FROM pet;

/*	WHERE clause - filtering based on data in a specific column
	In this case, get `name` and `age` only from those rows where
	the `dead` column's value is 0.
*/
SELECT name, age FROM pet WHERE dead = 0;

/*
	WHERE clause - this time selecting based on rows that do not
	contain a specific value for a specific field
*/
SELECT * FROM person WHERE first_name != 'Zed';
