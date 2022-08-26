USE org;

-- 1. Create Table exams
CREATE TABLE exams
	(
	student_id INT,
    subject  VARCHAR(20),
    marks INT
    );

-- 2. Delete Existing Data from Table
DELETE FROM exams;

-- 3. Insert Data into exams table
INSERT INTO exams
	(student_id,subject,marks)
    VALUES
		(1,'Chemistry',91),
        (1,'Physics',91),
        (2,'Chemistry',80),
        (2,'Physics',90),	
        (3,'Chemistry',80),
        (4,'Chemistry',54),
        (4,'Physics',54);


SELECT 
	*
FROM 
	exams;
    
-- 4. Find Students with same marks in Physics and Chemistry
-- a. Ritish's Solution
WITH cte1 AS
	(
		SELECT 
			student_id,
			CAST(AVG(marks) AS UNSIGNED) average_marks
		FROM 
			exams
		GROUP BY student_id
	),
cte2 AS 
	(
	SELECT 
		student_id,
		SUM(CASE WHEN subject='Physics' THEN Marks ELSE Null END) AS Physics_Marks,
		SUM(CASE WHEN subject='Chemistry' THEN Marks ELSE Null END) AS Chemistry_Marks
	FROM 
		exams
	GROUP BY
		student_id
	)

SELECT 
	A.student_id
FROM
	cte1 AS A
INNER JOIN 
	cte2 AS B
WHERE 
	A.average_marks=B.Physics_Marks
		AND
A.average_marks=B.Chemistry_Marks;

-- b. Ankit's Solution
SELECT 
	student_id
FROM 
	exams
WHERE 
	subject in ("Chemistry","Physics")
GROUP BY
	student_id
HAVING 
	COUNT(DISTINCT subject)=2
	AND 
    COUNT(DISTINCT marks)=1;
	
    
