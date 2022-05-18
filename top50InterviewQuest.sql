CREATE database ORG;

SHOW databases;

USE org;

CREATE TABLE worker (
	worker_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name CHAR(25),
    last_name CHAR(25),
    salary INT(15),
    joining_date DATETIME,
    department CHAR(25)
);

INSERT INTO WORKER 
	(worker_id, first_name, last_name, salary, joining_date, department)
    VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

CREATE TABLE bonus (
	worker_ref_id INT,
    bonus_amount INT(10),
    bonus_date datetime,
    foreign key (worker_ref_id) 
		REFERENCES worker(worker_id) 
		ON DELETE CASCADE
);

INSERT INTO Bonus
	(worker_ref_id, bonus_amount, bonus_date)
    VALUES
		(001, 5000, '16-02-20'),
        (002, 3000, '16-06-11'),
        (003, 4000, '16-02-20'),
        (001, 4500, '16-02-20'),
        (002, 3500, '16-06-11');

CREATE TABLE title	(
	worker_ref_id INT,
    worker_title CHAR(25),
    affected_from DATETIME,
    FOREIGN KEY (worker_ref_id)
		REFERENCES worker(worker_id)
        ON DELETE CASCADE
	);

INSERT INTO title
	(worker_ref_id, worker_title, affected_from) 
    VALUES
    (001, 'Manager', '2016-02-20 00:00:00'),
    (002, 'Executive', '2016-06-11 00:00:00'),
    (008, 'Executive', '2016-06-11 00:00:00'),
    (005, 'Manager', '2016-06-11 00:00:00'),
    (004, 'Asst. Manager', '2016-06-11 00:00:00'),
    (007, 'Executive', '2016-06-11 00:00:00'),
    (006, 'Lead', '2016-06-11 00:00:00'),
    (003, 'Lead', '2016-06-11 00:00:00');

-- 1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>
SELECT 
	first_name AS WORKER_NAME
FROM 
	worker;
    
-- 2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case
SELECT
	UPPER(first_name)
FROM 
	worker;

-- 3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table
SELECT 
	DISTINCT(department)
FROM 
	worker;

-- 4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table
SELECT 
	SUBSTR(first_name,1,3)
FROM 
	worker;

-- 5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table
SELECT 
	INSTR(first_name, BINARY'a') 
FROM 
	worker
WHERE 
	first_name="Amitabh";

-- 6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT 
	RTRIM(first_name)
FROM 
	worker;
    
-- 7.  Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side

SELECT 
	LTRIM(department)
FROM
	worker;

-- 8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length
SELECT 
	DISTINCT(LENGTH(DEPARTMENT))
FROM 
	worker;
    
-- 9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT
	REPLACE(FIRST_NAME,'a','A')
FROM 
	worker;
    
-- 10.  Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them
SELECT
	CONCAT(first_name, " ", last_name) AS complete_name
FROM 
	worker;

-- 11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending
SELECT 
	*
FROM
	worker
ORDER BY 
	first_name;

-- 12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

SELECT 
	*
FROM 
	worker
ORDER BY
	first_name, 
    department DESC;
    
-- 13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table

SELECT 
	*
FROM 
	worker
WHERE 
	first_name IN ("Vipul","Satish");
    
-- 14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table

SELECT 
	*
FROM 
	worker
WHERE 
	first_name NOT IN ("Satish","Vipul");

-- 15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

SELECT
	* 
FROM 
	worker
WHERE
	department LIKE "Admin%";

-- 16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’
SELECT 
	* 
FROM 
	worker
WHERE
	first_name LIKE ("%a%");

-- 17.  Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’
SELECT 
	* 
FROM 
	worker
WHERE 
	first_name LIKE "%a";
    
-- 18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT 
	*
FROM 
	worker
WHERE 
	first_name LIKE ("_____h");

-- 19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000
SELECT 
	*
FROM 
	worker
WHERE 
	SALARY BETWEEN 100000 AND 500000;
    
