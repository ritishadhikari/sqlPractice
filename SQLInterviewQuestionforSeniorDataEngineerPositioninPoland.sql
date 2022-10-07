USE org;

CREATE TABLE
	emp_salary
	(
		emp_id INTEGER NOT NULL,
        name NVARCHAR(20) NOT NULL,
        salary NVARCHAR(30),
        dept_id INTEGER
    );
    
INSERT INTO 
	emp_salary
	(emp_id, name, salary, dept_id)
	VALUES
		(101, 'sohan', '3000', '11'),
		(102, 'rohan', '4000', '12'),
		(103, 'mohan', '5000', '13'),
		(104, 'cat', '3000', '11'),
		(105, 'suresh', '4000', '12'),
		(109, 'mahesh', '7000', '12'),
        (109, 'mahesh', '5000', '12'),
		(108, 'kamal', '8000', '11');
    
SELECT
	*
FROM 
	emp_salary;
    
-- Write a SQL to return all employee whose salary is same in same department
-- Ritish's Technique
SELECT
	e1.*
FROM 
	emp_salary AS e1
    INNER JOIN
    emp_salary AS e2
    ON
    e1.name<>e2.name
    AND 
    e1.salary=e2.salary
    AND 
    e1.dept_id=e2.dept_id
ORDER BY dept_id;
    
-- Ankit's technique 1 - Using Inner Join

DELETE FROM
	emp_salary;

WITH CTE AS
	(
	SELECT 
		dept_id,
		salary
	FROM 	
		emp_salary
	GROUP BY
		dept_id,
		salary
	HAVING 
		count(1)>1
        )
SELECT 
	e.*
FROM 
	emp_salary AS e
	INNER JOIN
    CTE as b
    ON 
	e.dept_id=b.dept_id
    AND 
    e.salary=b.salary;

-- Ankit's technique 2 - Using Self Join (Tricky)
WITH CTE AS
	(
	SELECT 
		dept_id,
		salary
	FROM 	
		emp_salary
	GROUP BY
		dept_id,
		salary
	HAVING 
		count(1)=1
        )
SELECT 
	e.*
FROM 
	emp_salary AS e
	LEFT JOIN
    CTE as b
    ON 
	e.dept_id=b.dept_id
    AND 
    e.salary=b.salary
    WHERE -- After the Join Takes Place
	b.dept_id IS NULL;