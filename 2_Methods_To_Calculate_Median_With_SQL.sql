USE org;

CREATE TABLE emp
	(
		emp_id INT,
        emp_name VARCHAR(20),
        department_id INT, 
        salary INT,
        manager_id INT, 
        emp_age INT
    );
    
INSERT INTO emp
	values
		
Yash Soni
4 months ago
DDL and Insert values for  emp table.

create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

INSERT INTO emp
	(emp_id,emp_name,department_id,salary,manager_id,emp_age)
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
	(10, 'Rakesh',300,7000,6,50);

SELECT
	*
FROM 
	emp;
    
-- Incase of odd number of records, take the middle number
-- Incase of even number of records, take the average of the middle two numbers
-- Method #1: Median Using row_number
WITH cte AS	
	(
	SELECT
		*,
		CAST(ROW_NUMBER() OVER (ORDER BY emp_age ASC) AS SIGNED) AS ageAscending,
		CAST(ROW_NUMBER() OVER (ORDER BY emp_age DESC) AS SIGNED) AS ageDescending
	FROM 
		emp
	)
    
SELECT 
	AVG(emp_age)
FROM 
	cte
WHERE 
	ABS(ageAscending-ageDescending)<=1;

-- Method #2 Median using percentile_count
-- only with sqlServer