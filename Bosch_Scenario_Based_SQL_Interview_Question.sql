USE org;

CREATE TABLE call_details
	(
		call_type VARCHAR(10),
        call_number VARCHAR(12),
        call_duration INT
	);
    
INSERT INTO call_details
	(call_type, call_number, call_duration)
	VALUES
		('OUT','181868',13),('OUT','2159010',8)
		,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
		,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
		,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
		,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

SELECT 
	*
FROM 
	call_details;

/*
Write a SQL to determine phone numbers that satisfy below conditions:
	1. The Number have both incoming and outgoing calls
    2. The sum of duration of outgoing calls must be greater than the sum of duration of 
		incoming calls
*/
-- 1. Ritish's method
WITH cte1 AS
	(
		SELECT
			call_number
		FROM 
			(
			SELECT 
				call_number,
				call_type,
				SUM(call_duration) AS total_call_duration
			FROM 
				call_details
			GROUP BY
				call_number,
				call_type
			HAVING
				call_type in ("INC","OUT")
			ORDER BY
				call_number
				) AS A
		GROUP BY
			call_number
		HAVING 
			COUNT(call_number)>1
	),
outgoingTable AS
	(
	SELECT 
		call_number, 
		SUM(call_duration) as outgoing_call_duration
	FROM 
		call_details
	WHERE
		call_type="OUT"
		AND
		call_number in 
			(SELECT
				call_number 
			FROM 
				cte1
			)
	GROUP BY
		call_number
	),
incomingTable AS
	(
	SELECT 
		call_number, 
		SUM(call_duration) as incoming_call_duration
	FROM 
		call_details
	WHERE
		call_type="INC"
		AND
		call_number in 
			(SELECT
				call_number 
			FROM 
				cte1
			)
	GROUP BY
		call_number
)
SELECT 
	incomingTable.call_number
FROM 
	incomingTable
INNER JOIN
	outgoingTable
ON 
	incomingTable.call_number=outgoingTable.call_number
WHERE 
	outgoingTable.outgoing_call_duration>incomingTable.incoming_call_duration;
	
-- 2. CTE and Filter Clause
WITH cte AS
	(
	SELECT 
		call_number,
		SUM(CASE WHEN call_type="OUT" THEN call_duration ELSE NULL END) AS outgoing_call_duration,
		SUM(CASE WHEN call_type="INC" THEN call_duration ELSE NULL END) AS incoming_call_duration
	FROM 
		call_details
	GROUP BY
		call_number
	)
SELECT 
	call_number
FROM 
	cte
WHERE 
	cte.outgoing_call_duration IS NOT NULL  # not mandatory to mention
    AND 
    cte.incoming_call_duration IS NOT NULL	# not mandatory to mention
    AND
	cte.outgoing_call_duration>cte.incoming_call_duration;

-- 3. Using Having Clause
SELECT 
		call_number
		-- SUM(CASE WHEN call_type="OUT" THEN call_duration ELSE NULL END) AS outgoing_call_duration,
-- 		SUM(CASE WHEN call_type="INC" THEN call_duration ELSE NULL END) AS incoming_call_duration
FROM 
	call_details
GROUP BY
	call_number
HAVING
	SUM(CASE WHEN call_type="OUT" THEN call_duration ELSE NULL END) IS NOT NULL 
    AND
    SUM(CASE WHEN call_type="INC" THEN call_duration ELSE NULL END) IS NOT NULL 
    AND
	SUM(CASE WHEN call_type="OUT" THEN call_duration ELSE NULL END)>SUM(CASE WHEN call_type="INC" THEN call_duration ELSE NULL END);

-- 4. Using CTEs and Joins
WITH outgoingCTE as 
	(
	SELECT 
			call_number,
			SUM(call_duration) AS outgoing_call_duration
	FROM 
		call_details
	WHERE 
		call_type="OUT"
	GROUP BY
		call_number
	),
	incomingCTE as 
	(
	SELECT 
			call_number,
			SUM(call_duration) AS incoming_call_duration
	FROM 
		call_details
	WHERE 
		call_type="INC"
	GROUP BY
		call_number
	)

SELECT
	outgoingCTE.call_number
FROM 
	outgoingCTE
INNER JOIN
	incomingCTE
ON 
	outgoingCTE.call_number=incomingCTE.call_number
	AND 
    outgoingCTE.outgoing_call_duration>incomingCTE.incoming_call_duration;