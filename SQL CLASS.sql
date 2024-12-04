SELECT * FROM uptraxtech_ltd.student_demographics;

SELECT * # THIS IS A SELECT STATEMENT THAT RETURNS EVERYTHING ON A TABLE. 
FROM student_demographics; 


-- THIS IS TO QUERY FROM A DATABASE AND THE TABLE
SELECT * FROM uptraxtech_ltd.student_demographics;

-- SELECTING MULTIPLE COLUMNS
SELECT first_name, last_name, gender
FROM student_demographics;

-- SELECT FROM STUDENT_FEE
SELECT * FROM student_fee;

SELECT first_name, last_name,course
FROM student_fee;  

# GROUP BY - AGGREGATE FUNCTION
-- WHERE STATEMENT
-- HAVING VS LIKE 
-- ORDER BY 

-- GROUP BY STATEMENT
-- GROUP BY STATEMENT WORKS WITH THE AGGREGATE FUNCTIONS( SUM, MIN,MAX,COUNT,AVERAGE)
SELECT gender, COUNT(gender), max(age),min(age),avg(age)
FROM student_demographics
GROUP BY gender;

-- DISTINCT STATEMENT
-- THIS WILL SHOW THE UNIQUE ITEM IN A COLUMN
SELECT DISTINCT (gender)
FROM student_demographics;

SELECT DISTINCT (course)
FROM student_fee;


-- ALIAS(AS STATEMENT)
SELECT first_name, last_name AS Other_name
FROM student_demographics;

SELECT gender,COUNT(gender) AS Gender_count
FROM student_demographics
GROUP BY gender;

SELECT gender,COUNT(gender)  Gender_Total
FROM student_demographics
GROUP BY gender;

-- ORDER BY
-- USED FOR SORTING EITHER ALPHABETICALLY OR NUMERICALLY
SELECT * 
FROM student_demographics
ORDER BY age DESC;

SELECT *
FROM student_fee;

-- WHERE STATEMENT
SELECT first_name,last_name,age
FROM student_demographics
WHERE age = 30;

-- WHERE STATEMENT
-- HAVING AND LIKE STATEMENT
-- JOINS

SELECT *
FROM student_fee;

SELECT first_name, last_name,fee
FROM student_fee
WHERE fee >=70000;

SELECT *
FROM student_demographics;

-- QUERY TO DISPLAY GENDER=FEMALE AND AGE<30
SELECT first_name, last_name,gender,age
FROM student_demographics
WHERE gender='female' AND age<30;

SELECT first_name, last_name,gender,age
FROM student_demographics
WHERE gender='female' AND NOT age<30;

-- HAVING STATEMENT 
SELECT first_name, last_name,gender,age
FROM student_demographics
HAVING age<30;


SELECT first_name,last_name,course
FROM student_fee
HAVING course LIKE "%cyb%";

-- JOINS 
-- THIS IS USED TO JOIN TWO OR TABLES
-- ONLY HAPPENS WHEN THERE IS A PRIMARY KEY

-- EXAMPLE WE WANT TO JOIN THE STUDENT_FEE TABLE WITH THE STUDENT_DEMOGRAPHICS TABLE
SELECT *
FROM student_demographics
INNER JOIN student_fee
	ON student_demographics.first_name = student_fee.first_name;
    
SELECT *
FROM student_demographics AS dem
INNER JOIN student_fee AS fee
	ON dem.first_name = fee.first_name; 
    
SELECT dem.student_id,fee.first_name,dem.last_name,age,gender,birth_date,course,fee,department_id
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
    
    -- OUTER JOIN 
    -- THERE IS THE LEFT AND RIGHT OUTER JOIN  

SELECT *
FROM student_demographics AS dem
RIGHT JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
    
SELECT *
FROM student_demographics AS dem
 JOIN student_fee AS fee 
	ON dem.first_name = fee.first_name;

-- UNION
-- STRINGS FUNCTIONS
-- CASE FUNCTIONS 

SELECT dem.student_id,fee.first_name,dem.last_name,age,gender,birth_date,course,fee,department_id
FROM student_demographics AS dem
 JOIN student_fee AS fee 
	ON dem.first_name = fee.first_name
    WHERE age<30;
    
SELECT *
FROM student_demographics AS dem
RIGHT JOIN student_fee AS fee
	ON dem.first_name = fee.first_name 
RIGHT JOIN course_applied 
	ON department_id = dept_id
ORDER BY dept_id;
    
    SELECT  *
    FROM course_applied;


-- UNION 
SELECT first_name,last_name
FROM student_demographics
UNION
SELECT gender,age
FROM student_demographics;

SELECT first_name,last_name
FROM student_demographics
UNION
SELECT fee,course
FROM student_fee;

-- STRINGS FUNCTIONS
-- THIS ARE TEXT FUNCTIONS
SELECT *
FROM student_demographics;

-- UPPER AND LOWER
SELECT LOWER('EMMANUEL');

SELECT first_name,UPPER(first_name)
FROM student_demographics;

-- CONCATENATE
-- TO JOIN TWO OR MORE COLUMNS TOGETHER
SELECT first_name,last_name, CONCAT(first_name,' ',last_name) AS full_name
FROM student_demographics;

-- TRIM
-- THIS IS USED TO REMOVE EMPTY SPACES BETWEEN TEXT 
SELECT ('             UPTRAX             ');

-- LEFT TRIM 
-- THE LEFT TRIM REMOVES SPACE FROM THE LEFT SIDE OF THE TEXT
SELECT TRIM('             UPTRAX             ');

