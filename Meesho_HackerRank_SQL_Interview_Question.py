USE org;

-- 1. Create Table products

CREATE TABLE products
	(
		product_id VARCHAR(20),
        cost INT
	);

-- 2. Insert Data into Table: products
INSERT INTO 
	products
    (
		product_id,
        cost
    )
    VALUES
    ('P1',200),
    ('P2',300),
    ('P3',500),
    ('P4',800);
    
-- 3. Create Table customer_budget

CREATE TABLE customer_budget
	(
		customer_id INT,
		budget INT
    );
    
-- 4. Insert Data into table: customer_budget
INSERT INTO customer_budget
(customer_id,budget)
VALUES
(100,400),
(200,800),
(300,1500);

-- 5. Find how many products falls into customer budget along with list of products. In case of clash, chose the less costly product

SELECT 
	customer_id,
    cust_budget,
    count(*) AS numberofItems,
    GROUP_CONCAT(product_id SEPARATOR ',') AS listOfProducts
FROM
(
	SELECT
		*
	FROM
		(
		SELECT
			*, 
			SUM(priceWithinBudget) OVER (PARTITION BY customer_id ORDER BY priceWithinBudget) AS totalPurchaseAmount
		FROM (

			SELECT
				a.customer_id,
				a.budget AS cust_budget,
				b.product_id,
				b.cost AS priceWithinBudget
			FROM 
				customer_budget AS a
				,
				products AS b
			WHERE 
				a.budget>b.cost
			ORDER BY 
				customer_id
		) AS c
		) AS d
	WHERE 
		totalPurchaseAmount<=cust_budget)
AS
	e
GROUP BY 
	customer_id,
    cust_budget;
    
-- Optimized Solution
SELECT
	customer_id,
    cust_budget,
    COUNT(customer_id) AS numberofItems,
    GROUP_CONCAT(product_id) AS listOfProducts
FROM (
	SELECT
					a.customer_id,
					a.budget AS cust_budget,
					b.product_id,
					b.cost AS priceWithinBudget,
					SUM(b.cost) OVER (PARTITION BY customer_id ORDER BY b.cost) AS totalPurchaseAmount
				FROM 
					customer_budget AS a
					,
					products AS b
				WHERE 
					a.budget>b.cost
				ORDER BY 
					customer_id ) AS C
WHERE
	totalPurchaseAmount<cust_budget
GROUP BY 
	customer_id,
    cust_budget;
		

