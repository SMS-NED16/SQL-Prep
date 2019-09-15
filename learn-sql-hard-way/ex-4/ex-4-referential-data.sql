/*
	Inserting referential data into the databases' person_pet table.
	Will add a set of integer representing primary keys in the 
	`person` and `pet` tables respectively. These will act as 
	foreign keys for the database.
*/


/*Person 0 - Zed Shaw - has a pet 0 - Fluffy the Unicorn.*/
INSERT INTO person_pet (person_id, pet_id) VALUES(0, 0);

/*Person 1 - Zed Shaw - has a pet 1 - Gigantor the Robot*/
INSERT INTO person_pet (person_id, pet_id) VALUES(0, 1);
