/*
Metadata is data about data - the data that the SQL engine stores about a specific database.

This includes tables names, column names, primary keys, constraints, indexes, foreign keys, 
which columns in a table can and cannot be NULL, the maximum and minimum space required for different
schema, etc. 

In MySQL, metadata is stored as a special schema or database called `information_schema` which consists
exclusively of views of different data about different tables/dbs.
*/

-- How to retrieve the names of all the tables in the bank database
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_schema = 'bank'
ORDER BY 1;

-- Since views are also tables, they will be included. To exclude them use WHERE
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_schema = 'bank' AND table_type = 'BASE TABLE'
ORDER BY 1;

-- Can also get information about views, such as its name and whether or not its updatable
SELECT table_name, is_updatable 
FROM information_schema.views 
WHERE table_schema = 'bank' 
ORDER BY 1;

-- Can also retrieve the underlying query used to define the view 
SELECT table_name AS view_name, is_updatable, view_definition AS underlying_query 
FROM information_schema.views 
WHERE table_schema = 'bank'
ORDER BY 1;

-- Column information for both tables and views is also stored in information_schema
SELECT column_name, data_type, character_maximum_length as char_max_len, 
	numeric_precision AS num_prcsn, numeric_scale AS num_scale 
FROM information_schema.columns 
WHERE table_schema = 'bank' AND table_name = 'account'
ORDER BY ordinal_position; /* Retrieve in order that columns were added to the table */

-- Index information is stoed in information_schema.statistics
SELECT index_name, non_unique, seq_in_index, column_name 
FROM information_schema.statistics 
WHERE table_schema = 'bank' AND table_name = 'account' 
ORDER BY 1, 3;

-- Constraints are stored in the information_schema.table_constraints view 
SELECT constraint_name, table_name, constraint_type 
FROM information_schema.table_constraints 
ORDER BY 3, 1;