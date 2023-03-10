USE org;

SELECT 
	*
FROM 
	airbnb_searches;

WITH cte 
	AS (
		SELECT
			substring_index(filter_room_types,',',1) AS room_type
		FROM 
			airbnb_searches
		UNION ALL
		SELECT
			substring_index(filter_room_types,',',-1) AS room_type
		FROM 
			airbnb_searches
		WHERE
		filter_room_types like '%,%'
        )
SELECT 
	room_type,
    COUNT(room_type) as appearances
FROM 
	cte
GROUP BY
	room_type
ORDER BY 
	appearances;
	