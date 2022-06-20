/* Calculating the values of the profit field*/

UPDATE `Sales Database`
	SET profit = (sales_price - store_cost);
	
SELECT * FROM `Sales Database`;

-- ------------------------------------------------------------------------------------------------------------------

/*Correcting field datatypes*/

ALTER TABLE `Sales Database`
	MODIFY COLUMN pro_code INT;
	
ALTER TABLE `Sales Database`
	MODIFY COLUMN trans_num INT;
	
/*Receiving truncating error for the above query, so checking the data type as a previous query worked successfully*/

SHOW COLUMNS FROM `Sales Database`;

/*Confirmed that the trans_num column data type has not changed successfully. moving forward to other fields.*/

ALTER TABLE `Sales Database`
	MODIFY COLUMN store_cost DECIMAL(5,2);
	
ALTER TABLE `Sales Database`
	MODIFY COLUMN sales_price DECIMAL(5,2);
	
ALTER TABLE `Sales Database`
	MODIFY COLUMN profit DECIMAL(5,2);
	
ALTER TABLE `Sales Database`
	MODIFY COLUMN trans_num INT;
	
/*Successfully modified trans_num data type after re-uploading source file and updating all fields queried so far. Moving forward with calculations*/
	
-- ------------------------------------------------------------------------------------------------------------------

/* Calculating the values of the commission field and correcting data type*/

UPDATE `Sales Database`
	SET commission = (.10 * profit);
	
ALTER TABLE `Sales Database`
	MODIFY COLUMN commission FLOAT(4,2);
	
-- ------------------------------------------------------------------------------------------------------------------

/*How much revenue and profit was generated this year?*/

SELECT SUM(sales_price) AS annual_revenue
	FROM `Sales Database`;
	
SELECT SUM(store_cost) AS annual_cost
FROM `Sales Database`;

SELECT (SUM(profit) - SUM(commission)) AS annual_profit
	FROM `Sales Database`;
	
/*What are the monthly sales totals and which month generated the most revenue? Order from greatest to least*/

SELECT month,SUM(sales_price) AS monthly_sales
	FROM `Sales Database`
	GROUP BY month
	ORDER BY monthly_sales DESC
;

/*Which sales person generated the most revenue from most to least?*/

SELECT sales_person,SUM(sales_price)
	FROM `Sales Database`
	GROUP BY sales_person
	ORDER BY SUM(sales_price) DESC
;

ALTER TABLE `Sales Database`
	RENAME COLUMN sale_price TO sales_price;
	
/*Calculate the sum of sales by product line to see which product line has the highest sales. Also find how many orders per product were made*/

ALTER TABLE `Sales Database`
	RENAME COLUMN pro_desc to pro_line;

SELECT pro_code,pro_line,sum(sales_price) AS pro_revenue,count(*) AS order_records
	FROM `Sales Database`
	GROUP BY pro_code,pro_line
	ORDER BY pro_revenue DESC
;

/*Now we'll include July since it's our best month revenue wise*/

SELECT month,pro_line,sum(sales_price) AS pro_revenue
	FROM `Sales Database`
	WHERE month = 'July'
	GROUP BY pro_line
	ORDER BY pro_revenue DESC
;

/*Lastly, which market generated the most revenue then provide a breakdown of each state revenue total by product line. Order from most to least*/

SELECT sale_loc,sum(sales_price) AS state_revenue
	FROM `Sales Database`
	GROUP BY sale_loc
	ORDER BY state_revenue DESC
;

SELECT sale_loc,pro_line,sum(sales_price) AS state_rev_breakdown
	FROM `Sales Database`
	GROUP BY sale_loc,pro_line
	ORDER BY sale_loc,state_rev_breakdown DESC
;

SELECT * FROM `Sales Database`;

SELECT month,pro_code,pro_line,store_cost,sales_price,profit,commission,sales_person,sale_loc
	FROM `Sales Database`;
