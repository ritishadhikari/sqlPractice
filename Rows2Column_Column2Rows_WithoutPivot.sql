USE org;

CREATE TABLE emp_compensation
	(
		emp_id INT,
        salary_component_type VARCHAR(20),
        val INT
    );

INSERT INTO 
	emp_compensation
    (emp_id, salary_component_type, val)
VALUES
	(1,"salary",10000),
    (1,"bonus",5000),
    (1,"hike_percent",10),
    (2,'salary',15000),
    (2,'bonus',7000),
    (2,'hike_percent',8), 
    (3,'salary',12000),
    (3,'bonus',6000),
    (3,'hike_percent',7);

-- Pivoting
SELECT 
	*
FROM 
	emp_compensation;
    
SELECT
	emp_id,
    SUM(CASE WHEN salary_component_type="salary" THEN val ELSE NULL END) AS salary,
    SUM(CASE WHEN salary_component_type="bonus" THEN val ELSE NULL END) AS bonus,
    SUM(CASE WHEN salary_component_type="hike_percent" THEN val ELSE NULL END) AS hike_percent
FROM 
	emp_compensation
GROUP BY
	emp_id;

-- UnPivoting
WITH cte AS
	(
	SELECT
		emp_id,
		SUM(CASE WHEN salary_component_type="salary" THEN val ELSE NULL END) AS salary,
		SUM(CASE WHEN salary_component_type="bonus" THEN val ELSE NULL END) AS bonus,
		SUM(CASE WHEN salary_component_type="hike_percent" THEN val ELSE NULL END) AS hike_percent
	FROM 
		emp_compensation
	GROUP BY
		emp_id
        ),
	-- will unpivot the above cte1
	cte2 AS
		(
		SELECT
			emp_id, 
			"salary" AS salary_component_type,
			salary AS val
		FROM 
			cte
		UNION ALL
		SELECT
			emp_id, 
			"bonus" AS salary_component_type,
			bonus AS val
		FROM 
			cte
		UNION ALL
		SELECT
			emp_id, 
			"hike_percent" AS salary_component_type,
			hike_percent AS val
		FROM 
			cte
            )
		SELECT 
			*
		FROM 
			cte2
		ORDER BY
			emp_id;