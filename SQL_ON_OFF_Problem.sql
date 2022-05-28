-- 1. Create the Table
USE org;
CREATE TABLE
	event_status
    (
		event_time varchar(10),
        status varchar(10)
    );

-- 2. Insert Records into Data
INSERT INTO 
	event_status
    (
    event_time,
    status
    )
VALUES
	("10:01","on"),
    ('10:02','on'),
    ("10:03", 'on'),
    ("10:04", 'off'),
    ('10:07','on'),
    ('10:08','on'),
    ('10:09','off'),
    ('10:11','on'),
    ('10:12','off')
    ;

SELECT 
	*
FROM 
	event_status;
    
-- 3. Find the Count of ON before it is off
SELECT
	min(event_time) AS startTime,
    max(event_time) AS endTime,
    COUNT(cond)-1 AS TotalCount
FROM 
	(
	SELECT
		*,
		SUM(CASE WHEN status="on" AND LaggedTime="off" THEN 1 ELSE 0 END) OVER (ORDER BY event_time) AS COND
	FROM
	(SELECT
		*,
		LAG(status,1,status) OVER(ORDER BY event_time) as LaggedTime
	FROM 
		event_status) AS A
		) AS B
GROUP BY COND
    ;