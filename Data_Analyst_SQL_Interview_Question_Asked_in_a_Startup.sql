USE org;
CREATE 
TABLE
	call_start_logs
    (
		phone_number VARCHAR(10),
        start_time DATETIME
    );
		
INSERT 
	INTO call_start_logs
    VALUES
		('PN1','2022-01-01 10:20:00'),
		('PN1','2022-01-01 16:25:00'),
		('PN2','2022-01-01 12:30:00'),
		('PN3','2022-01-02 10:00:00'),
		('PN3','2022-01-02 12:30:00'),
		('PN3','2022-01-03 09:20:00');
	
CREATE 
TABLE
	call_end_logs
    (
		phone_number VARCHAR(10),
        end_time DATETIME
    );
    
INSERT 
	INTO call_end_logs
    VALUES
		('PN1','2022-01-01 10:45:00'),
        ('PN1','2022-01-01 17:05:00'),
        ('PN2','2022-01-01 12:55:00'),
        ('PN3','2022-01-02 10:20:00'),
        ('PN3','2022-01-02 12:50:00'),
        ('PN3','2022-01-03 09:40:00');

/*
Write a query to get start time and end time of each call from 2 tables. Also create a 
column of call duration in minutes. Please do take into account that there will be
multiple calls from one phone number and each entry in start table has a corresponding
entry in end table
*/ 

-- ROW NUMBER AND JOIN
WITH 
	CTE1 AS
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_time) AS start_rank
		FROM 
			call_start_logs
	),
	CTE2 AS
		(
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY end_time) AS end_rank
		FROM 
			call_end_logs
	)
    
SELECT 
    cte1.phone_number,
    cte1.start_time,
    cte2.end_time,
    TIMESTAMPDIFF(MINUTE,start_time,end_time) AS duration
FROM
	cte1
INNER JOIN
	cte2
ON 
	cte1.start_rank=cte2.end_rank
AND 
	cte1.phone_number=cte2.phone_number;
    

-- ROW NUMBER AND UNION 
WITH 
	CTE1 AS
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_time) AS call_rank
		FROM 
			call_start_logs
	),
	CTE2 AS
		(
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY end_time) AS call_rank
		FROM 
			call_end_logs
	),
    CTE3 AS
		(
		SELECT
			phone_number,
            start_time as call_time,
            call_rank
		FROM 
			CTE1
		UNION 
		SELECT 
			*
		FROM 
			CTE2
		)


SELECT 
	phone_number,
    TIMESTAMPDIFF(MINUTE,MIN(call_time),MAX(call_time)) as duration
FROM
	cte3
GROUP BY
	phone_number,
    call_rank;





