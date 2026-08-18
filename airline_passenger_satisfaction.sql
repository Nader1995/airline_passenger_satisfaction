CREATE DATABASE airline_passenger_satisfaction;
USE airline_passenger_satisfaction;

SHOW DATABASES;
SELECT DATABASE();

# Phase 0: Understanding the table

SHOW TABLES;
DESCRIBE test;

SELECT *
FROM test t 
LIMIT 10;

SELECT COUNT(*)
FROM test t;

SELECT t.satisfaction, COUNT(*)
FROM test t 	
GROUP BY t.satisfaction;

SELECT t.gender, COUNT(*)
FROM test t 
GROUP BY t.Gender ;

SELECT t.satisfaction AS 'Female Satisfaction', COUNT(*)
FROM test t
WHERE t.gender = 'Female'
GROUP BY t.satisfaction ;

SELECT t.satisfaction AS 'Male Satisfaction', COUNT(*)
FROM test t
WHERE t.gender = 'Male'
GROUP BY t.satisfaction ;

SELECT t.`Type of Travel` , t.satisfaction, COUNT(*)
FROM test t
GROUP BY t.`Type of Travel`, t.satisfaction  ;



