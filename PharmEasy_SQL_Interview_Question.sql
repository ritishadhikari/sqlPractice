USE org;

-- 1. Create Table
CREATE TABLE movie
	(
		seat VARCHAR(50),
        occupancy INT
    );
    
-- 2. Insert into Table movie
INSERT INTO movie
	(seat,occupancy)
	VALUES
    ('a1',1),
    ('a2',1),
    ('a3',0),
    ('a4',0),
    ('a5',0),
    ('a6',0),
    ('a7',1),
    ('a8',1),
    ('a9',0),
    ('a10',0),
	('b1',0),
    ('b2',0),
    ('b3',0),
    ('b4',1),
    ('b5',1),
    ('b6',1),
    ('b7',1),
    ('b8',0),
    ('b9',0),
    ('b10',0),
	('c1',0),
    ('c2',1),
    ('c3',0),
    ('c4',1),
    ('c5',1),
    ('c6',0),
    ('c7',1),
    ('c8',0),
    ('c9',0),
    ('c10',1);

SELECT 
	*
FROM 
	movie;
    
-- 3. There are 3 rows in a movie hall each with 10 seats in each row. 
-- Write a SQL to find 4 consecutive empty seats.
WITH CTE AS
	(
	SELECT
		*,
		SUBSTR(seat,1,1) AS rowNumber,
		CAST(SUBSTRING(seat,2,2) as SIGNED) AS seatNumber
	FROM 
		movie
	)

SELECT 
	seat,
    occupancy
FROM (
	SELECT 
		*
	FROM
		(
		SELECT 
			*, 
			MAX(occupancy) OVER (PARTITION BY rowNumber ORDER BY seatNumber ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS status,
			MAX(seatNumber) OVER (PARTITION BY rowNumber) AS maxSeatForRow
		FROM 
			cte) AS B
		WHERE 
			seatNumber<maxSeatForRow-4) AS C
WHERE 
	status=0;



