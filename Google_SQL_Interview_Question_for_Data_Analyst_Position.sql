-- 1. Create Table
USE ORG;
CREATE TABLE
	company_users
    (
		company_id INT,
        user_id INT,
        language VARCHAR(20)
    );
    
-- 2. Insert Data into the Table
INSERT INTO
 company_users 
	(company_id, user_id, language)
 VALUES
	(1,1,'English'),
	(1,1,'German'),
	(1,2,'English'),
	(1,3,'German'),
	(1,3,'English'),
	(1,4,'English'),
	(2,5,'English'),
	(2,5,'German'),
	(2,5,'Spanish'),
	(2,6,'German'),
	(2,6,'Spanish'),
	(2,7,'English');

SELECT 
	* 
FROM 
	company_users;

-- 3. Find companies who have atleast 2 users who speaks English and German both the languages
WITH 
	cte AS(
SELECT
	* 
FROM 
	company_users
WHERE	
	language IN ("English","German")
    )

SELECT 
	company_id FROM 
	(
SELECT 
	B.* 
FROM 
(
SELECT 
	company_id,
    user_id,
    Count(user_id) AS languageKnown
FROM 
	cte
GROUP BY
	company_id,
    user_id
)
AS b
WHERE 
	b.languageKnown=2
    ) AS C
 GROUP BY
	C.company_id
HAVING 
	COUNT(C.company_id)=2
    ;


WITH 
	cte AS(
SELECT
	* 
FROM 
	company_users
WHERE	
	language IN ("English","German")
    )

SELECT 
	c.company_id,
    COUNT(C.company_id) as CountofEmployees
FROM
	(
	SELECT
		b.*
	FROM (
		SELECT 
			company_id,
			user_id,
			Count(user_id) AS languageKnown
		FROM 
			cte
		GROUP BY
			company_id,
			user_id
	) AS b
	WHERE
		b.languageKnown=2) AS c
GROUP BY
	c.company_id
HAVING 
	c.company_id=1
;










-- Alternate

WITH 
	cte AS(
SELECT
	* 
FROM 
	company_users
WHERE	
	language IN ("English","German")
    )

SELECT 
	A.company_id
FROM
(
SELECT 
	company_id,
    user_id,
    Count(user_id) AS languageKnown
FROM 
	cte
GROUP BY
	company_id,
    user_id
HAVING
	languageKnown=2) AS A
GROUP BY
	company_id
HAVING
	COUNT(company_id)>=2;

-- Ankit's Solution
SELECT 
	A.company_id,
    COUNT(A.user_id) AS numberOfUsers
FROM
	(
		SELECT
			company_id,
			user_id,
			Count(user_id) AS LangKnown
		FROM
			company_users
		WHERE 
			language IN ("English","German")
		GROUP BY
			company_id,
			user_id
		HAVING
			LangKnown=2
	) AS A
GROUP BY 
	A.company_id
HAVING 
	COUNT(A.user_id)=2;
