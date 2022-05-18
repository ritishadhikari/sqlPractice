-- 1. Create Students Table

CREATE TABLE 
	students (
				studentid INT NULL,
                studentname NVARCHAR(255) NULL,
                subject NVARCHAR(255) NULL,
                marks INT NULL,
                testid INT NULL,
                testdate DATE NULL
                );
	
-- 2. Insert Data into Student Table
INSERT INTO 
	students (studentid, studentname, subject, marks, testid, testdate)
    VALUES 
		(2,'Max Ruin','Subject1',63,1,'2022-01-02'),
        (3,'Arnold','Subject1',95,1,'2022-01-02'),
        (4,'Krish Star','Subject1',61,1,'2022-01-02'),
        (5,'John Mike','Subject1',91,1,'2022-01-02'),
        (4,'Krish Star','Subject2',71,1,'2022-01-02'),
        (3,'Arnold','Subject2',32,1,'2022-01-02'),
        (5,'John Mike','Subject2',61,2,'2022-11-02'),
        (1,'John Deo','Subject2',60,1,'2022-01-02'),
        (2,'Max Ruin','Subject2',84,1,'2022-01-02'),
        (2,'Max Ruin','Subject3',29,3,'2022-01-03'),
        (5,'John Mike','Subject3',98,2,'2022-11-02');
        
-- 3. Write a SQL Query to get the list of students who scored above the average marks in each subject
SELECT 
	s.studentid,
    s.studentname,
    s.marks,
    s.subject
FROM 
	students as s INNER JOIN
	(
	SELECT 
		AVG(marks) as average_marks,
		subject
	FROM 
		students
	GROUP BY
		subject) AS t
ON
	s.subject=t.subject 
WHERE
    s.marks> t.average_marks;

-- Alternate

WITH 
	t AS
    (
		SELECT 
				AVG(marks) as average_marks,
				subject
			FROM 
				students
			GROUP BY
				subject
	)

SELECT 
	s.studentid,
    s.studentname,
    s.marks,
    s.subject
FROM 
	students as s INNER JOIN
    t 
ON
	s.subject=t.subject 
WHERE
    s.marks> t.average_marks;

-- 4. Write an SQL Query to get the percentage of students who score more than 90 in any subject amongst the total students
      
WITH 
	uniqueStudentCount AS 
    (
    SELECT 
		COUNT(DISTINCT(studentname)) AS num_student 
	FROM 
		students
    )

SELECT
	COUNT(DISTINCT(studentname))/u.num_student*100 AS percentageOfStudentGT90
FROM 
	students AS s, uniqueStudentCount AS u
WHERE 
	s.marks>90;

-- alternate

SELECT
	COUNT(DISTINCT(CASE WHEN marks>90 THEN studentname ELSE null END))*1.0/ COUNT(DISTINCT(studentname))*100 AS percentageOfStudentGT90
FROM 
	students;
    
-- 5. Write an SQL Query to Get the 2nd Highest and The Second Lowest Marks for each Subject
SELECT 
	subject,
	SUM(CASE WHEN rnk_asc=2 THEN marks ELSE null END) AS "Second Lowest",
    SUM(CASE WHEN rnk_desc=2 THEN marks ELSE null END) AS "Second Highest"
FROM
(
SELECT
		subject,
		marks, 
		RANK() OVER(PARTITION BY subject ORDER BY marks ASC) AS rnk_asc,
		RANK() OVER(PARTITION BY subject ORDER BY marks DESC) AS rnk_desc
	FROM
		students) AS A
GROUP BY 
	subject;


-- 6. For Each student and test, identify if their marks increased or decreased from the previous test
SELECT 
	studentid,
    studentname,
    totalmarks AS presentMarks,
    laggedvalue AS previousMarks,
	CASE WHEN laggedvalue<totalmarks THEN "Decreased" ELSE "Increased" END AS Result
FROM (
	 SELECT 
			*,
			LAG (a.totalMarks,1) OVER(PARTITION BY studentid) AS laggedvalue
		FROM (
			 SELECT 
				studentname,
                studentid,
				testid,
				SUM(marks) AS totalMarks
			FROM 
				students
			GROUP BY
				studentid,
				testid) AS a
) AS B
WHERE 
	laggedvalue IS NOT NULL
;



