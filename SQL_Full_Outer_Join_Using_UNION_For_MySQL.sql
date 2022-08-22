USE org;

-- 1. CREATE Table Customers
CREATE TABLE customer_orders
	(
    order_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    ship_date DATE
    );
    
-- 2. Insert Values into customer_orders Table
INSERT INTO customer_orders
	(order_id,customer_id,order_date,ship_date)
    VALUES
		(1000, 1, '2022-01-05', '2022-01-11'),
        (1001, 2, '2022-02-04', '2022-02-16'),
        (1002, 3, '2022-01-01', '2022-01-19'),
        (1003, 4, '2022-01-06', '2022-01-30'),
        (1004, 6, '2022-02-07', '2022-02-13');
     
SELECT 
	*
FROM
	customers;
SELECT
	*
FROM 
	customer_orders;

-- 3. First Way Using Union - Will Not give Duplicates
SELECT 
	c.customer_id,
    c.customer_name,
    co.customer_id AS co_customer_id,
    co.order_date
FROM 
	customers AS c
    LEFT JOIN 
    customer_orders AS co
	ON
		c.customer_id=co.customer_id
UNION
SELECT 
	c.customer_id,
    c.customer_name,
    co.customer_id AS co_customer_id,
    co.order_date
FROM 
	customers AS c
    RIGHT JOIN 
    customer_orders AS co
	ON
		c.customer_id=co.customer_id;

-- 4. Second Way Using Union All - Will give Duplicates, hence will have to handle it with a condition
SELECT 
	c.customer_id,
    c.customer_name,
    co.customer_id AS co_customer_id,
    co.order_date
FROM 
	customers AS c
    LEFT JOIN 
    customer_orders AS co
	ON
		c.customer_id=co.customer_id
UNION ALL
SELECT 
	c.customer_id,
    c.customer_name,
    co.customer_id AS co_customer_id,
    co.order_date
FROM 
	customers AS c
    RIGHT JOIN 
    customer_orders AS co
	ON
		c.customer_id=co.customer_id
WHERE 
	c.customer_id IS NULL;
	