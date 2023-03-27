USE org;

CREATE TABLE 
	input
    (
		id INT,
        formula VARCHAR(10),
        value INT
    );
    
INSERT INTO
	input
    (id,formula,value)
	values
    (1,'1+4',10),
    (2,'2+1',5),
    (3,'3-2',40),
    (4,'4-1',20);
    
SELECT 
	*
FROM 
	input;

WITH cte AS
	(
		SELECT
			*,
			SUBSTR(formula,1,1) AS l,
			SUBSTR(formula,2,1) AS operator,
			SUBSTR(formula,3,1) AS r
		FROM 
			input
	)
SELECT 
	cte.id,
    cte.formula,
    cte.operator,
    cte.value,
    a.value AS val1,
	b.value AS val2,
    CASE WHEN cte.operator="-" THEN a.value-b.value ELSE a.value+b.value END AS result
FROM 
	cte
INNER JOIN 
	input AS a
ON 
	cte.l=a.id
INNER JOIN
	input AS b
ON 	
	cte.r=b.id;
    
SELECT 
	*
FROM 
	input;

WITH cte AS
	(
		SELECT
			*,
			SUBSTR(formula,1,1) AS l,
			SUBSTR(formula,2,1) AS operator,
			SUBSTR(formula,3,1) AS r
		FROM 
			input
	)
SELECT 
	cte.id,
	cte.value,
    cte.formula,
	cte.operator,
    -- a.value, 
    CASE WHEN cte.operator="+" THEN cte.value+a.value ELSE cte.value-a.value END AS result
FROM 
	cte
INNER JOIN
	input AS a
ON 
	cte.r=a.id
ORDER BY 
	cte.id;