-- 20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT 
	*
FROM 
	worker
WHERE
	YEAR(joining_date)=2014 AND
    MONTH(joining_date)=2;

-- 21. Write an SQL query to fetch the count of employees working in the department ‘Admin’

SELECT 
	COUNT(*)
FROM 
	worker
WHERE 
	department="Admin";
    
-- 22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000
SELECT 
	CONCAT(first_name," ",last_name),
    salary
FROM	
	worker
WHERE
	salary BETWEEN 50000 AND 100000;

SELECT 
	CONCAT(first_name," ",last_name),
    salary
FROM	
	worker
WHERE
	worker_id IN (
		SELECT 
			worker_id 
		FROM 
			worker
		WHERE 
			salary BETWEEN 50000 AND 100000
		);
	
-- 23. Write an SQL query to fetch the no. of workers for each department in the descending order
SELECT
	COUNT(*) AS NumberOfWorkers,
    department
FROM 	
	worker
GROUP BY department
ORDER BY NumberOfWorkers DESC;

-- 24.  Write an SQL query to print details of the Workers who are also Managers
SELECT 
	DISTINCT(a.first_name), 
    t.worker_title
FROM 
	worker AS a INNER JOIN
    title AS t
WHERE 
	a.worker_id=t.worker_ref_id AND
    t.worker_title="Manager";

-- 25. Write an SQL query to fetch duplicate records having matching data in some fields of a table

SELECT 
	COUNT(*) numberOfRecords,
    worker_title,
    affected_from
FROM 
	title
GROUP BY 
	worker_title,
    affected_from
HAVING
	numberOfRecords>1;

-- 26. Write an SQL query to show only odd rows from a table
SELECT
	* 
FROM 
	worker
WHERE 
	worker_id in (
					SELECT 
						worker_id 
                    FROM 
						worker
					WHERE 
						MOD(worker_id,2)=1
    );

-- 27. Write an SQL query to show only even rows from a table
SELECT
	*
FROM
	worker
WHERE
	worker_id IN (
					SELECT 
						worker_id 
					FROM 
						worker
                    WHERE
						MOD(worker_id,2)=0
    );

-- 28. Write an SQL query to clone a new table from another table.

CREATE 
	TABLE 
		workerClone 
	LIKE
		worker;

-- 29. Write an SQL query to fetch intersecting records of two tables
SELECT
	a.worker_id
FROM
	worker AS a INNER JOIN
    worker AS b
WHERE
	
	MOD(a.WORKER_ID,2)=1 AND
    MOD(b.WORKER_ID,3)=1 AND
    a.WORKER_ID=b.WORKER_ID
    ;

-- 30.  Write an SQL query to show records from one table that another table does not have
-- First Table have all the record while the second table has only records that are divisible by 2
SELECT
	a.worker_id
FROM 
	worker AS a INNER JOIN
    worker AS b
WHERE 
	MOD(b.worker_id,2)<>1 AND
    a.worker_id=b.worker_id;

-- 31. Write an SQL query to show the current date and time

SELECT
SYSDATE();

-- 32. Write an SQL query to show the top n (say 10) records of a table
SELECT 
	*
FROM 
	worker
ORDER BY
	salary DESC
LIMIT 10;

-- 33. Write an SQL query to determine the nth (say n=5) highest salary from a table.

SELECT 
	salary
FROM
	worker
ORDER BY
	salary DESC
LIMIT 4,1;


-- 34. Write an SQL query to determine the 5th highest salary without using TOP or limit method

SELECT
	salary
FROM 
	worker as W1
WHERE 4=(
		SELECT 
			COUNT(DISTINCT(salary))
            FROM 
				worker AS w2
			WHERE w2.salary>=w1.salary
);

SELECT min(T.salary) as salary
FROM(
	SELECT 
		salary 
	FROM 
		worker
	ORDER BY
		salary DESC
	LIMIT 5) AS t;

-- 35. Write an SQL query to fetch the list of employees with the same salary
SELECT 
	a.first_name
