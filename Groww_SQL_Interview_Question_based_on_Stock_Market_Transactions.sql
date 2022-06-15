USE org;
-- 1. Create Table Buy
CREATE TABLE buy 
(
	date INT,
    time INT,
    qty INT,
    per_share_price INT,
    total_value INT
);

-- 2. Create Table Sell
CREATE TABLE sell
(
	date INT,
    time INT,
    qty INT,
    per_share_price INT,
    total_value INT
);

-- 3. Insert data into buy table
INSERT INTO buy
	(date, time, qty, per_share_price, total_value)
	VALUES
	(15, 10, 10, 10, 100),
	(15, 14, 20, 10, 200);

-- 4. Insert data into sell table
INSERT INTO sell
	(date, time, qty, per_share_price, total_value)
	VALUES
    (15, 15, 15, 20, 300);


SELECT 
	*
FROM
	buy;

SELECT 
	*
FROM 
	sell;
    
-- 5. Provide a Dashboard Capturing the Buy Quantity, Sell Quantity in Buy Table after taking Note of the Sold Quantity from the Sell Table

SELECT
	CASE WHEN sellQuantity>runningBuyQuantity THEN buyQuantity ELSE sellQuantity-BoughtBeforeNow END AS buy_qty
FROM
	(
	SELECT 
		b.time,
		b.qty AS buyQuantity,
		sum(b.qty) OVER(ORDER BY b.time) as runningBuyQty,
		IFNULL(sum(b.qty) OVER(ORDER BY b.time ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING),0) AS BoughtBeforeNow,
		s.qty AS sellQuantity
	FROM 
		buy AS b,
		sell AS s
	WHERE 
		b.date=s.date
	AND 
		b.time<s.time
        ) AS C



    
