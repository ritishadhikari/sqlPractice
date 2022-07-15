USE org;

-- 1. Create Table products1
CREATE TABLE products1
	(
		id INT,
        name VARCHAR(10)
    );

-- 2. Insert Data into Products
INSERT INTO products1
	(id,name)
    VALUES
    (1, 'A'),
	(2, 'B'),
	(3, 'C'),
	(4, 'D'),
	(5, 'E');
    
-- 3. Create Table colors
CREATE TABLE colors
	(
		color_id INT,
        color VARCHAR(50)
    );

-- 4. Insert Data into colors
INSERT INTO colors
	(color_id, color)
    VALUES
	(1,'Blue'),
    (2,'Green'),
    (3,'Orange');
    
-- 5. Create Table Sizes
CREATE TABLE sizes
	(
		size_id INT,
        size VARCHAR(10)
    );
    
-- 6. Insert Data into Sizes
INSERT INTO sizes
	(size_id,size)
	VALUES
    (1,'M'),
    (2,'L'),
    (3,'XL');
    
-- 7. Create Table Transactions
CREATE TABLE transactions
	(
		order_id INT,
        product_name VARCHAR(20),
        color VARCHAR(10),
        size VARCHAR(10),
        amount INT
    );
    
-- 8. Insert Data into Transactions Table
INSERT INTO transactions
	(order_id,product_name,color,size,amount)
    VALUES
	(1,'A','Blue','L',300),
    (2,'B','Blue','XL',150),
    (3,'B','Green','L',250),
    (4,'C','Blue','L',250),
	(5,'E','Green','L',270),
    (6,'D','Orange','L',200),
    (7,'D','Green','M',250);
    
-- Notes: In Cross Join we don't give any join condition

SELECT 
	P.*,
    C.*
FROM 
	products1 AS P,
    colors AS C;
    
-- 9. Use Case 1: Prepare Master Data

-- SELECT
-- 	product_name, 
--     color, 
--     size,
--     SUM(amount) AS total_sales
-- FROM 
-- 	transactions
-- GROUP BY
-- 	product_name, 
--     color,
--     size;


WITH 
	master_data AS(
		SELECT
			P.name,
			C.color,
			S.size
		FROM 
			products1 AS P, 
			colors AS C, 
			sizes AS S),
	sales AS(
			SELECT
				product_name, 
				color, 
				size,
				SUM(amount) AS total_sales
			FROM 
				transactions
			GROUP BY
				product_name, 
				color,
				size
			)
            
SELECT 
	MD.name, 
    MD.color, 
    MD.size,
    ifnull(t.total_sales,0) AS total_Sales
FROM 
	master_data AS MD 
    LEFT JOIN 
    sales AS T
ON 
	MD.name=T.product_name
    AND
    MD.color=T.color
    AND
    MD.size=T.size
ORDER BY
	total_Sales DESC;


-- 10. Use Case 2 : Prepare Large Number of Rows for Performance Testing
    


