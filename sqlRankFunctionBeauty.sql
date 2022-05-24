-- 1. Create SQL Table
USE org;
CREATE TABLE
	covid (
    city VARCHAR(50),
    days DATE,
    cases INT
    );

-- 2. Insert Data to Table
INSERT INTO 
	covid 
    (city,days,cases)
    VALUES
    ('DELHI','2022-01-01',100),
    ('DELHI','2022-01-02',200),
    ('DELHI','2022-01-03',300),
    ('MUMBAI','2022-01-01',100),
    ('MUMBAI','2022-01-02',100),
    ('MUMBAI','2022-01-03',300),
    ('CHENNAI','2022-01-01',100),
    ('CHENNAI','2022-01-02',200),
    ('CHENNAI','2022-01-03',150),
    ('BANGALORE','2022-01-01',100),
    ('BANGALORE','2022-01-02',300),
    ('BANGALORE','2022-01-03',200),
    ('BANGALORE','2022-01-04',400);

-- 3. Find Cities where Covid Cases are Increasing continously
SELECT 
	city
FROM
    (
		SELECT
			city,
			days,
			cases,
			RANK() OVER(PARTITION BY city ORDER by cases) AS caseRank,
			RANK() OVER(PARTITION BY city ORDER by days) AS dayRank
		FROM 
			covid
		) AS A
GROUP BY 
	city
HAVING	
	COUNT(DISTINCT(caseRank*1.0-dayRank*1.0))=1
		;

-- Alternate 
WITH 
	cte AS 
    (
		SELECT
			city,
			days,
			cases,
			RANK() OVER(PARTITION BY city ORDER by cases)*1.0 - RANK() OVER(PARTITION BY city ORDER by days)*1.0 AS rankdiff
		FROM 
			covid
		)

SELECT 
	city
FROM 
	cte 
GROUP BY 
	city
HAVING
	COUNT(DISTINCT(rankdiff))=1
    ;







