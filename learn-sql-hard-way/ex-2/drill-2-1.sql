/*
	Attempting to get rid of the separate relation for linking 
	pets with persons and adding the pet id directly to the person schema.
*/

CREATE TABLE person (
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER,
	
	/*This is key for the pet*/
	pet_id INTEGER
);


/*	Will still create a table with pets*/
CREATE TABLE pets (
	id INTEGER PRIMARY KEY,
	name TEXT,
	breed TEXT,
	age INTEGER,
	dead INTEGER
);

/*
	The implication of this change is that we don't need to maintain separate 
	relation table for the pets and persons. However, this also creates a problem
	in that if a person does not have pet, we will have to use a dummy value 
	such as -1 for its pet_id attribute.
*/
