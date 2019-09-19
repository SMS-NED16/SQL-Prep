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
	first_name = 'Zed' AND
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


/* Updating the dobs of the pets */
UPDATE pet SET dob = '01-01-1019' WHERE id = 0;
UPDATE pet SET dob = '01-02-2018' WHERE id = 1;
UPDATE pet SET dob = '01-03-2014' WHERE id = 2;
UPDATE pet SET dob = '01-04-2014' WHERE id = 3;

/* Updating the parent_ids of the pets */
UPDATE pet SET parent = 0 WHERE name = 'Fluffy' AND breed = 'Unicorn';
UPDATE pet SET parent = 0 WHERE name = 'Gigantor' AND breed = 'Robot';
UPDATE pet SET parent = 1 WHERE name = 'Chubby' AND breed = 'Calico Cat';
UPDATE pet SET parent = 0 WHERE name = 'Gingi' AND breed = 'Tabby Cat';