-- RIGHT AND LEFT 
SELECT birth_date,
LEFT(birth_date,4),
RIGHT(birth_date,2)
FROM student_demographics;

-- SUBSTRING
-- THIS ENABLES YOU TO PICK A CHARACTER FROM A TEXT RANGE 
SELECT birth_date,
LEFT(birth_date,4) birth_year,
RIGHT(birth_date,2) birth_day,
substring(birth_date,6,2) birth_month
FROM student_demographics;

-- COMMON TABLE EXPRESSION(CTE) 
-- CASE FUNCTIONS
-- THIS ENABLES US TO USE LOGIC TO QUERY A DATABASE
SELECT first_name,age,
CASE
WHEN age <30 THEN 'YOUNG'
WHEN age >=30 THEN 'ADULT'
END AS AGE_GROUP
FROM student_demographics;

SELECT first_name,age,
CASE
WHEN age BETWEEN 20 AND 25 THEN 'YOUNG'
WHEN age BETWEEN 26 AND 30 THEN 'ADULT'
WHEN age BETWEEN 31 AND 35 THEN 'OLD'
WHEN age >35 THEN 'SENIORS'
END AS AGE_BRACKET
FROM student_demographics;

SELECT *
FROM student_demographics;

SELECT first_name,last_name,age,birth_date,CONCAT(first_name,' ',last_name) AS full_name,
CASE
WHEN birth_date BETWEEN '1980-01-01' AND '1990-12-31' THEN ' BABY BOOMERS'
WHEN birth_date BETWEEN '1991-01-01' AND '1999-12-31' THEN 'MILLENIALS'
WHEN birth_date BETWEEN '2000-01-01' AND '2010-12-31' THEN 'GEN Z'
END AS AGE_CATEGORY
FROM student_demographics
ORDER BY AGE_CATEGORY;


--  COMMON TABLE EXPRESSION CTE
-- A CTE IN SQL IS A TEMPOARY RESULT SET THAT YOU CAN REFERENCE WITHIN A SELECT,INSERT,UPDATE,OR DELETE STATEMENT
-- IT IS DEFINED USING THE WITH KEYWORD AND HELPS MAKE COMPLEX QUERIES MORE READABLE AND MAINTAINABLE

SELECT gender,avg(age),min(age),max(age),sum(fee),avg(fee),min(fee),max(fee)
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name
GROUP BY gender;

-- CTE EXAMPLE
WITH CTE AS
(SELECT gender,avg(age) AS avg_age,min(age),max(age),sum(fee),avg(fee),min(fee),max(fee)
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name
GROUP BY gender)
SELECT gender, avg_age
FROM CTE;


-- DATA CLEANING IN SQL 

-- CHECKING FOR MISSING VALUES (NULLS)
-- Identifying rows with missing values in specific columns
SELECT *
FROM student_demographics 
WHERE first_name IS NULL;


-- Identifying rows with missing values in any columns 
SELECT *
FROM student_demographics 
WHERE first_name IS NULL OR last_name IS NULL OR gender IS NULL;

SELECT * FROM student_fee;

-- Count Missing Values 
SELECT COUNT(*) AS missing_count
FROM student_demographics
WHERE first_name IS NULL;

# Removing or Replacing Missing Values
DELETE FROM student_demographics
WHERE first_name IS NULL;

-- Replacing Missing Values Using COALESCE()
SELECT first_name, 
COALESCE(first_name, 'Unknown') AS cleaned_column
FROM student_demographics;

-- Replace missing values with the column mean (numerical data)
UPDATE student_fee
SET fee = (
	SELECT avg_fee 
    FROM 
	(SELECT AVG(fee) AS avg_fee
    FROM student_fee
    WHERE fee IS NOT NULL) AS temp_avg
)
WHERE fee IS NULL;

-- CHATGPT: Since MySQL doesn't allow directly referencing the target table (student_fee) in a subquery when updating it.
--  To fix this, you can use a temporary table or a common table expression 
-- (CTE) to first calculate the average and then perform the update.
UPDATE student_fee
SET fee = (SELECT avg_fee FROM (SELECT AVG(fee) AS avg_fee FROM student_fee WHERE fee IS NOT NULL) AS temp_avg)
WHERE fee IS NULL;

WITH AvgFee AS (
    SELECT AVG(fee) AS avg_fee
    FROM student_fee
    WHERE fee IS NOT NULL
)
UPDATE student_fee
SET fee = (SELECT avg_fee FROM AvgFee)
WHERE fee IS NULL;



-- HOW TO HANDLE DUPLICATES 
-- To identify duplicates, you can use the GROUP BY and HAVING clauses to find rows with the same values.
SELECT first_name, last_name, COUNT(*)
FROM student_demographics
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;

-- Removing Duplicates

-- Method 1: Using DELETE with ROW_NUMBER() (Retain the First Occurrence)

CREATE TEMPORARY TABLE temp_table AS
SELECT *
FROM student_demographics
WHERE first_name IN (
    SELECT MIN(first_name)
    FROM student_demographics
    GROUP BY first_name, last_name
);
DELETE FROM student_demographics;
INSERT INTO student_demographics SELECT * FROM temp_table;
DROP TEMPORARY TABLE temp_table;


-- Verifying Removal
-- After deletion, run the duplicate-check query again to ensure all duplicates have been removed:

SELECT first_name, last_name, COUNT(*)
FROM student_demographics
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;



