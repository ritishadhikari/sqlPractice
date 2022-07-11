USE org;

-- 1. Create the Table emp_2020

CREATE TABLE emp_2020
	(
		emp_id INT,
        designation VARCHAR(20)
    );

-- 2. Create Table emp_2021

CREATE TABLE emp_2021
	(
		emp_id INT,
        designation VARCHAR(20)
    );

-- 3. Insert Data into emp_2020
INSERT INTO emp_2020
	(
		emp_id, designation
    )
    VALUES
		(1,'Trainee'),
        (2,'Developer'),
        (3,'Senior Developer'),
        (4,'Manager');
        
-- 4. Insert Data into emp_2021
INSERT INTO emp_2021
	(
		emp_id, designation
    )
    VALUES
		(1,'Developer'),
		(2,'Developer'),
		(3,'Manager'),
		(5,'Trainee');
        
SELECT
	* 
FROM 
	emp_2020;

SELECT
	* 
FROM 
	emp_2021;
    

-- 5.
WITH cte AS
(
	SELECT 
		a.emp_id AS employeeID,
		a.designation AS deignation2020,
		b.designation AS deignation2021
	FROM 
		emp_2020 AS a
			LEFT JOIN 
		emp_2021 AS b
	ON 
		a.emp_id=b.emp_id
	AND 
		a.designation<>b.designation
		
	UNION 

	SELECT 
		a.emp_id AS employeeID,
		a.designation AS deignation2020,
		b.designation AS deignation2021
	FROM 
		emp_2020 AS a
			RIGHT JOIN 
		emp_2021 AS b
	ON 
		a.emp_id=b.emp_id
	AND 
		a.designation<>b.designation
)

SELECT 
	*
FROM 
	CTE 
WHERE 
	deignation2020 IS NOT NULL
		OR
	deignation2021 IS NOT NULL;



	

    