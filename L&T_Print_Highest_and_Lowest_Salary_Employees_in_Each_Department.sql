USE org;

CREATE table employee1
	(
		emp_name VARCHAR(10),
        dep_id INT,
        salary INT
    );

DELETE FROM 
	employee1;

INSERT INTO 
	employee1 
	(emp_name,dep_id,salary)
VALUES
	('Siva',1,30000),
    ('Ravi',2,40000),
    ('Prasad',1,50000),
    ('Sai',2,20000);

SELECT 
	*
FROM 
	employee1;
    
-- Write a Query to print Highest and Lowest Salary Employee in each Department

-- 1. Using Case When, Aggregation and Join
WITH cte AS
(
	SELECT 
		dep_id,
		MIN(salary) AS minSalary,
		MAX(salary) AS maxSalary
	FROM 
		employee1
	GROUP BY
		dep_id
)

SELECT 
	e.dep_id
    -- ,c.minSalary
    -- ,c.maxSalary
    ,MAX(CASE WHEN e.salary=c.minSalary THEN e.emp_name ELSE NULL END) AS lowest_salary
	,MAX(CASE WHEN e.salary=c.maxSalary THEN e.emp_name ELSE NULL END) AS highest_salary
FROM 
	employee1 e
INNER JOIN 
	cte c
ON 
	e.dep_id=c.dep_id
GROUP BY
	c.dep_id;
	
-- 2. Ranking, Case When and Aggregation
WITH CTE as
	(
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY dep_id ORDER BY salary) AS salaryDesc,
		ROW_NUMBER() OVER(PARTITION BY dep_id ORDER BY salary DESC) AS salaryAsc
	FROM 
		employee1
	)
    
SELECT 
	CTE.dep_id,
	MAX(CASE WHEN salaryDesc=1 THEN emp_name ELSE NULL END) AS highest_salary,
    MAX(CASE WHEN salaryAsc=1 THEN emp_name ELSE NULL END) AS lowest_salary
FROM 
	CTE
GROUP BY 
	CTE.dep_id;