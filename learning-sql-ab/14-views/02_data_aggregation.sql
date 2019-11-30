/*
Another use case for views is data aggregation: combining or grouping rows 
of a database according to some aggregate function. 

Instead of letting users perform aggregation against base tables, make views 
for common aggregations. 
*/
CREATE VIEW customer_totals_vw
(
	cust_id, 
	cust_type_cd,
	cust_name,
	num_accounts,
	tot_deposits
)
AS
SELECT cst.cust_id, cst.cust_type_cd,
	CASE 
		WHEN cst.cust_type_cd = 'B' 
		THEN 
		(
			SELECT bus.name 
			FROM business AS bus 
			WHERE bus.cust_id = cst.cust_id
		)
		ELSE
		(
			SELECT CONCAT(ind.fname, ' ', ind.lname) 
			FROM individual AS ind
			WHERE ind.cust_id = cst.cust_id
		)
	END AS cust_name, 
	SUM(CASE WHEN act.status = 'ACTIVE' THEN 1 ELSE 0 END) AS tot_active_accounts,
	SUM(CASE WHEN act.status = 'ACTIVE' THEN act.avail_balance ELSE 0 END) as tot_balance
FROM customer AS cst INNER JOIN account AS act
	ON act.cust_id = cst.cust_id 
GROUP BY cst.cust_id, cst.cust_type_cd;

-- Can now query this view for total accounts opened by each user as well as available balance
SELECT cust_type_cd AS customer_type, 
	SUM(num_accounts) AS total_accounts,
	SUM(tot_deposits) AS total_deposits
FROM customer_totals_vw
GROUP BY customer_type;

-- At a later point, we may want to create a table of aggregated customer data using this view
CREATE TABLE customer_totals 
AS 
SELECT * FROM customer_totals_vw;