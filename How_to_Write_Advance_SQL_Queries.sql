CREATE TABLE bms 
	(
		seat_no INT,
        is_empty VARCHAR(10)
	);
    
INSERT INTO bms
	(seat_no,is_empty)
    VALUES
    (1,'N'),
	(2,'Y'),
	(3,'N'),
	(4,'Y'),
	(5,'Y'),
	(6,'Y'),
	(7,'N'),
	(8,'Y'),
	(9,'Y'),
	(10,'Y'),
	(11,'Y'),
	(12,'N'),
	(13,'Y'),
	(14,'Y');
    
-- 1.  Find the seats where 3 or more consecutive seats are empty


-- a) Basic Lead Lag

SELECT 
	*
FROM 
	bms;
    
SELECT
	seat_no
FROM 
	(
	SELECT
		*,
        LAG(is_empty,2) OVER (ORDER BY seat_no) AS last_2_last_is_empty,
        LAG(is_empty,1) OVER (ORDER BY seat_no) AS last_is_empty,
		LEAD(is_empty,1) OVER (ORDER BY seat_no) AS next_is_empty,
		LEAD(is_empty,2) OVER (ORDER BY seat_no) AS next_2_next_is_empty
	FROM
		bms
	) AS a
WHERE
	(is_empty="Y" AND next_is_empty = "Y" AND next_2_next_is_empty = "Y") -- All two down including Self
    OR
    (is_empty="Y" AND last_is_empty = "Y" AND last_2_last_is_empty = "Y") -- All two Up including Self
    OR
     (is_empty="Y" AND last_is_empty = "Y" AND next_is_empty = "Y") -- One Down and One Up including Self
ORDER BY
	seat_no;	
    
-- b) Advanced Lead Lag

SELECT 
	seat_no
FROM 
	(
	SELECT
			*,
			SUM(CASE WHEN is_empty='Y' THEN 1 ELSE 0 END) OVER (ORDER BY seat_no ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS last_2_and_present,
			SUM(CASE WHEN is_empty='Y' THEN 1 ELSE 0 END) OVER (ORDER BY seat_no ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS last_1_and_next_1,
			SUM(CASE WHEN is_empty='Y' THEN 1 ELSE 0 END) OVER (ORDER BY seat_no ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS next_2_and_present
		FROM
			bms
	) AS a
WHERE 
	last_2_and_present=3 OR
    last_1_and_next_1=3 OR
    next_2_and_present=3;

-- Qualify the Differences between the value and the rank incase Counts of the Difference Exceeds 3
WITH cte AS
	(
	SELECT 
		*,
		RANK() OVER(ORDER BY seat_no) AS rn,
		seat_no-RANK() OVER(ORDER BY seat_no) AS diff
	FROM 
		bms
	WHERE
		is_empty="Y"
	)
SELECT 
	seat_no
FROM 
	CTE as m
    INNER JOIN
    (
		SELECT 
			diff
		FROM 
			cte
		GROUP BY 
			diff
		HAVING
			COUNT(diff)>=3) AS s
WHERE s.diff=m.diff;
