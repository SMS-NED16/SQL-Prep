-- Foreign key constraints prevent the insertion of rows with values for foreign keys
-- that are not found in the parent table.

-- Look at the data in the product_type table
SELECT product_type_cd, name 
FROM product_type;

-- And in the product table
SELECT product_type_cd, product_cd, name 
FROM product 
ORDER BY product_type_cd;

-- Attempt to change the product_type_cd column in product to a value that doesn't
-- exist in the product_type table
-- Cannot change a child row if no corresponding value in the parent
UPDATE product 
SET product_type_cd = 'XYZ'
WHERE product_type_cd = 'LOAN';

-- But what if change the parent row?
UPDATE product_type 
SET product_type_cd = 'XYZ'
WHERE product_type_cd = 'LOAN';

-- Will still get an error. By default, MySQL does not allow us to change rows
-- with foreign key constraints, regardless of whether they're the parent or child table.

-- CASCADING UPDATE: Can instruct the SQL server to propagate the change to all child rows for us
-- First remove the existing foreign key
ALTER TABLE product 
DROP FOREIGN KEY fk_product_type_cd;

-- Now add a new foreign key that allows for cascading updates
ALTER TABLE product 
ADD CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd) 
	REFERENCES product_type (product_type_cd) 
	ON UPDATE CASCADE;

-- Now we can change the product_type_cd in the `product_type` from `LOAN` to `XYZ`
-- And all child rows in the product (i.e. all products of type LOAN) will 
-- have their product_type_cd changed to 'XYZ'
UPDATE product_type
SET product_type_cd = 'XYZ' 
WHERE product_type_cd = 'LOAN';

-- Verify that the change was propagated to the product table
SELECT product_type_cd, name 
FROM product_type;

SELECT product_type_cd, product_cd, name 
FROM product 
ORDER BY product_type_cd;

-- Resetting to LOAN 
UPDATE product_type 
SET product_type_cd = 'LOAN'
WHERE product_type_cd = 'XYZ';

-- Can also specify cascading deletes that removes rows from the child table when the row
-- with the foreign key is deleted from the parent table.
ALTER TABLE product 
ADD CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd)
	REFERENCES product_type (product_type_cd) 
	ON UPDATE CASCADE
	ON DELETE CASCADE;	/*With a new clause*/