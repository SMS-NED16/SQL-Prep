/* Only drop a table in the database if it exists */
DROP TABLE IF EXISTS person;

/* Create again to work with it */
CREATE TABLE person (
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER
);

/* Rename the table to peoples */
ALTER TABLE person RENAME TO peoples;

/* Add a hatred column to peoples */
ALTER TABLE peoples ADD COLUMN hatred INTEGER;

/* Rename peoples back to person */
ALTER TABLE peoples RENAME TO person;

/* Check that the table's schema is changed - now has hatred column */
.schema person

/* We don't need the person table. Delete it. */
DROP TABLE person;