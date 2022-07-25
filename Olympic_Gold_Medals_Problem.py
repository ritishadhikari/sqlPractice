USE org;

-- 1. Create Table Events
CREATE TABLE events
	(
		ID INT,
        event VARCHAR(255),
        year INT,
        gold VARCHAR(255),
        silver VARCHAR(255),
        bronze VARCHAR(255)
    );

-- 2. Insert Data into events Table

INSERT INTO events 
	(ID,event,year,gold,silver,bronze)
	VALUES
		(1,'100m',2016, 'Amthhew Mcgarray','donald','barbara'),
        (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith'),
        (3,'500m',2016, 'Charles','Nichole','Susana'),
		(4,'100m',2016, 'Ronald','maria','paula'),
		(5,'200m',2016, 'Alfred','carol','Steven'),
        (6,'500m',2016, 'Nichole','Alfred','Brandon'),
        (7,'100m',2016, 'Charles','Dennis','Susana'),
        (8,'200m',2016, 'Thomas','Dawn','catherine'),
        (9,'500m',2016, 'Thomas','Dennis','paula'),
        (10,'100m',2016, 'Charles','Dennis','Susana'),
        (11,'200m',2016, 'jessica','Donald','Stefeney'),
        (12,'500m',2016,'Thomas','Steven','Catherine');

SELECT * FROM events;
-- 3. Write a Query to find the number of gold medals per swimmer who won only gold medals
SELECT
	gold AS player_name,
	Count(*) as gold_count
FROM 
	events
WHERE
	gold NOT IN 
		(
			SELECT
				silver 
			FROM 
				events
			UNION ALL
            SELECT
				bronze 
			FROM 
				events
        )
GROUP BY
	gold;



        
    