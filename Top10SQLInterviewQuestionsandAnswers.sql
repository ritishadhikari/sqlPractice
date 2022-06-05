-- 1. CREATE TABLE
CREATE TABLE employee
(
emp_id INT,
emp_name VARCHAR(50),
department_id INT,
salary INT,
manager_id INT
);

CREATE TABLE dept
(
dep_id INTEGER,
dep_name VARCHAR(40)
);

CREATE TABLE orders
(
customer_name VARCHAR(40),
order_date DATE,
order_amount BIGINT,
customer_gender VARCHAR(10)
);

-- Insert Data into the Table
INSERT INTO employee 
(emp_id, emp_name, department_id, salary, manager_id)
VALUES
(1,"Ankit",100,10000,4),
(2,"Mohit",100,15000,5),
(3,"Vikas",100,10000,4),
(4,"Rohit",100,5000,2),
(5,"Mudit",200,12000,6),
(6,"Agam",200,12000,2),
(7,"Sanjay",200,9000,2),
(8,"Ashish",200,5000,2),
(1,"Saurabh",900,12000,2);


INSERT INTO 
	dept(dep_id, dep_name)
VALUES
	(100,"Analytics"),
    (300,"IT");
    
INSERT INTO orders
	(customer_name,order_date,order_amount,customer_gender)
 VALUES 
 ("Shilpa","2020-01-01", 10000,"Male"),
 ("Rahul","2020-01-02",12000,"Female"),
 ("Shilpa","2020-01-02",12000,"Male"),
 ("Rohit","2020-01-03",15000,"Female"),
 ("Shilpa","2020-01-03",14000,"Male");


-- 3. How to Find Duplicates in the Table

SELECT 
	emp_id,
    COUNT(*) AS numberOfEmpployees
FROM 
	employee
GROUP BY
	emp_id
HAVING 
	numberOfEmpployees>1;
    
-- 4. How to Delete Duplicates -- Not Working
WITH CTE AS
	(
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY emp_id) AS rn
	FROM 
		employee) 

DELETE 
FROM 
	CTE 
WHERE rn>1;

-- 5. Difference Between UNION and UNION ALL
-- Union gives Unique Manager ID
SELECT 
	manager_id
FROM 
	employee
UNION
SELECT
	manager_id
FROM 
	employee;

-- Union All will give the Duplicates of the Selected Column

SELECT 
	manager_id
FROM 
	employee
UNION ALL
SELECT
	manager_id
FROM 
	employee;
    
-- 6  What is the difference between Rank, Row_Number and Dense_Rank
-- Rank will give the same rank for the same value, but the next rank will be +1
SELECT
	*,
    RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as salaryDesc
FROM
	employee;

-- Dense Rank will same Rank for same Values, but the next rank will be +n+1 where n is the number of same ranked values prior to the next rank
SELECT
	*,
    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as salaryDesc
FROM
	employee;

--  Row Number just gives the row number irrepective of the value. Order by is independent.

SELECT
	*,
    ROW_NUMBER() OVER () as salaryDesc
FROM
	employee;

-- 7. Find the Employee who are not present in the Department Table

SELECT 
	emp_id,
    emp_name,
    department_id
FROM 
	employee
WHERE 
	department_id NOT IN 
					(
                    SELECT 
						dep_id
                    FROM
						dept
                    );

-- Alternate Method

SELECT
	A.emp_id,
    A.emp_name,
    A.department_id
FROM 
	employee A LEFT JOIN 
    dept B
ON 
	A.department_id=B.dep_id
WHERE 
	B.dep_id IS NULL;


-- 8. Second Highest Salary in each Department
SELECT
	*
FROM
	(
	SELECT 	
		employee.*,
		DENSE_RANK() OVER(PARTITION BY department_id ORDER BY SALARY DESC) AS "higest2"
	FROM 
		employee) AS A
WHERE
	A.higest2=2;


-- 9. Find All Transaction done by Shilpa

SELECT
	*
FROM 	
	orders
WHERE 
	UPPER(customer_name)="SHILPA";

-- 10. Self Join, Manager Salary > Employee Salary

SELECT
	A.*,
    M.emp_id AS managerID,
    M.salary AS managerSalary
FROM 
	employee AS A JOIN
    employee AS M
ON 
	A.manager_id=M.emp_id
WHERE 
	M.salary>A.salary;
    
-- 11. Update Query to swap Gender

-- Select Statement
SELECT
	*,
	CASE WHEN customer_gender="Male" THEN "Female" 
		 WHEN customer_gender="Female" THEN "Male" END AS updated_gender
FROM 
	orders;

-- Update Statement
UPDATE orders SET 
	customer_gender=
		CASE WHEN customer_gender="Male" THEN "Female"
		WHEN customer_gender="Female" THEN "Male"
    END;
    
SELECT
	*
FROM
	orders;
    
