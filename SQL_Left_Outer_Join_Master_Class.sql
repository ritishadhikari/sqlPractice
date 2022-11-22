USE org;

-- 1. Create Table
CREATE TABLE emp1
	(
		emp_id INT,
        emp_name VARCHAR(20),
        dep_id INT, 
        salary INT,
        manager_id INT,
        emp_age INT
    );

-- Insert Data into emp1 Table
INSERT INTO emp1
	(
		emp_id,emp_name,dep_id,salary,manager_id,emp_age
    )
    VALUES
    (1, 'Ankit', 100,10000, 4, 39),
    (2, 'Mohit', 100, 15000, 5, 48),
    (3, 'Vikas', 100, 10000,4,37),
    (4, 'Rohit', 100, 5000, 2, 16),
    (5, 'Mudit', 200, 12000, 6,55),
    (6, 'Agam', 200, 12000,2, 14),
    (7, 'Sanjay', 200, 9000, 2,13),
    (8, 'Ashish', 200,5000,2,12),
    (9, 'Mukesh',300,6000,6,51),
    (10, 'Rakesh',500,7000,6,50);
    
-- 3. Create Table Department
CREATE TABLE dept1
	(
		dep_id INT, 
        dep_name VARCHAR(30)
    );
    
-- 4. Insert Data into Department Table
INSERT INTO dept1
	(
		dep_id, dep_name
    )
    VALUES
		(100,"Analytics"),
        (200,"IT"),
        (300,"HR"),
        (400,"Text Analytics");

SELECT 
	* 
FROM 
	emp1;

-- 5. Join with On Clause
SELECT 
	*
FROM 
	emp1
	LEFT JOIN
    dept1
ON 
	emp1.dep_id=dept1.dep_id
WHERE
	dept1.dep_name="Analytics";


-- The Above query is same as writing:
SELECT 
	*
FROM 
	emp1
	LEFT JOIN
    (SELECT
		*
	FROM 
		dept1 
	WHERE 
		dept1.dep_name="analytics"
        ) AS B
ON 	
	emp1.dep_id=B.dep_id;
    
-- Hence for Join with On Clause, First Filter is Applied on the On Clause 
-- and then Join Happens


-- 6. Join with Where Clause
SELECT 
	*
FROM 
	emp1
	LEFT JOIN
    dept1
ON 
	emp1.dep_id=dept1.dep_id
WHERE
	dept1.dep_name="Analytics";

-- Here with Where Clause, the Join happens First and then the Filter Happens.
-- With the Where Clause at the end, it is as good as doing an Inner Join

-- 7. Give all the Employees whose Department is not present in Department Table

SELECT 
	emp1.*,
    DEPt1.dep_id as S
FROM 
	emp1
    LEFT JOIN 
    dept1
ON 	
	emp1.dep_id=dept1.dep_id
WHERE
	dept1.dep_id IS NULL;


-- ON preserves the Outer Join Characteristics while WHERE migrates the Characteristics
-- to Inner JOIN 
    