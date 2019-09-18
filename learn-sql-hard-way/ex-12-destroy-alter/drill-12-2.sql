/*
	Adds a `height` and `weight` column to the schema for the `person` table
*/

/* Echoing schema of person table before addition of columns */
.schema person

ALTER TABLE person ADD COLUMN 
	weight REAL
	height REAL; 

/* Echoing schema of person table after addition of columns */
.schema person 