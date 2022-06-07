-- 1. Create Table:

CREATE TABLE int_orders
(
order_number INT NOT NULL PRIMARY KEY,
order_date DATE NOT NULL,
cust_id INT NOT NULL,
salesperson_id INT NOT NULL,
amount FLOAT NOT NULL
);

-- 2. Insert Values into the Table
INSERT INTO int_orders
(order_number,order_date,cust_id,salesperson_id,amount)
	VALUES
    (30, CAST(N'1995-07-14' AS Date), 9, 1, 460),
    (10, CAST(N'1996-08-02' AS Date), 4, 2, 540),
    (40, CAST(N'1998-01-29' AS Date), 7, 2, 2400),
    (50, CAST(N'1998-02-03' AS Date), 6, 7, 600),
    (60, CAST(N'1998-03-02' AS Date), 6, 7, 720),
    (70, CAST(N'1998-05-06' AS Date), 9, 7, 150),
    (20, CAST(N'1999-01-30' AS Date), 4, 8, 1800);
    
SELECT 
	*
FROM 
	int_orders;

-- 3. Simple Sum
SELECT 
	SUM(amount)
FROM 
	int_orders;
    
-- 4. Sum per SalesPerson

SELECT 
	salesperson_id,
    SUM(amount) AS SalesPersonTotalSum
FROM 
	int_orders
GROUP BY
	salesperson_id;

-- 5. Use Window Function to get the Sum of Sales per SalesPerson

SELECT 
	*,
    SUM(amount) OVER(PARTITION BY salesperson_id) AS SalesPersonAmount
FROM 
	int_orders;
    
-- 6. Sort the Sum by Order Date

SELECT 
	*,
    SUM(amount) OVER (ORDER BY order_date)
FROM
	int_orders;
    

-- 6. Sort the Sum by Order Date Partition by SalesPersonID
SELECT 
	*,
    SUM(amount) OVER (PARTITION BY salesperson_id ORDER BY order_date) RecurringSumOnOrderDatePerSalesPerson
FROM
	int_orders;
    
-- 7. Give the Sum of Sales which will include only the two preceeding rows and the current row:
SELECT 
	*,
    SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS recurringSum
FROM 
	int_orders;
    
-- 7. Give the Sum of Sales which will include only the two preceeding rows and NOT the current row:
SELECT
	*,
    SUM(amount) OVER(order by order_date ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS SumFromLastTwoRows
FROM
	int_orders;

-- 7. Give the Sum of Sales which will include one preceeding row, the current row and the following row:
SELECT 	
	*, 
    SUM(amount) OVER(ORDER BY amount ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS sumofSalesPrecessingFollowing
FROM 
	int_orders;
    
-- 8. Give the Sum of Sales for all the preceeding row and the current row :
SELECT 
	*,
    SUM(amount) OVER(ORDER BY amount ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulativeAmount
FROM
	int_orders;
    
-- 8. Give the Sum of Sales for One preceeding row and the current row for each Salesperson_id:
SELECT 
	*,
    SUM(amount) OVER(PARTITION BY salesperson_id ORDER BY amount ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS cumulativeAmount
FROM
	int_orders;

-- 9. Give the Lag Amount wothout using Lag
SELECT 
	*,
    LAG(amount,1) OVER (PARTITION BY salesperson_id ORDER BY AMOUNT) AS LaggedAmountActual,
    SUM(amount) OVER (PARTITION BY salesperson_id ORDER BY AMOUNT ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS LaggedAmountPreceding
FROM
	int_orders;