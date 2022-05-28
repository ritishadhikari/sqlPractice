USE ORG;

-- 1. Create the Table
CREATE TABLE
	employee
    (
		emp_id INT NOT NULL PRIMARY KEY, 
        emp_name VARCHAR(256),
        department_id INT,
        salary INT
    );
    
-- 2. Insert Data into the Table
INSERT 
	INTO employee
    (emp_id, emp_name, department_id, salary)
	values
    (1,"Ankit",100,10000),
    (2,"Mohit",100,15000),
    (3,"Vikas",100,10000),
    (4,"Rohit",100,5000),
    (5,"Mudit",200,12000),
    (6,"Agam",200,12000),
    (7,"Sanjay",200,9000),
    (8,"Ashish","200",5000);

SELECT 
	*
FROM 	
	employee;
-- 3. Rank the Salaries Based on the department

SELECT 
	*,
    RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rnk,
    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS dense_rnk,
    ROW_NUMBER() OVER( ORDER BY SALARY asc) AS rowNum
FROM 
	employee;
