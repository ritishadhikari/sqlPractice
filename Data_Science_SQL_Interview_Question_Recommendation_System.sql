USE org;
-- 1. Create Table Orders
CREATE TABLE ordersDS
	(
		order_id INT,
        customer_id INT, 
        product_id INT
    );
    
-- 2. Insert values into Orders Tables
INSERT INTO 
	ordersDS(order_id, customer_id, product_id)
VALUES
	(1, 1, 1),
	(1, 1, 2),
	(1, 1, 3),
	(2, 2, 1),
	(2, 2, 2),
	(2, 2, 4),
	(3, 1, 5);
    
SELECT 
	*
FROM 
	ordersDS;

-- 3. Create Products Table
CREATE TABLE productsDS
	(
		id INT, 
        name VARCHAR(10)
    );

-- 4. Insert Values into Products Table

INSERT INTO 
	productsDS (id, name)
VALUES
	(1, 'A'),
	(2, 'B'),
	(3, 'C'),
	(4, 'D'),
	(5, 'E');
    
-- 4. Product Pair Most Commonly Purchased togather.
WITH cte AS
	(
	SELECT 
		a.*,
		b.name
	FROM 
		ordersDS AS a
		JOIN 
		productsDS AS b
	WHERE 
		a.product_id=b.id
	)
    
SELECT 
	-- c.order_id,
-- 	c.name AS ITEM1,
--     d.name AS ITEM2,
    CONCAT(c.name," ",d.name) AS pair,
    COUNT(CONCAT(c.name," ",d.name)) AS TotalCount
FROM 
	cte AS c
	JOIN
    cte AS d
ON 
	c.order_id=d.order_id
AND 
	c.name<d.name
GROUP BY
	pair;
	


    
	
    
