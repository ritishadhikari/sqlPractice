USE org;

-- 1. Create Table brands:
CREATE TABLE brands
	(
     category VARCHAR(20),
     brand_name VARCHAR(20)
    );

-- 2. Insert into brands:

INSERT INTO brands
	(category, brand_name)
VALUES
	('chocolates','5-star'),
    (null,'dairy milk'),
    (null,'perk'),
    (null,'eclair'),
    ('Biscuits','britannia'),
    (null,'good day'),
    (null,'boost');
    
SELECT
	*
FROM 
	brands;

-- 3. Write a SQL to Populate category values to the last not null value
WITH cte AS
	(
		SELECT
			*,
			ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as rnk  -- Order By is populated in the sequence as per the records
		FROM 
			brands
	)

SELECT
	CASE WHEN (c2.category IS NULL) THEN c1.category ELSE c1.category END AS category,
	c2.brand_name
FROM
	(    
	SELECT 
		*,
		LEAD (rnk,1,(SELECT COUNT(*)+1 FROM CTE)) OVER (ORDER BY rnk) -1 AS next_rank
	FROM 
		cte 
	WHERE category IS NOT NULL
	) AS c1
	INNER JOIN
	cte AS c2
ON 
	c1.rnk<=c2.rnk 
AND 
	c1.next_rank>=c2.rnk

        

