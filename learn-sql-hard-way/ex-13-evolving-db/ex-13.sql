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

