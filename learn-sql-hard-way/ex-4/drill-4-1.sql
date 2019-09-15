/*
	First add myself and my pets to the appropriate tables in the database
*/
INSERT INTO person (id, first_name, last_name, age)
	VALUES(1, 'Saad', 'Siddiqui', 23);

INSERT INTO pet (id, name, breed, age, dead)
	VALUES(2, 'Chubby', 'Calico Cat', 5, 0);

INSERT INTO pet (id, name, breed, age, dead)
	VALUES(3, 'Gingi', 'Tabby Cat', 5, 0);


/*
	Then attempt to add the relational data to the relational table
*/
INSERT INTO person_pet (person_id, pet_id) VALUES(1, 2);
INSERT INTO person_pet (person_id, pet_id) VALUES(1, 3);
