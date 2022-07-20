USE org;

-- 1. CREATE TABLE strings 

CREATE TABLE strings
	(
		name VARCHAR(50)
    );

-- 2. INSERT INTO STRINGS

INSERT INTO
	strings
    (name)
	VALUES
     ('Ankit Bansal'),
     ('Ram Kumar Verma'),
     ('Akshay Kumar Ak k'),
     ('Rahul');
     
-- 3. Count Number of Occurrences of a Space String
SELECT 
	name
FROM 
	strings;
    
SELECT
	name,
	replace(name," ","") AS rep_name,
    length(name)-length(replace(name," ","")) AS count_of_space
FROM 
	strings;
    
-- 4. Count Number of Occurrences of a Words in a String
SELECT
	name,
	replace(name,"Ak","") AS rep_name,
    CAST((length(name)-length(replace(name,"Ak","")))/length("Ak") AS SIGNED) AS count_of_Ak
FROM 
	strings;