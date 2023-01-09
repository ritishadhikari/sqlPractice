USE org;

CREATE TABLE
	employee_fv_lv
    (
		emp_id INT,
        emp_name VARCHAR(20),
        dept_id INT,
        salary INT,
        manager_id INT,
        emp_age INT
    );

INSERT INTO 
		employee_fv_lv
        VALUES
			(1,'Ankit',100,10000,4,39)
            ,(2,'Mohit',100,15000,5,48)
            ,(3,'Vikas',100,10000,4,37)
            ,(4,'Rohit',100,5000,2,16)
            ,(5,'Mudit',200,12000,6,55)
            ,(6,'Agam',200,12000,2,14)
            ,(7,'Sanjay',200,9000,2,13)
            ,(8,'Ashish',200,5000,2,12)
            ,(9,'Mukesh',300,6000,6,51)
            ,(10,'Rakesh',500,7000,6,50);
		
SELECT 
	*
FROM 
	employee_fv_lv;
    
/*
First Emp Name based on the lowest Salary
*/

SELECT
	*,
    -- first_value will not work if we use ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    FIRST_VALUE(emp_name) OVER(PARTITION BY dept_id ORDER BY salary) AS first_employee,
	-- last_value will not work if we do not use ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    LAST_VALUE (emp_name) OVER (PARTITION BY dept_id ORDER BY salary ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS last_employee
FROM 
	employee_fv_lv;


SELECT
	*,
    -- Gives the name of the employee who has the highest salary 
    FIRST_VALUE(emp_name) OVER(PARTITION BY dept_id ORDER BY salary DESC) AS first_employee,
	-- Gives the name of the employee whose salary is highest and also is at the last
    LAST_VALUE (emp_name) OVER (PARTITION BY dept_id ORDER BY salary ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS last_employee
FROM 
	employee_fv_lv
ORDER BY 
	dept_id;
