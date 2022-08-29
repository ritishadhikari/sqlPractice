USE org;

-- 1. Create Table Hospital
CREATE TABLE hospital
	(
		emp_id INT,
        action VARCHAR(10),
        time DATETIME
    );
    
-- 2. Insert Data into Hospital
INSERT INTO hospital
	(emp_id, action, time)
    VALUES
		('1', 'in', '2019-12-22 09:00:00'),
        ('1', 'out', '2019-12-22 09:15:00'),
        ('2', 'in', '2019-12-22 09:00:00'),
        ('2', 'out', '2019-12-22 09:15:00'),
        ('2', 'in', '2019-12-22 09:30:00'),
        ('3', 'out', '2019-12-22 09:00:00'),
        ('3', 'in', '2019-12-22 09:15:00'),
        ('3', 'out', '2019-12-22 09:30:00'),
        ('3', 'in', '2019-12-22 09:45:00'),
        ('4', 'in', '2019-12-22 09:45:00'),
        ('5', 'out', '2019-12-22 09:40:00');

-- 3. Write a SQL function to find the total number of people present inside the hospital
-- METHOD 1
-- A.
SELECT 
	b.emp_id,
    b.time,
    b.action
FROM
	(
	SELECT 
		emp_id,
		MAX(time) AS max_time
	FROM 
		hospital 
	GROUP BY
		emp_id
	)    AS a
JOIN
	hospital AS b
	on 
    a.emp_id=b.emp_id
    AND 
    a.max_time=b.time
WHERE 
	b.action="in";

-- B. 
SELECT 
	emp_id,
    MAX(CASE WHEN action="in" THEN time END) AS max_in_time,
    MAX(CASE WHEN action="out" THEN time END) AS MAX_out_time
FROM 
	hospital
GROUP BY
	emp_id
HAVING 
	MAX(CASE WHEN action="in" THEN time END)>MAX(CASE WHEN action="out" THEN time END)
	OR
    MAX(CASE WHEN action="out" THEN time END) IS NULL;

-- Method 2:'
WITH cte_in AS
	(
		SELECT 
			emp_id, 
			MAX(time) AS max_in_time
		FROM 
			hospital
		WHERE 
			action="in"
		GROUP BY 
			emp_id
	),
cte_out AS
	(
		SELECT 
			emp_id, 
			MAX(time) AS max_out_time
		FROM 
			hospital
		WHERE 
			action="out"
		GROUP BY 
			emp_id
	)

SELECT 
	a.emp_id, 
    a.max_in_time AS in_time
FROM 
	cte_in AS a
    LEFT JOIN 
    cte_out AS b
	ON 
	a.emp_id=b.emp_id
WHERE
 	(
		a.max_in_time>b.max_out_time
        OR 
        b.max_out_time IS NULL
    );
		
-- Method 3.
SELECT 
	*
FROM 
	(
		SELECT 
			*, 
			RANK() OVER (PARTITION BY emp_id ORDER BY TIME DESC) AS event_last_to_first
		FROM 
			hospital
	) AS a
WHERE a.event_last_to_first=1
AND a.action="in";

    
