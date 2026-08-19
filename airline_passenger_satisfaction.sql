
# Create the database, use and select it

CREATE DATABASE airline_passenger_satisfaction;
USE airline_passenger_satisfaction;

SHOW DATABASES;
SELECT DATABASE();

# Phase 0: Understanding the table

DESCRIBE test;

/* 
 * 		id: 									int
 * 		Gender:									varchar(50)			male and female, it can effect 
 * 																	disatisfaction if it comes to cleanness,
 * 																	food or drink
 * 		Customer Type:							varchar(50)
 * 		Age:									int
 * 		Type of Travel:							varchar(50)			business or normal, flight distance or
 * 																	departure/arrival delay can effect 
 * 																	disatisfaction
 * 		Class:									varchar(50)
 * 		Flight Distance:						int
 * 		Inflight wifi service:					int
 * 		Departure/Arrival time convenient:		int
 * 		Ease of Online booking:					int
 * 		Gate location:							int
 * 		Food and drink:							int
 * 		Online boarding:						int
 * 		Seat comfort:							int
 * 		Inflight entertainment:					int
 * 		On-board service:						int
 * 		Leg room service:						int
 * 		Baggage handling:						int
 * 		Checkin service:						int
 * 		Inflight service:						int
 * 		Cleanliness:							int
 * 		Departure Delay in Minutes:				int
 * 		Arrival Delay in Minutes:				double
 * 		
 * 		satisfaction:							varchar(50)			The exact factor showing satisfaction, but
 * 																	disatisfaction is mixed with being neutral
 * 																	so we can't distinguish between disatisfaction
 * 																	and just being lazy to vote.
 */

# There are in total 25,976 rows
SELECT COUNT(*)
FROM test t;

SELECT *
FROM test t 
LIMIT 10;

# Gender, customer type, type of travel, satisfaction and class percentages:

/* Result:
 * 
 * gender		num_gender		gender_percentage
 * ------		----------		-----------------
 * Female		13172			50.70835
 * Male			12804			49.29165
 * 
 * */

SELECT 
		t.gender,
		COUNT(*) AS num_gender,
		100.0 * COUNT(*)/(SELECT COUNT(*) FROM test) AS gender_percentage
FROM test AS t
GROUP BY t.gender;

/* Result:
 * 
 * customer type		num				percentage
 * -------------		-----     		----------
 * Loyal Customer		21177			81.52525
 * disloyal Customer	4799			18.47475
 * 		
 */

SELECT 
		t.`Customer Type`,
		COUNT(*) AS num_customer_type,
		100.0 * COUNT(*)/(SELECT COUNT(*) FROM test) AS customer_type_percentage
FROM test AS t
GROUP BY t.`Customer Type`;

/* Result:
 * 
 * type of travel 		num				percentage
 * -------------		-----     		----------
 * Business travel		18038			69.44102
 * Personal Travel		7938			30.55898
 * 
 */

SELECT 
		t.`Type of Travel`,
		COUNT(*) AS num_type_of_travel,
		100.0 * COUNT(*)/(SELECT COUNT(*) FROM test) AS type_of_travel_percentage
FROM test AS t
GROUP BY t.`Type of Travel`;

/* Result:
 * 
 * class				num				percentage
 * -----				-----     		----------
 * Eco					11564			44.51802
 * Business				12495			48.10209
 * Eco Plus				1917			7.37989
 * 
 */

SELECT 
		t.Class ,
		COUNT(*) AS num_class,
		100.0 * COUNT(*)/(SELECT COUNT(*) FROM test) AS class_percentage
FROM test AS t
GROUP BY t.class;

/* Result:
 * 
 * satisfaction 				num				percentage
 * ------------ 				-----     		----------
 * satisfied					11403			43.89821
 * neutral or dissatisfied		14573			56.10179
 * 		
 */

SELECT 
		t.satisfaction,
		COUNT(*) AS num_satisfaction,
		100.0 * COUNT(*)/(SELECT COUNT(*) FROM test) AS satisfaction_percentage
FROM test AS t
GROUP BY t.satisfaction;

# Passenger/trip characteristics:
# First Age, and flight distance:

/*
 	avg_age|flight_distance|
	-------+---------------+
	39.6210|      1193.7885|
 */

SELECT 
		AVG(Age) AS avg_age,
		AVG(`Flight Distance`) AS flight_distance
FROM test;

# Service ratings:
# Grouping ratings based on satisfaction:

/*

satisfaction           |clean |gate_loc|food_drink|online_boarding|
-----------------------+------+--------+----------+---------------+
satisfied              |3.7551|  2.9530|    3.5418|         4.0195|
neutral or dissatisfied|2.9194|  2.9960|    2.9599|         2.6687|

seat_comfort|inflight_enter|inflight_service|checkin_service|bag_hand|
------------+--------------+----------------+---------------+--------+	
      3.9660|        3.9613|          3.9770|         3.6607|  3.9690|
      3.0449|        2.8855|          3.3928|         3.0430|  3.3705|

wifi_service|leg_room_services|da_time_convenient|onboard_services|ease_of_booking|
------------+-----------------+------------------+----------------+---------------+
      3.1480|           3.8118|            2.9345|          3.8516|         3.0087|
      2.3935|           2.9890|            3.1347|          3.0211|         2.5597|

*/

SELECT
    satisfaction,
    AVG(Cleanliness) AS clean,
    AVG(`Gate location`) AS gate_loc,
    AVG(`Food and drink`) AS food_drink,
    AVG(`Online boarding`) AS online_boarding,
    AVG(`Seat comfort`) AS seat_comfort,
    AVG(`Inflight entertainment`) AS inflight_enter,
    AVG(`Inflight service`) AS inflight_service,
    AVG(`Checkin service`) AS checkin_service,
    AVG(`Baggage handling`) AS bag_hand,
    AVG(`Inflight wifi service`) AS wifi_service,
    AVG(`Leg room service`) AS leg_room_services,
    AVG(`Departure/Arrival time convenient`) AS da_time_convenient,
    AVG(`On-board service`) AS onboard_services,
    AVG(`Ease of Online booking`) AS ease_of_booking
FROM test
GROUP BY satisfaction; 

# Operational variables:
# Let's see how satisfaction reacts to delay:

/*
 	satisfaction           |departure_delay|arrival_delay     |
	-----------------------+---------------+------------------+
	satisfied              |        12.1216|12.150901891772987|
	neutral or dissatisfied|        16.0154| 16.76693281938326|
 */

SELECT  
		satisfaction,
		AVG(`Departure Delay in Minutes`) AS departure_delay,
		AVG(`Arrival Delay in Minutes`) AS arrival_delay
FROM test
GROUP BY satisfaction;
    
/*
 * Let's focus on 'online boarding' since it has the best satisfaction rate
 * and see if there is any correlation between it and satisfaction
 */

SELECT 
		t.satisfaction,
		COUNT(*)
FROM test t 
WHERE t.`Online boarding` = 5
GROUP BY satisfaction;

/*
 * Let's see how online boarding satisfaction changes with class, customer type, type of travel and gender
 */

























