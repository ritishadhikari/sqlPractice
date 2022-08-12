USE org;
-- 1. Create Table 
CREATE TABLE phonelog
	(
		callerid INT,
        recipientid INT, 
        datecalled DATETIME
    );
    
-- 2. Insert Into Table phonelog
INSERT INTO phonelog 
(callerid,recipientid,datecalled)
VALUES
(1, 2, '2019-01-01 09:00:00.000'),
(1, 3, '2019-01-01 17:00:00.000'),
(1, 4, '2019-01-01 23:00:00.000'),
(2, 5, '2019-07-05 09:00:00.000'),
(2, 3, '2019-07-05 17:00:00.000'),
(2, 3, '2019-07-05 17:20:00.000'),
(2, 5, '2019-07-05 23:00:00.000'),
(2, 3, '2019-08-01 09:00:00.000'),
(2, 3, '2019-08-01 17:00:00.000'),
(2, 5, '2019-08-01 19:30:00.000'),
(2, 4, '2019-08-02 09:00:00.000'),
(2, 5, '2019-08-02 10:00:00.000'),
(2, 5, '2019-08-02 10:45:00.000'),
(2, 4, '2019-08-02 11:00:00.000');

-- 3. There is a PhoneLog Table that has information about callers' call history. Write a SQL to find out callers whose first
-- and last call was to the same person on a given day

WITH cte AS (
	SELECT
		callerid,
		date(datecalled) AS date,
		min(datecalled) AS earliest_called_time,
		max(datecalled) AS latest_called_time
	FROM
		phonelog
	GROUP BY
		date(datecalled)
        ) 

SELECT 
	*
FROM 
	(        
	SELECT
		b.datecalled,
		a.callerid AS caller,
		-- a.earliest_called_time,
		b.recipientid AS first_recipient,
		-- a.latest_called_time,
		c.recipientid AS last_recipient
	FROM 
		CTE AS a
		INNER JOIN
		phonelog AS b
		ON
			a.callerid=a.callerid
			AND
			a.earliest_called_time=b.datecalled
		INNER JOIN
		phonelog AS c
		ON 
			a.callerid=c.callerid
			AND
			a.latest_called_time=c.datecalled
		) AS d
WHERE d.first_recipient=d.last_recipient;