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

/* Updating purchase date of pets */
UPDATE person_pet SET purchased_on = '01-01-2019' WHERE pet_id = 0;
UPDATE person_pet SET purchased_on = '01-02-2019' WHERE pet_id = 1;
UPDATE person_pet SET purchased_on = '01-03-2015' WHERE pet_id = 2;
UPDATE person_pet SET purchased_on = '02-03-2015' WHERE pet_id = 3;

/* Adding 4 more people */
INSERT INTO person (id, first_name, last_name, age, dead, salary, dob) VALUES
	(2, 'Hasan', 'Rehman', 21, 0, 0, '28-07-1998'),
	(3, 'Rehman', 'Gul', 21, 0, 0, '21-07-1998'),
	(4, 'Faiq', 'Sidddiqui', 21, 0, 0, '08-07-1998'),
	(5, 'Fawad', 'Masood', 23, 0, 90000, '03-04-1996');


/* Adding 5 more pets */
INSERT INTO pet (id, name, breed, age, dead, dob, parent) VALUES
	(4, 'Memus', 'Calico Cat', 10, 1, '01-01-2001', 1), 
	(5, 'Maru', 'Scottish Fold', 9, 0, '05-05-2010', 0), 
	(6, 'Hannah', 'Tomcat', 5, 0, '10-10-2014', 0), 
	(7, 'Drogon', 'Dragon', 10, 0, '01-01-2009', 0),
	(8, 'Viserion', 'Dragon', 10, 1, '01-01-2009', 0);

/* Query to find names of all pets and their owners for any pets bought after 2014 */


/* Query that can find the pets that are children of a given pet */