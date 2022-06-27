USE org;
-- 1. Create the Table

CREATE TABLE business_city (
	business_date date,
    city_id int
);

-- 2. Insert Data Into Table

INSERT INTO business_city
	(business_date, city_id)
    VALUES
    (CAST("2020-01-02" AS DATE), 3),
    (CAST("2020-07-01" AS DATE),7),
    (CAST("2021-01-01" AS DATE),3),
    (CAST("2021-02-03" AS DATE),19),
    (CAST("2022-12-01" AS DATE),3),
    (CAST("2022-12-15" AS DATE),3),
    (CAST("2022-02-28" AS DATE),12);
    
SELECT
	*
FROM 
	business_city;
    
-- 3. Write a SQL to identify year wise count of new cities where Udaan started their operations
WITH 
	cte 
AS
	(
	SELECT 
		YEAR(business_date) AS busYear,
		city_id
	FROM 
		business_city)

SELECT
	busYear,
    (COUNT(DISTINCT(city_id))) AS TotalCitiesAdded
FROM 
	(
	SELECT 
		a.*,
		b.busYear AS earlierBusinessYear
	FROM
		cte AS a
		LEFT JOIN
		cte AS b
	ON 
		a.busYear>b.busYear
	AND 
		a.city_id=b.city_id
	) AS c
WHERE 
	earlierBusinessYear IS NULL
GROUP BY 
	busYear;
        
