/* Creating a table named `person` with normalization */
CREATE TABLE person
(
	person_id SMALLINT UNSIGNED, 
	fname VARCHAR(20),
	lname VARCHAR(20), 
	gender ENUM('M', 'F'),		/* In MySQL, ENUM is the same as a check constraint */
	birth_date DATE,
	city VARCHAR(20), 
	state VARCHAR(20), 
	country VARCHAR(20), 
	postal_code VARCHAR(20),
	CONSTRAINT pk_person PRIMARY KEY (person_id) /* Primary key constraint */
);

/* To examine schema for this table */ 
DESC person

/* Modifying the person table's schema to autoincrement primary key */
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

/* Check again - autoincrement added to the EXTRA column for person_id */
DESC person;

/* Creating the favourite food table - this will have person_id as a foreign key */
CREATE TABLE favorite_food 
(
	person_id SMALLINT UNSIGNED,
	food VARCHAR(20),

	/* Compound primary key - prevents duplication. Because a fav food must also have a person, this 
	means a primary key must be defined in terms of both the food and the id of the person who likes it */
	CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food), 		
	
	/* Also defining person_id as a foreign key - will be used to do relational lookups 
	Constraint means values in this column are limited to those in the person_id column only */
	CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
		REFERENCES person (person_id)
);

/* Now examine the schema for the favorite_food table */
DESC favorite_food;
