-- The following query executes quickly because there are few rows in the table
SELECT dept_id, name
FROM department
WHERE name LIKE 'A%';

/*
How does this work? DB Engine does not store data in tables in any particular order. It just
remembers the location(s) of free space(s) assigned to the table, and then inserts a new piece
record there. This means that if a specific row has to be found, the DB engine needs to parse ALL 
rows in the table.

Concretely, searching a table has O(n) complexity, which can get very slow if there are lots 
of rows in the table.

Indexes are tables that are
- maintained in a specific order, so lookup is not O(n)
- do not maintain ALL the data about a table
- only retain the data that is necessary to find a specific entry e.g. a key
- are used to locate rows in a table: they are a mechanism for finding a specific item
within a resource without the need to inspect every row in the table.
*/


-- Adding an index to the `dept_name` column in the the department table
ALTER TABLE department 
ADD INDEX dept_name_idx (name); /*`(name)` is the column that is to be used as an index*/

-- Look at availale indexes for a table
SHOW INDEX FROM department \G; /*\G argument makes a neatly formatted page of info*/
SHOW INDEX FROM department;		/*Less easy to read: multiple columns*/

-- Shows that the INDEX table for the department table has only two pieces of information
-- The first the primary key of the table, and the second is the dept_name_idx we created

-- Recall that the primary key was created as a CONSTRAINT when we first made the table
CREATE TABLE department
(dept_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 
name VARCHAR(20) NOT NULL, 
CONSTRANT pk_department PRIMARY KEY (dept_id) );

-- Can also remove indexes from a table
ALTER TABLE department
DROP INDEX dept_name_idx;

-- Will no longer have the dept_name_idx index 
SHOW INDEX FROM department \G;

/*
Creating a unique index means
- DB engine can perform efficient, non-sequential search for a row using this index. 
- DB engine also prevents duplicate values from being inserted into this column

How is this different from a primary key?
*/
ALTER TABLE department
ADD UNIQUE dept_name_idx (name);

-- Can still perform lookup using the column
SELECT dept_id, name
FROM department 
WHERE name LIKE 'A%';

-- But now won't be able to insert a duplicate department record
INSERT INTO department (dept_id, name) 
VALUES (999, 'Operations');		/* Operations already exists in the `name` column*/

-- Multicolumn Indexes: search employees using first and last names
ALTER TABLE employee 
ADD INDEX emp_names_idx (lname, fname); 

/*
Order of columns in multicolumn indexes is important: searching for a first name after
knowing a last name is efficient (think phone directory) but doing the reverse is not. 
*/