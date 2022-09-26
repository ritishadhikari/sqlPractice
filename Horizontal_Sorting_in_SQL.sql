USE org;

CREATE TABLE subscriber
	(
		sms_date DATE,
        sender VARCHAR(20),
        receiver VARCHAR(20),
        sms_no INT
    );
    
INSERT INTO subscriber
	(sms_date, sender, receiver, sms_no)
    VALUES
		('2020-4-1', 'Avinash', 'Vibhor',10),
        ('2020-4-1', 'Vibhor', 'Avinash',20),
        ('2020-4-1', 'Avinash', 'Pawan',30),
		('2020-4-1', 'Pawan', 'Avinash',20),
        ('2020-4-1', 'Vibhor', 'Pawan',5),
        ('2020-4-1', 'Pawan', 'Vibhor',8),
        ('2020-4-1', 'Vibhor', 'Deepak',50);
        
SELECT 
	*
FROM 
	subscriber;
    
-- Find total number of messages exchanged between each person per day
WITH cte AS
(
	SELECT 
		*,
		CASE WHEN sender>=receiver THEN receiver ELSE sender END AS person1,
		CASE WHEN sender>receiver THEN sender ELSE receiver END AS person2
	FROM 
		subscriber
)

SELECT
	sms_date,
	person1,
    person2,
    SUM(sms_no) AS total_sms
FROM 
	cte
GROUP BY
	sms_date,
	person1,
	person2;