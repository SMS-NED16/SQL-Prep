/*
	Simple UPDATE query to change 'Hilarious Guy' back to 'Zed' in the `person` table.
*/

/*	Before the update */
SELECT * FROM person;

/* Make the UPDATE */ 
UPDATE person SET first_name = 'Zed'
	WHERE first_name = 'Hilarious Guy';

/* After the update */
SELECT * FROM person;
