
/*
DELIMITER $$
CREATE OR REPLACE PROCEDURE
	pr_name
		(
			p_name VARCHAR,
            p_age INT
        )
	AS
	DECLARE
		variable data type;
	BEGIN
		PROCEDURE body - all logics
	END $$
    
*/
USE tech;

-- Procedure Without Parameters
CREATE TABLE 
	products 
	(
		product_code VARCHAR(30),
        product_name VARCHAR(30),
        price FLOAT(10),
        quantity_remaining INTEGER,
        quantity_sold INTEGER
    );
    
INSERT INTO products
	(product_code, product_name, price, quantity_remaining, quantity_sold)
    VALUES
		('P1','iPhone 13 Pro Max', 1000, 5, 195);
        
SELECT 
	*
FROM 
	products;
    
CREATE TABLE 
	sales
	(
		order_id INTEGER,
        order_date DATE,
        product_code VARCHAR(30),
        quantity_ordered INTEGER,
        sale_price FLOAT(10)
    );

DROP TABLE sales;
INSERT INTO sales
	(order_id, order_date, product_code, quantity_ordered, sale_price)
    VALUES
    (1,"2022-01-10","P1",100,120000),
    (2,"2022-01-20","P1",50,60000),
    (3,"2022-02-05","P1",45,54000);
    
SELECT 
	*
FROM 
	sales;

/*
 Challenge: For every iPhone 13 Pro Max Sale, modify the database
 tables accordingly
*/
-- Create Procedure
DELIMITER $$
DROP PROCEDURE IF EXISTS pr_buy_products;

CREATE PROCEDURE
	pr_buy_products()
	BEGIN 
		DECLARE v_product_code VARCHAR(20);
		DECLARE	v_price FLOAT;
        
		SELECT 
			product_code,
            price
		INTO 
			v_product_code,
            v_price
		FROM
			products
		WHERE
			product_name="iPhone 13 Pro Max";
		
        INSERT INTO sales
			(order_id,order_date, product_code, quantity_ordered, sale_price)
            VALUES
				(RAND(), CURRENT_DATE, v_product_code, 1, (v_price*1) );
		
        UPDATE 
			products
		SET
			quantity_remaining=(quantity_remaining-1),
            quantity_sold=(quantity_sold+1)
		WHERE
			product_name="iPhone 13 Pro Max";
            
		SELECT "Product Sold!";
END $$
