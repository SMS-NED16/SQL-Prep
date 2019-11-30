/*
Use case 1: Generating a single schema for different tables and views that different
members of the team have worked on.

In this case, we're writing a script that will create the bank.customer table.
*/
-- The original command used to create this table
CREATE TABLE customer 
(
	cust_id INTEGER UNSIGNED NOT NULL auto_increment, 
	fed_id VARCHAR(12) NOT NULL, 
	cust_type_cd ENUM('I', 'B') NOT NULL, 
	address VARCHAR(30), 
	city VARCHAR(20),
	state VARCHAR(20),
	postal_code VARCHAR(10), 
	CONSTRAINT pk_customer PRIMARY KEY (cust_id)
);

-- This command can also be generated programmatically by querying information_schema
-- of a database that contains the different tables the team has worked on.

-- I don't like this
SELECT 'CREATE TABLE customer(' create_table_statement
UNION ALL
SELECT cols.txt  /*File containing names of columns to include*/
FROM 
(
	SELECT CONCAT(' ', column_name, ' ', column_type, 
		CASE
			WHEN is_nullable = 'NO' THEN ' not null'
			ELSE ''
		END, 

		CASE
			WHEN extra IS NOT NULL THEN concat(' ', extra) 
			ELSE ''
		END, 
		',') txt
	FROM information_schema.columns 
	WHERE table_schema = 'bank' AND table_name = 'customer'
	ORDER BY ordinal_position
) cols 
UNION ALL 
SELECT ')';