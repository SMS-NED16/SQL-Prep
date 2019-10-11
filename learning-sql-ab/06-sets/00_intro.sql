/*
	Before set operations can be performed between two tables
	- both tables must have the same number of columns.
	- corresponding columns in both tables must be compatible: either have the same type or SQL server should be able to convert one column to the type of the other.

	When these conditions are fulfilled
	- overlapping data: same substrings, numbers, dates for rows.  
*/

-- Example 1: Union of a number and string (two records). Each individual query yields a data set containing a single row with a numeric column and stirng. The union operator combines all rows from the two sets. This is COMPOUND QUERY because it queries multiple, otherwise-independent queries.
SELECT 1 num, 'abc' str
UNION
SELECT 2 num, 'xyz' str;