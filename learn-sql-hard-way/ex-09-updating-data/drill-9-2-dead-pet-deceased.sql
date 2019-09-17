/*
	A query that changes the name of all dead pets to DECEASED.
*/

/* Before DECEASED update */
SELECT * FROM pet;

UPDATE pet SET name = 'DECEASED'
	WHERE dead = 1;

/* Afrer DECEEASED update */
SELECT * FROM pet;

/* 
	What happens if I try to use DEAD instead - without any quotes?
	SQL will think I am trying to refer to the column named `DEAD` 
	and will substitute the value name to the value of the `DEAD`
	column in that row
*/