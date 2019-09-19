/* Add a `dead` column to `person` */
ALTER TABLE person ADD COLUMN dead INTEGER;

/* Add a `salary` column to `person` */
ALTER TABLE person ADD COLUMN salary REAL;

/* Add a dob column to both `person` and `pet` */
ALTER TABLE person ADD COLUMN dob DATETIME;
ALTER TABLE pet ADD COLUMN dob DATETIME;

/* Add a column `purchased_on` to person_pet */
ALTER TABLE person_pet ADD COLUMN purchased_on DATETIME;

/* Add a `parent` column to `pet` - Integer, holds id for this pet's parent */
ALTER TABLE pet ADD COLUMN parent INTEGER;

/* Use UPDATE statements to update the data for newly added columns */
/* Dead, salary, and dob for `person`*/
UPDATE person SET dead = 0; 			/* None of the entries are deceased */
UPDATE person SET salary = 370000 WHERE 
	first_name = 'Zed' AND;
	last_name = 'Shaw';

UPDATE person SET salary = 0 WHERE
	first_name = 'Saad' AND
	last_name = 'Siddiqui';

UPDATE person SET dob = '31-01-1982' WHERE
	first_name = 'Zed' AND
	last_name = 'Shaw';

UPDATE person SET dob = '06-05-1996' WHERE
	first_name = 'Saad' AND
	last_name = 'Siddiqui';

	