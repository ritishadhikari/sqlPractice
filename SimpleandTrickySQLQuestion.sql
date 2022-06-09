-- 1. Create Table
USE org;
CREATE TABLE
	list (
			id VARCHAR(5)
    );
    
-- 2. Insert Data Into Table
INSERT INTO 
	list (id)
    VALUES
    ('a'),
    ('a'),
    ('b'),
    ('c'),
    ('c'),
    ('c'),
    ('d'),
    ('d'),
    ('e');


-- 3. Rank the Duplicate Records
WITH
cte AS (
SELECT 
	id
FROM
	list
GROUP BY
	id
HAVING
	COUNT(id)>1
)

SELECT 
	a.id,
    CONCAT("DUP",b.idRank) as idRank
FROM 
	list AS a LEFT JOIN
	(SELECT 
			id,
			RANK() OVER(ORDER BY id) AS idRank
	FROM 
		cte) AS b
ON 
	a.id=b.id
;