/*
	Inserting myself and my (imaginary) pets into the database of 
	persons and pets.
*/
INSERT INTO person (id, first_name, last_name, age) 
	VALUES(1, 'Saad', 'Siddiqui', 23);

INSERT INTO pet (id, name, breed, age, dead)
	VALUES(2, 'Chubby', 'Calico Cat', 5, 0);

INSERT INTO pet (id, name, breed, age, dead)
	VALUES(3, 'Gingi', 'Tabby Cat', 3, 0); 
