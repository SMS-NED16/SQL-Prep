/* 
	Creating a transaction boundary around all queries in this script.
	This is because the queries may potentially modify the original database.
*/

BEGIN TRANSACTION;

/* Get a simple average for pet ages */
SELECT SUM(age) / COUNT(*) AS average FROM pet;

/* Compare it with the results of the `avg` function */
SELECT avg(age) FROM pet;

/* Get the average name length (anl) of pets */
SELECT avg(length(name)) AS anl FROM pet;

/* Get the average age rounded */
SELECT round(avg(age)) AS average FROM pet;

/* Get a random number */
SELECT random();

/* Use modulus and abs() to make a random value between 0 and 20 */
SELECT abs(random() % 20);

/* Use UPDATE to change all pet ages to random integers 0 - 20*/
UPDATE pet SET age = abs(random() % 20) WHERE dead = 0;

/* Check that it changed (maybe) */
SELECT round(avg(age)) AS average FROM pet;

/* Use 0 - 50 as the range */
UPDATE pet SET age = abs(random() % 50) WHERE dead = 0;

/* Check the average again */
SELECT round(avg(age)) AS average FROM pet;

/* Any changes to the DB made by this script will be rolled back.*/
ROLLBACK TRANSACTION;