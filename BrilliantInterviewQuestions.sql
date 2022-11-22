-- 1. Create the Database

CREATE TABLE
	org.intorders
		(
			order_number INT NOT NULL PRIMARY KEY,
            order_date DATE NOT NULL,
            cust_id INT NOT NULL,
            salesperson_id INT NOT NULL,
            amount FLOAT NOT NULL
        );

-- 2. Insert Values
INSERT INTO 
	intorders
    (order_number,order_date,cust_id,salesperson_id,amount)
    VALUES 
    (30, CAST('1975-07-14' AS DATE),9,1,460),
    (10, CAST('1996-08-02' AS Date), 4, 2, 540),
    (40, CAST('1998-01-29' AS Date), 7, 2, 2400),
	(50, CAST('1998-02-03' AS Date), 6, 7, 600),
    (60, CAST('1998-03-02' AS Date), 6, 7, 720),
	(70, CAST('1998-05-06' AS Date), 9, 7, 150),
    (20, CAST('1999-01-30' AS Date), 4, 8, 1800);

SELECT
	*
FROM 
	int_orders;
    
SELECT
	A.*
FROM 
    int_orders A
    JOIN
    (
	SELECT
		salesperson_id,
		max(amount) maxAmount
	FROM 
		intorders
	GROUP BY
		salesperson_id) AS B
ON 
	A.amount=B.maxAmount
	AND
    A.salesperson_id=B.salesperson_id
;

-- 3. Find the Largest Order By Value for each salesperson and display order details
-- Get the result without using subquery, cte, window functions, temp tables

SELECT 
	a.*,
    b.amount as b_amount
FROM 
	intorders AS a LEFT JOIN
    intorders AS b
ON 
	a.salesperson_id=b.salesperson_id
GROUP BY 
	a.order_number,
    a.order_date,
    a.cust_id,
    a.salesperson_id,
    a.amount
HAVING 
	a.amount>=MAX(b.amount)
ORDER BY
	a.salesperson_id;

SELECT
	*
FROM 
	intorders;
    

	