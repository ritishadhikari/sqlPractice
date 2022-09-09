USE org;
-- 1. Create table airbnb_searches
CREATE TABLE airbnb_searches
	(
		user_id INT, 
        date_searched DATE,
        filter_room_types VARCHAR (200)
    );

-- 2. Delete any existing records from airbnb_searches
DELETE FROM 
	airbnb_searches;

-- 3. Insert new records into airbnb_searches
INSERT INTO airbnb_searches
	(
		user_id, date_searched, filter_room_types
    )
    VALUES
		(1,'2022-01-01','entire home,private room'),
        (2,'2022-01-02','entire home,shared room'),
        (3,'2022-01-02','private room,shared room'),
        (4,'2022-01-03','private room');
        
/* 4. Find the room types that are searched most number of times
Output the room type along side the number of searches for it
If the filter for room types has more than one room type, 
consider each unique room as a separate row
Sort the result based on the number of searches in descending order.
*/

