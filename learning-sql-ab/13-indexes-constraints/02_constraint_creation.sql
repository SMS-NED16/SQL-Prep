-- Constraints are usually created at the same time as the associated table
-- during the `create table` statement of a schema generation process

/* In this CREATE statement, we're creating the `product` table and also specifying
that the primary key is the `product_cd` column, and that the foreign key is a the 
`product_type_cd` column which will be the same as the `product_type_cd` column in the 
`product_type` table.
*/

CREATE TABLE product 
(
	product_cd VARCHAR(10) NOT NULL, 
	name VARCHAR(50) NOT NULL, 
	product_type_cd VARCAR(10) NOT NULL, 
	date_offered DATE, 
	date_retired DATE,
		CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd),
			REFERENCES product_type (product_type_cd)
		CONSTRAINT pk_product PRIMARY KEY (product_cd)
);

-- Can also create this table without constraints, and alter table to add them later
ALTER TABLE product 
ADD CONSTRAINT pk_product PRIMARY KEY (product_cd);

ALTER TABLE product 
ADD CONSTRAINT fk_product_type_cd FOREGIN KEY (product_type_cd)
	REFERENCES product_type (product_type_cd);

-- Can also remove primary and secondary product keys
ALTER TABLE product 
DROP PRIMARY KEY;	/* Not usually done. Don't need to specify name b/c only one primary key*/

ALTER TABLE product
DROP FOREIGN KEY fk_product_type_cd;	/* Must specify which foreign key to drop*/
