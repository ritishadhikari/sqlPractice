USE org;

SELECT 
	*
FROM 
	customers;
    
ALTER TABLE
	customers
ADD 
	age INT;
    
UPDATE 
	customers
SET
	dob = "1992-01-01"
WHERE 
	customer_id=5;

-- Repeat
UPDATE 
	customers
SET
	age=30
WHERE customer_id=5;

INSERT INTO customers
	(customer_id, customer_name, gender, dob, age)
    VALUES
		(6, "Ali", "M", NULL, NULL);
        
-- Unknown cannot be equal to an unknown, hence `is null` and `= null`
SELECT 
	*
FROM 
	customers 
WHERE 
	dob IS NULL;
    
-- Is Not Null
 SELECT 
	*
FROM 
	customers 
WHERE 
	dob IS NOT NULL;

-- Handling Null Values with  IFNULL()
SELECT 
	*,
    IFNULL(dob,"04-07-1987") AS new_dob
FROM
	customers;
    
-- Coalesce is an extension of isnull() function where in we can pass multiple values/column values 
-- and it picks up the first not null vale
SELECT 
	*,
    IFNULL(dob,"04-07-1987") AS dob_ifnull,
    COALESCE(dob, NULL,"05-07-1987",NULL,"04-07-1987") AS dob_coalesce
FROM
	customers;
    
-- Count functions will always give the Not Null Counts
SELECT 
	COUNT(age) avg_count_not_considering_null, -- will give 5
    COUNT(IFNULL(age,0)) AS avg_count_considering_null -- will give 6
FROM 
	customers;

-- Similary Null has to be taken care for other aggregate functions
SELECT 
	AVG(age) avg_age_not_considering_null, -- will give 21
    AVG(IFNULL(age,0)) AS avg_age_considering_null -- will give 6
FROM 
	customers;
