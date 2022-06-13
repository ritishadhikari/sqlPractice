USE org;

-- 1. Gives the Day

SELECT
	DAY("2022-06-13");
    
-- 2. Gives the Week of the Year
SELECT
	WEEK("2022-06-13");

-- 3. Gives the Year
SELECT
	YEAR("2022-06-13");
 
-- 4. Gives the Day of the Week (Monday Being 0 and Sunday being 6)
SELECT
	WEEKDAY("2022-06-14");
    
-- 5. Add Two Days from 2022-06-13
SELECT
	DATE_ADD("2022-06-13",INTERVAL 2 DAY);
    
-- 6. Add Three Months from 2022-06-13
SELECT
	DATE_ADD("2022-06-13", INTERVAL 3 MONTH);

-- 7. Datediff Function gives the Number of Days between Two Days
SELECT 
	DATEDIFF(now(),"2022-06-03") AS DaysSinceTransplant;

-- 8. CREATE a Table
CREATE TABLE IF NOT EXISTS customer_order
	(order_id INTEGER PRIMARY KEY,
    customer_id INTEGER ,
    order_date DATE,
    ship_date DATE);
    
-- 9. Insert Data Into Table
INSERT INTO
	customer_order
(order_id,customer_id,order_date,ship_date)
VALUES
	(1000,1,"2022-01-05","2022-01-11"),
	(1001,2,"2022-02-04","2022-02-16"),
    (1002,3,"2022-01-01","2022-01-19"),
    (1003,4,"2022-01-06","2022-01-30"),
    (1004,1,"2022-02-07","2022-02-13"),
    (1005,4,"2022-01-07","2022-01-31"),
    (1006,3,"2022-02-08","2022-02-26"),
    (1007,2,"2022-02-09","2022-02-21"),
    (1008,4,"2022-02-10","2022-03-06");
    
SELECT 
	*
FROM 
	customer_order;
    
-- 10. Shipping Date Difference Since Order
SELECT
	*,
	DATEDIFF(ship_date,order_date) AS DaysToShip
FROM 
	customer_order;
    
-- 11. Count Business Days between Ordering and Shipping
SELECT
	*,
    DATEDIFF(ship_date,order_date) AS DaysToShip,
    ROUND(DATEDIFF(ship_date,order_date)-DATEDIFF(ship_date,order_date)*(2/7),0) AS BusinessDaysToShip
FROM 
	customer_order;

-- 12. CREATE a Table
CREATE TABLE IF NOT EXISTS customers
	(customer_id INTEGER , 
    customer_name VARCHAR(50),
    gender CHAR(1),
    dob DATE);
    
-- 13. Insert Into Table

INSERT INTO
	customers
(customer_id,customer_name,gender,dob)
	VALUES
	(1,"Rahul","M","2000-01-05"),
    (2,"Shilpa","F","2004-04-05"),
    (3,"Ramesh","M","2003-07-07"),
    (4,"Katrina","F","2005-02-05"),
    (5,"Alia","F","1992-01-01");
    

SELECT
	*
FROM
	customers;
    
-- 14. Find the Present Age of the Customers
SELECT
	*,
	ROUND(DATEDIFF(now(),dob)/365,0) AS age
FROM
	customers;
    

with cte as 
(
select date_add(curdate(),INTERVAL 5 DAY) as new_date
)
select 
case when weekday(new_date) = 5 then date_add(new_date, interval 2 day)
when weekday(new_date) = 6 then date_add(new_date,interval 1 day)
else new_date
end as new_date
from cte;



-- 15. Add the Next Business Days for the Shipping Date (Assignment)

SELECT
	*,
	CASE WHEN WEEKDAY(ship_date)=5 THEN DATE_ADD(ship_date, INTERVAL 2 DAY)
		 WHEN WEEKDAY(ship_date)=6 THEN DATE_ADD(ship_date, INTERVAL 1 DAY)
         ELSE ship_date END AS newShipDate
FROM 
	customer_order;
