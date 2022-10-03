USE tech;

DELETE 
	FROM 
products;

SELECT 
	*
FROM 
	products;
    
INSERT INTO products
	(product_code, product_name, price, quantity_remaining, quantity_sold)
    VALUES
		('P1','iPhone 13 Pro Max', 1200, 5, 195),
		('P2','AirPods Pro', 279, 10, 90),
        ('P3','MacBook Pro 16', 5000, 2, 48),
        ('P4','iPad Air', 650, 1, 9);
        
DELETE 
	FROM 
sales;

INSERT INTO sales
	(order_id, order_date, product_code, quantity_ordered, sale_price)
    VALUES
    (1,"2022-01-10","P1",100,120000),
    (2,"2022-01-20","P1",50,60000),
    (3,"2022-02-05","P1",45,540000),
    (4,"2022-01-15","P2",50,13950),
    (5,"2022-05-23","P2",40,11160),
    (6,"2022-02-25","P3",10,50000),
    (7,"2022-03-15","P3",10,50000),
    (8,"2022-03-25","P3",20,100000),
    (9,"2022-04-21","P3",3,40000),
    (10,"2022-04-27","P4",9,5850);

/*
Challenge: For every given product and the quantity,
	1) Check if product is available based on the required quantity
    2) If Available then modify the database tables accordingly
*/

-- Create Procedure
DELIMITER $$
DROP PROCEDURE IF EXISTS pr_buy_products ;

CREATE PROCEDURE
	pr_buy_products(
        IN p_product_name VARCHAR(30), -- by default it is an input parameter
		IN p_quantity INT
		)
	BEGIN 
		DECLARE v_product_code VARCHAR(20);
		DECLARE	v_price FLOAT;
        DECLARE v_cnt INT;
		
        SELECT 
			COUNT(1)
		INTO 
			v_cnt
		FROM
			products
		WHERE 
			product_name=p_product_name
			AND
            quantity_remaining>=p_quantity
        
        IF v_cnt>0 THEN
        
			SELECT 
				product_code,
				price
			INTO 
				v_product_code,
				v_price
			FROM
				products
			WHERE
				product_name=p_product_name;
			
			INSERT INTO sales
				(order_id,order_date, product_code, quantity_ordered, sale_price)
				VALUES
					(RAND(3), CURRENT_DATE, v_product_code, p_quantity, (v_price*p_quantity) );
			
			UPDATE 
				products
			SET
				quantity_remaining=(quantity_remaining-p_quantity),
				quantity_sold=(quantity_sold+p_quantity)
			WHERE
				product_name=p_product_name";
				
			SELECT "Product Sold!";
		ELSE 
			SELECT "Insufficient Quantity"
        END IF;
END $$