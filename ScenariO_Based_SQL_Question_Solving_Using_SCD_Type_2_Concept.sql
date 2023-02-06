USE org;

CREATE TABLE billings
	(
		emp_name VARCHAR(10),
        bill_date DATE,
        bill_rate INT
    );
    
INSERT INTO billings
	VALUES
		 ('Sachin','1990-01-01',25)
		,('Sehwag' ,'1989-01-01', 15)
		,('Dhoni' ,'1989-01-01', 20)
		,('Sachin' ,'1991-02-05', 30);
        
CREATE TABLE hoursWorked
	(
		emp_name VARCHAR(20),
        work_date DATE,
        bill_hrs INT
    );
    
INSERT INTO hoursWorked
	(emp_name,work_date,bill_hrs)
    VALUES
		('Sachin', '1990-07-01' ,3)
		,('Sachin', '1990-08-01', 5)
		,('Sehwag','1990-07-01', 2)
		,('Sachin','1991-07-01', 4);
        
-- Calculate Total Charges as per Billing Rate
with cte AS 
	(
	SELECT 
		*,
		LEAD (date_add(bill_date,INTERVAL -1 DAY) ,1,"9999-12-31") OVER (PARTITION BY emp_name ORDER BY bill_date) AS bill_end_date
	FROM 
		billings
        )

SELECT 
	a.emp_name,
    SUM(b.bill_hrs*a.bill_rate) AS total_wage
FROM 
	cte AS a
    INNER JOIN
    hoursWorked AS b
ON 
	a.emp_name=b.emp_name
AND 
	b.work_date<=a.bill_end_date 
AND 
	b.work_date>=a.bill_date
GROUP BY
	b.emp_name;
    