FROM 
	worker AS a INNER JOIN
    worker AS b
ON 
	a.salary=b.salary AND
    a.first_name<>b.first_name;
    
-- 36. Write an SQL query to show the second highest salary from a table
SELECT 
	MAX(salary)
FROM
	worker
WHERE salary NOT IN (
				SELECT 
					MAX(SALARY)
				FROM 
					worker
);

-- 37. Write an SQL query to show the second highest salary from a table
SELECT 
	a.*
FROM 
	title AS a JOIN title as b
WHERE 
	a.worker_title="Manager" AND 
    b.worker_title="Manager"
    AND a.worker_title=b.worker_title;
    
-- 38. Write an SQL query to fetch intersecting records of two tables.
-- Repeated

-- 39. Write an SQL query to fetch the first 50% records from a table.
SELECT
	*
FROM 
	worker
WHERE 
	worker_id <= (
					SELECT 
						COUNT(worker_id)/2
					FROM
						worker
            );

-- 40. Write an SQL query to fetch the departments that have less than five people in it
SELECT 
	COUNT(department) AS NumOfPeople,
    department
FROM 
	worker
GROUP BY
	department
having
	NumOfPeople<5;

-- 41.  Write an SQL query to show all departments along with the number of people in there

SELECT 
	COUNT(department) AS NoOfPeople, 
    department
FROM 
	worker
GROUP BY 
	department;
    
-- Write an SQL query to show the last record from a table

SELECT 
	*
FROM 
	worker
WHERE
	worker_id=(
				SELECT 
					MAX(worker_id)
				FROM
					worker
    );

-- 43. Write an SQL query to fetch the first row of a table
SELECT 
	* 
FROM 
	worker
WHERE
	worker_id = (
					SELECT 
						MIN(worker_id)
					FROM 
						worker
                        );

-- 	44.  Write an SQL query to fetch the last five records from a table
(SELECT 
	*
FROM
	worker
ORDER BY 
	worker_id DESC
LIMIT 5)
	ORDER BY
		worker_id;
        
	

-- 45. Write an SQL query to print the name of employees having the highest salary in each department
SELECT
	w.first_name,
    w.department,
    w.salary
FROM 
	worker AS w
WHERE 
	w.salary IN
	(SELECT 
		MAX(SALARY) as max_salary
	FROM 
		worker
	GROUP BY
		department) ;


SELECT
	t.first_name,
    t.salary,
    t.department
FROM
	worker as t INNER JOIN (
								SELECT 
									MAX(salary) as max_salary,
                                    department
								FROM 
									worker
								GROUP BY
									department
						  ) as temp
	ON 
		t.department=temp.department AND
        t.salary=temp.max_salary;

-- 46. Write an SQL query to fetch three max salaries from a table

SELECT 
	t.* 
FROM 
	(
		SELECT 
			DISTINCT(salary) AS dist_salary
		FROM 
			worker
		ORDER BY
			dist_salary DESC
	) AS t
LIMIT 3;

-- 47. Write an SQL query to fetch three min salaries from a table

SELECT 
	t.*
FROM 
	(
    SELECT 
		DISTINCT(salary) as unique_salary
	FROM 
		worker 
	ORDER BY 
		unique_salary 
    ) AS t
LIMIT 3;

-- 48. Write an SQL query to fetch nth max salaries from a table
-- Repeatative

-- 49. Write an SQL query to fetch departments along with the total salaries paid for each of them
SELECT 
	department,
    SUM(salary) AS total_salary
FROM
	worker
GROUP BY 
	department
ORDER BY 
	total_salary DESC;
    
-- 50. Write an SQL query to fetch the names of workers who earn the highest salary

SELECT
	a.first_name,
    a.salary
FROM 
	WORKER AS a INNER JOIN
		(
			SELECT 
				MAX(SALARY) as max_salary
			FROM 
				worker
		) AS t
ON 
	a.salary=t.max_salary;
