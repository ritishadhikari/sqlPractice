USE org;

CREATE TABLE drivers
	(
		id VARCHAR(10),
        start_time TIME,
        end_time TIME,
        start_loc VARCHAR(10),
        end_loc VARCHAR(10)
    );
    
INSERT INTO drivers
	VALUES
		('dri_1', '09:00', '09:30', 'a','b'),
        ('dri_1', '09:30', '10:30', 'b','c'),
        ('dri_1','11:00','11:30', 'd','e'),
        ('dri_1', '12:00', '12:30', 'f','g'),
        ('dri_1', '13:30', '14:30', 'c','h'),
        ('dri_2', '12:15', '12:30', 'f','g'),
        ('dri_2', '13:30', '14:30', 'c','h');

SELECT 
	*
FROM 
	drivers;
    
/*
	Write a Query to print total rides and profit rides for each
    driver 
    Profit ride is when the end location of current ride is same
    as start location on next ride
*/
	
-- Method 1 - Using Lead
WITH cte AS
	(
		SELECT
			*,
			LEAD(start_loc,1) OVER (PARTITION BY id ORDER BY start_time) AS prev_start_loc
		FROM
			drivers
	)
SELECT 
	id,
    COUNT(id) AS total_rides,
    SUM(CASE WHEN end_loc=prev_start_loc THEN 1 ELSE NULL END) AS profit_rides
FROM
	cte
GROUP BY 
	id;
    
-- Method 2
WITH cte AS
	(
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY id ORDER BY start_time) AS rowNum
	FROM
		drivers
	)
SELECT 
	-- a.*,
	-- b.*
	a.id,
	COUNT(a.id) AS total_rides,
	COUNT(b.id) AS profit_rides
FROM 
	cte AS a
LEFT JOIN
	cte as b
ON 
	a.id=b.id
AND	
	a.end_loc=b.start_loc
AND 
	a.rowNum+1=b.rowNum
GROUP BY
	a.id;
	
	
        

