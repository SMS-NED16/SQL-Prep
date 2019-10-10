/*
	NULL is used for three different cases of the absence of a value.
	- Not applicable: the specific column or field does not need to be filled for the record
	- Value not yet known: The value for the column isn't known for this record.
	- Value undefined: E.g. an account created for a product that has not yet been added to the db.

	An expression can **be** NULL, but can **never equal** NULL.
	Two NULLs are never equal to each other (which makes sense, since each of them may be a different case of the absence of a value).
*/
-- Use IS NULL to test whether a value is null. Don't use =
SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NULL;

-- +--------+---------+-------+-----------------+
-- | emp_id | fname   | lname | superior_emp_id |
-- +--------+---------+-------+-----------------+
-- |      1 | Michael | Smith |            NULL |
-- +--------+---------+-------+-----------------+

-- The same query would not return a result set if we used =
SELECT emp_id, fname, lname, superior_emp_id 
FROM employee
WHERE superior_emp_id = NULL;

-- NOT NULL can be used to check if a value has been assigned a column
SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL;

-- Pitfall: Identifying all employees who are not managed by Helen Fleming
SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id != 6;	
/* This will not include employees whose superior_emp_id is NULL*/

-- To account for the possibility that some rows will habe NULL superior_emp_ids
SELECT emp_id, fname, lname, superior_emp_id 
FROM employee
WHERE superior_emp_id != 6 OR superior_emp_id IS NULL;

-- This is why it is a good idea to find columns that allow NULLs before querying them.