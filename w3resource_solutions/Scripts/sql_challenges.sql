/*
w3resource SQL exercises

SQL Challenges (42 Challenges)
https://www.w3resource.com/sql-exercises/challenges-1/index.php
*/

-- 1. From the following tables, write a SQL query to find the information on each salesperson of ABC Company. Return name, city, country and state of each salesperson.
DROP TABLE IF EXISTS #salespersons -- remove temporary tables if exist
DROP TABLE IF EXISTS #address

CREATE TABLE #salespersons ( -- create salespersons and address temp tables
	salesperson_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
)
CREATE TABLE #address (
	address_id INT,
	salesperson_id INT,
	city VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50)
)

INSERT INTO #salespersons VALUES -- insert values into the temp tables
(1, 'Green', 'Wright'),
(2, 'Jones', 'Collins'),
(3, 'Bryant', 'Davis')
INSERT INTO #address VALUES 
(1, 2, 'Los Angeles', 'California', 'USA'),
(2, 3, 'Denver', 'Colorado', 'USA'),
(3, 4, 'Atlanta', 'Georgia', 'USA')

SELECT (sp.first_name + ' ' + sp.last_name) AS "Salesperson", -- solution to the question
		ad.city,
		ad.state       
FROM #salespersons sp
LEFT JOIN #address ad ON sp.salesperson_id = ad.salesperson_id;

-- 2. From the following table, write a SQL query to find the third highest sale. Return sale amount.
DROP TABLE IF EXISTS salemast -- remove temporary tables if exist

CREATE TABLE #salesmast ( -- create salespersons and address temp tables
	sale_id INT,
	employee_id INT,
	sale_date DATE,
	sale_amt INT
)

INSERT INTO #salesmast VALUES -- insert values into the temp tables
(1, 1000, '2012-03-08', 4500),
(2, 1001, '2012-03-09', 5500),
(3, 1003, '2012-04-10', 3500),
(3, 1003, '2012-04-10', 2500)

SELECT MAX(sale_amt) AS SecondHighestSale -- solution
FROM (SELECT sale_amt
	  FROM #salesmast
	  WHERE sale_amt <> (SELECT MAX(sale_amt)
						  FROM #salesmast)) a;

-- 3. From the following table, write a SQL query to find the Nth highest sale. Return sale amount. 
DECLARE @N AS INT
SET @N = 3;

WITH salesmast2 AS (
SELECT *
FROM #salesmast 
WHERE sale_amt <> (SELECT MIN(sale_amt)
				   FROM #salesmast)
)

SELECT sale_amt -- solution
FROM (SELECT sale_amt,
			 dense_rank() OVER (ORDER BY sale_amt DESC) AS rank
      FROM salesmast2) a
WHERE rank = @N;

-- 4. From the following table, write a SQL query to find the marks, which appear at least thrice one after another without interruption. Return the number. 
DROP TABLE IF EXISTS #logs -- remove temporary tables if exist
CREATE TABLE #logs ( -- create salespersons and address temp tables
	student_id INT,
	marks INT
)

INSERT INTO #logs VALUES -- insert values into the temp tables
(101, 83),
(102, 79),
(103, 83),
(104, 83),
(105, 83),
(106, 79),
(107, 79),
(108, 83)

SELECT * -- solution
FROM (#logs L1 
	  JOIN #logs L2 ON L1.marks = L2.marks 
					   AND L1.student_id = L2.student_id - 1)
JOIN #logs L3 ON L1.marks = L3.marks 
			     AND L2.student_id = L3.student_id - 1;

-- 5. From the following table, write a SQL query to find all the duplicate emails (no upper case letters) of the employees. Return email id.
DROP TABLE IF EXISTS #employees 
CREATE TABLE #employees (
	employee_id INT,
	employee_name VARCHAR(50),
	email_id VARCHAR(50)
)

INSERT INTO #employees VALUES
(101, 'Liam Alton', 'li.al@abc.com'),
(102, 'Josh Day', 'jo.da@abc.com'),
(103, 'Sean Mann', 'se.ma@abc.com'),
(104, 'Evan Blake', 'ev.bl@abc.com'),
(105, 'Toby Scott', 'jo.da@abc.com')

SELECT email_id -- solution
FROM #employees 
GROUP BY email_id
HAVING COUNT(email_id) >= 2;

-- 6. From the following tables, write a SQL query to find those customers who never ordered anything. Return customer name.
DROP TABLE IF EXISTS #customers
DROP TABLE IF EXISTS #orders

CREATE TABLE #customers (
	customer_id INT,
	customer_name VARCHAR(50)
)
CREATE TABLE #orders (
	order_id INT,
	customer_id VARCHAR(50),
	order_date DATE,
	order_amount INT
)

INSERT INTO #customers VALUES
(101, 'Liam'),
(102, 'Josh'),
(103, 'Sean'),
(104, 'Evan'),
(105, 'Toby')

INSERT INTO #orders VALUES
(401, 103, '2012-03-08', 4500),
(402, 101, '2012-09-15', 3650),
(403, 102, '2012-06-27', 4800)

SELECT cust.customer_name -- solution
FROM #customers cust
LEFT JOIN #orders ord ON cust.customer_id = ord.customer_id
WHERE ord.order_id IS NULL;

-- 7. From the following table, write a SQL query to remove all the duplicate emails of employees keeping the unique email with the lowest employee id. Return employee id and unique emails. 
-- Use the same table from Q5
WITH dup_email AS (
SELECT employee_id
FROM #employees
WHERE email_id IN (SELECT email_id
				   FROM #employees 
				   GROUP BY email_id
				   HAVING COUNT(email_id) >= 2) 
      AND employee_id <> (SELECT MIN(employee_id)
						  FROM #employees 
				          GROUP BY email_id
				          HAVING COUNT(email_id) >= 2)
)

SELECT * -- solution
FROM #employees
WHERE employee_id NOT IN (SELECT employee_id			
						  FROM dup_email);

-- 8. From the following table, write a SQL query to find all dates' city ID with higher pollution compared to its previous dates (yesterday). Return city ID, date and pollution. 
DROP TABLE IF EXISTS #so2_pollution

CREATE TABLE #so2_pollution (
	city_id INT,
	date DATE,
	so2_amt INT
)

INSERT INTO #so2_pollution VALUES
(701, '2015-10-15', 5),
(702, '2015-10-16', 7),
(703, '2015-10-17', 9),
(704, '2018-10-18', 15),
(705, '2015-10-19', 14)

WITH pre_day AS ( -- solution
SELECT *,
       DATEADD(DAY, -1, date) AS PreviousDay
FROM #so2_pollution
)

SELECT p2.city_id 
FROM #so2_pollution p1
JOIN pre_day p2 ON p1.DATE = p2.PreviousDay
WHERE p2.so2_amt > p1.so2_amt;

-- 9. A salesperson is a person whose job is to sell products or services. From the following tables, write a SQL query to find the top 10 salesperson that have made highest sale. Return their names and total sale amount.
DROP TABLE IF EXISTS #sales
DROP TABLE IF EXISTS #salesman

CREATE TABLE #sales (
	transaction_id INT NOT NULL,
	salesman_id INT NOT NULL,
	sale_amount INT,
	PRIMARY KEY(transaction_id)
)
CREATE TABLE #salesman (
	salesman_id INT NOT NULL,
	salesman_name VARCHAR(50),
	PRIMARY KEY(salesman_id)
)

INSERT INTO #sales VALUES
(501,18,5200.00),(502,50,5566.00),(503,38,8400.00),(504,43,8400.00),(505,11,9000.00),(506,42,5900.00), 
(507,13,7000.00),(508,33,6000.00),(509,41,8200.00),(510,11,4500.00),(511,51,10000.00),(512,29,9500.00),
(513,59,6500.00),(514,38,7800.00),(515,58,9800.00),(516,60,12000.00),(517,58,13900.00),(518,23,12200.00),
(519,34,5480.00),(520,35,8129.00),(521,49,9323.00),(522,46,8200.00),(523,47,9990.00),(524,42,14000.00),
(525,44,7890.00),(526,47,5990.00),(527,21,7770.00),(528,57,6645.00),(529,56,5125.00),(530,25,10990.00),
(531,21,12600.00),(532,41,5514.00),(533,17,15600.00),(534,44,15000.00),(535,12,17550.00),(536,55,13000.00),
(537,58,16800.00),(538,25,19900.00),(539,57,9990.00),(540,28,8900.00),(541,44,10200.00),(542,57,18000.00),
(543,34,16200.00),(544,36,19998.00),(545,30,13500.00),(546,37,15520.00),(547,36,20000.00),(548,20,19800.00),
(549,22,18530.00),(550,19,12523.00),(551,46,9885.00),(552,22,7100.00),(553,54,17500.00),(554,19,19600.00),
(555,24,17500.00),(556,38,7926.00),(557,49,7548.00),(558,15,9778.00),(559,56,19330.00),(560,24,14400.00),
(561,18,16700.00),(562,54,6420.00),(563,31,18720.00),(564,21,17220.00),(565,48,18880.00),(566,33,8882.00),
(567,44,19550.00),(568,22,14440.00),(569,53,19500.00),(570,30,5300.00),(571,30,10823.00),(572,35,13300.00),
(573,35,19100.00),(574,18,17525.00),(575,60,8995.00),(576,53,9990.00),(577,21,7660.00),(578,27,18990.00),
(579,11,18200.00),(580,30,12338.00),(581,37,11000.00),(582,27,11980.00),(583,18,12628.00),(584,52,11265.00),
(585,53,19990.00),(586,27,8125.00),(587,25,7128.00),(588,57,6760.00),(589,19,5985.00),(590,52,17641.00),
(591,53,11225.00),(592,22,12200.00),(593,59,16520.00),(594,35,19990.00),(595,42,19741.00),(596,19,15000.00),
(597,57,19625.00),(598,53,9825.00),(599,24,16745.00),(600,12,14900.00)

INSERT INTO #salesman VALUES
(11	,'Jonathan Goodwin'),(12,'Adam Hughes'),(13	,'Mark Davenport'),
(14	,'Jamie Shelley'),(15,'Ethan Birkenhead'),(16,'Liam Alton'),
(17,'Josh Day'),(18,'Sean Mann'),(19,'Evan Blake'),
(20	,'Rhys Emsworth'),(21,'Kian Wordsworth'),(22,'Frederick Kelsey'),
(23	,'Noah Turner'),(24	,'Callum Bing'),(25	,'Harri Wilberforce'),
(26	,'Gabriel Gibson'),(27	,'Richard York'),(28,'Tobias Stratford'),
(29	,'Will Kirby'),(30,'Bradley Wright'),(31,'Eli Willoughby'),
(32	,'Patrick Riley'),(33,'Kieran Freeman'),(34	,'Toby Scott'),
(35	,'Elliot Clapham'),(36	,'Lewis Moss'),(37	,'Joshua Atterton'),
(38	,'Jonathan Reynolds'),(39	,'David Hill'),(40	,'Aidan Yeardley'),
(41	,'Dan Astley'),(42,'Finlay Dalton'),(43,'Toby Rodney'),
(44	,'Ollie Wheatley'),(45,'Sean Spalding'),(46,'Jason Wilson'),
(47	,'Christopher Wentworth'),(48,'Cameron Ansley'),(49	,'Henry Porter'),
(50	,'Ezra Winterbourne'),(51,'Rufus Fleming'),(52,'Wallace Dempsey'),
(53	,'Dan McKee'),(54,'Marion Caldwell'),(55,'Morris Phillips'),
(56	,'Chester Chandler'),(57,'Cleveland Klein'),(58	,'Hubert Bean'),
(59	,'Cleveland Hart'),(60,'Marion Gregory')

SELECT TOP 10 sm.salesman_name, 
	   SUM(s.sale_amount) AS total_sale
FROM #salesman sm
JOIN #sales s ON sm.salesman_id = s.salesman_id
GROUP BY sm.salesman_name
ORDER BY SUM(s.sale_amount) DESC;

-- 10. An active customer is simply someone who has bought company's product once before and has returned to make another purchase within 10 days.
--     From the following table, write a SQL query to identify the active customers. Show the list of customer IDs of active customers. 
DROP TABLE IF EXISTS #orders

CREATE TABLE #orders (
	order_id INT,
	customer_id INT,
	item_desc VARCHAR(10),
	order_date DATE,
	PRIMARY KEY (order_id)
) 

INSERT INTO #orders VALUES
(101,2109,'juice','2020-03-03'),(102,2139,'chocolate','2019-03-18'),(103,2120,'juice','2019-03-18'),(104,2108,'cookies','2019-03-18'),
(105,2130,'juice','2020-03-28'),(106,2103,'cake','2019-03-29'),(107,2122,'cookies','2021-03-07'),(108,2125,'cake','2021-03-13'),
(109,2139,'cake','2019-03-30'),(110,2141,'cookies','2019-03-17'),(111,2116,'cake','2020-03-31'),(112,2128,'cake','2021-03-04'),
(113,2146,'chocolate','2021-03-04'),(114,2119,'cookies','2020-03-28'),(115,2142,'cake','2019-03-09'),(116,2122,'cake','2019-03-06'),
(117,2128,'chocolate','2019-03-24'),(118,2112,'cookies','2019-03-24'),(119,2149,'cookies','2020-03-29'),(120,2100,'cookies','2021-03-18'),
(121,2130,'juice','2021-03-16'),(122,2103,'juice','2019-03-31'),(123,2112,'cookies','2019-03-23'),(124,2102,'cake','2020-03-25'),
(125,2120,'chocolate','2020-03-21'),(126,2109,'cake','2019-03-22'),(127,2101,'juice','2021-03-01'),(128,2138,'juice','2019-03-19'),
(129,2100,'juice','2019-03-29'),(130,2129,'juice','2021-03-02'),(131,2123,'juice','2020-03-31'),(132,2104,'chocolate','2020-03-31'),
(133,2110,'cake','2021-03-13'),(134,2143,'cake','2019-03-27'),(135,2130,'juice','2019-03-12'),(136,2128,'juice','2020-03-28'),
(137,2133,'cookies','2019-03-21'),(138,2150,'cookies','2019-03-20'),(139,2120,'juice','2020-03-27'),(140,2109,'cake','2021-03-02'),
(141,2110,'cake','2021-03-13'),(142,2140,'juice','2019-03-09'),(143,2112,'cookies','2021-03-04'),(144,2117,'chocolate','2019-03-19'),
(145,2137,'cookies','2020-03-23'),(146,2130,'cake','2021-03-09'),(147,2133,'cake','2020-03-08'),(148,2143,'juice','2019-03-11'),
(149,2111,'chocolate','2020-03-23'),(150,2150,'cookies','2021-03-04'),(151,2131,'cake','2020-03-10'),(152,2140,'chocolate','2019-03-17'),
(153,2147,'cookies','2020-03-22'),(154,2119,'chocolate','2019-03-15'),(155,2116,'juice','2021-03-12'),(156,2141,'juice','2021-03-14'),
(157,2143,'cake','2019-03-16'),(158,2105,'cake','2020-03-21'),(159,2149,'chocolate','2019-03-11'),(160,2117,'cookies','2020-03-22'),
(161,2150,'cookies','2020-03-21'),(162,2134,'cake','2019-03-08'),(163,2133,'cookies','2019-03-26'),(164,2127,'juice','2019-03-27'),
(165,2101,'juice','2019-03-26'),(166,2137,'chocolate','2021-03-12'),(167,2113,'chocolate','2019-03-21'),(168,2141,'cake','2019-03-21'),
(169,2112,'chocolate','2021-03-14'),(170,2118,'juice','2020-03-30'),(171,2111,'juice','2019-03-19'),(172,2146,'chocolate','2021-03-13'),
(173,2148,'cookies','2021-03-14'),(174,2100,'cookies','2021-03-13'),(175,2105,'cookies','2019-03-05'),(176,2129,'juice','2021-03-02'),
(177,2121,'juice','2019-03-16'),(178,2117,'cake','2020-03-11'),(179,2133,'juice','2020-03-12'),(180,2124,'cake','2019-03-31'),
(181,2145,'cake','2021-03-07'),(182,2105,'cookies','2019-03-09'),(183,2131,'juice','2019-03-09'),(184,2114,'chocolate','2020-03-31'),
(185,2120,'juice','2021-03-06'),(186,2130,'juice','2021-03-06'),(187,2141,'chocolate','2019-03-11'),(188,2147,'cake','2021-03-14'),
(189,2118,'juice','2019-03-15'),(190,2136,'chocolate','2020-03-22'),(191,2132,'cake','2021-03-06'),(192,2137,'chocolate','2019-03-31'),
(193,2107,'cake','2021-03-01'),(194,2111,'chocolate','2019-03-18'),(195,2100,'cake','2019-03-07'),(196,2106,'juice','2020-03-21'),
(197,2114,'cookies','2019-03-25'),(198,2110,'cake','2019-03-27'),(199,2130,'juice','2019-03-16'),(200,2117,'cake','2021-03-10')

SELECT DISTINCT o1.customer_id      
FROM #orders o1
JOIN #orders o2 ON o1.customer_id = o2.customer_id
WHERE o1.order_id <> o2.order_id
      AND o2.order_date BETWEEN o1.order_date AND DATEADD(DAY, 10, o1.order_date);
	  
-- 11. From the following table, write a SQL query to convert negative numbers to positive and vice verse. Return the number.
DROP TABLE IF EXISTS #tablefortest

CREATE TABLE #tablefortest (
	srno INT,
	pos_neg_val INT,
	PRIMARY KEY (srno)
)

INSERT INTO #tablefortest VALUES 
(1, 56),
(2, -74),
(3, 15),
(4, -51),
(5, -9),
(6, 32)

SELECT *, -- solution
	   pos_neg_val * -1 AS converted_signed_value
FROM #tablefortest;

-- 12. From the following table, write a SQL query to find the century of a given date. Return the century.
DROP TABLE IF EXISTS #tablefortest

CREATE TABLE #tablefortest (
	ID INT,
	date_of_birth DATE,
	PRIMARY KEY (ID)
)

INSERT INTO #tablefortest VALUES
(1, '1907-08-15'),
(2, '1883-06-27'),
(3, '1900-01-01'),
(4, '1901-01-01'),
(5, '2005-09-01'),
(6, '1775-11-23'),
(7, '1800-01-01')

SELECT *, -- solution
	   LEFT(YEAR(date_of_birth), 2) + 1 AS century
FROM #tablefortest;


-- 13. From the following table, write a SQL query to find the even or odd values. Return "Even" for even number and "Odd" for odd number.
DROP TABLE IF EXISTS #tablefortest

CREATE TABLE #tablefortest (
	srno INT,
	col_val INT,
	PRIMARY KEY(srno)
)

INSERT INTO #tablefortest VALUES
(1, 56),
(2, 74),
(3, 15),
(4, 51),
(5, 9),
(6, 32)

SELECT *, -- solution 
	   CASE WHEN col_val % 2 = 0 THEN 'Even'
			ELSE 'Odd'
	   END AS even_odd
FROM #tablefortest;

-- 14. From the following table, write a SQL query to find the unique marks. Return the unique marks. 
DROP TABLE IF EXISTS #student_test

CREATE TABLE #student_test (
	student_id INT,
	marks_achieved INT
	PRIMARY KEY (student_id)
)

INSERT INTO #student_test VALUES
(1, 56),
(2, 74),
(3, 15),
(4, 74),
(5, 89),
(6, 56),
(7, 93)

SELECT DISTINCT marks_achieved AS 'Unique Marks' -- solution
FROM #student_test;

-- 15. From the following table, write a SQL query to find those students who have referred by the teacher whose id not equal to 602. Return the student names.
DROP TABLE IF EXISTS #students 

CREATE TABLE #students (
	student_id INT NOT NULL,
	student_name VARCHAR(10),
	teacher_id INT,
	PRIMARY KEY(student_id)
)

INSERT INTO #students VALUES
(1001, 'Alex', 601),
(1002, 'Jhon', NULL),
(1003, 'Peter', NULL),
(1004, 'Minto', 604),
(1005, 'Crage', NULL),
(1006, 'Chang', 601),
(1007, 'Philip', 602)

SELECT student_name -- solution
FROM #students
WHERE teacher_id <> 602
	  OR teacher_id IS NULL;

-- 16.  From the following table, write a SQL query to find the order that makes maximum number of sales amount.
--      If there are, more than one saleperson with maximum number of sales amount find all the salespersons. Return order id.
DROP TABLE IF EXISTS #salesmast

CREATE TABLE #salesmast (
	salesperson_id INT,
	order_id INT,
	PRIMARY KEY(salesperson_id)
)

INSERT INTO #salesmast VALUES
(5001, 1001),
(5002, 1002),
(5003, 1002),
(5004, 1002),
(5005, 1003),
(5006, 1004)

SELECT order_id -- solution
FROM #salesmast
GROUP BY order_id
ORDER BY COUNT(*) DESC

-- 17. A city is big if it has an area bigger than 50K square km or a population of more than 15 million.
--    From the following table, write a SQL query to find big cities name, population and area.
DROP TABLE IF EXISTS #cities_test

CREATE TABLE #cities_test (
	city_name VARCHAR(20),
	country VARCHAR(20),
	city_population INT,
	city_area INT
)

INSERT INTO #cities_test VALUES 
('Tokyo	','Japan',13515271,2191),('Delhi','India',	16753235,1484),('Shanghai','China',	24870895,6341),
('Sao Paulo','Brazil',12252023,1521),('Mexico City','Mexico',9209944,1485),('Cairo','Egypt',9500000,3085),
('Mumbai','India',12478447,603),('Beijing','China',	21893095,16411),('Osaka','Japan',2725006,225),	
('New York','United States',8398748,786),('Buenos Aires','Argentina',3054300,203),('Chongqing','China',	32054159,82403),	
('Istanbul','Turkey',15519267,5196),('Kolkata','India',4496694,205),('Manila','Philippines',1780148,43)	

SELECT city_name, -- solution 
       city_population,
	   city_area
FROM #cities_test
WHERE city_population > 15000000
      OR city_area > 50000;

-- 18. From the following table, write a SQL query to find those items, which have ordered 5 or more times. Return item name and number of orders.
DROP TABLE IF EXISTS #orders

CREATE TABLE #orders (
	order_id INT,
	customer_id INT,
	item_desc VARCHAR(10),
	PRIMARY KEY(order_id)
)

INSERT INTO #orders VALUES
(101,2109,'juice'),
(102,2139,'chocolate'),
(103,2120,'juice'),
(104,2108,'cookies'),
(105,2130,'juice'),
(106,2103,'cake'),
(107,2122,'cookies'),
(108,2125,'cake'),
(109,2139,'cake'),
(110,2141,'cookies'),
(111,2116,'cake'),
(112,2128,'cake'),
(113,2146,'chocolate'),
(114,2119,'cookies'),
(115,2142,'cake')

SELECT item_desc, -- solution
       COUNT(*) AS 'Number of orders'
FROM #orders
GROUP BY item_desc
HAVING COUNT(*) >= 5;

-- 19. From the following tables, write a SQL query to find the overall rate of execution of orders, which is the number of orders execution divided by the number of orders quote. Return rate_of_execution rounded to 2 decimals places.
DROP TABLE IF EXISTS #orders_issued
DROP TABLE IF EXISTS #orders_executed

CREATE TABLE #orders_issued (
	distributor_id INT,
	company_id INT,
	quotation_date DATE
)
CREATE TABLE #orders_executed (
	orders_from INT,
	executed_from INT,
	executed_date DATE
)

INSERT INTO #orders_issued VALUES
(101, 202, '2019-11-15'),
(101, 203, '2019-11-15'),
(101, 204, '2019-11-15'),
(102, 202, '2019-11-16'),
(102, 201, '2019-11-15'),
(103, 203, '2019-11-17'),
(103, 202, '2019-11-17'),
(104, 203, '2019-11-18'),
(104, 204, '2019-11-18')
INSERT INTO #orders_executed VALUES
(101, 202, '2019-11-17'),
(101, 203, '2019-11-17'),
(102, 202, '2019-11-17'),
(103, 203, '2019-11-18'),
(103, 202, '2019-11-19'),
(104, 203, '2019-11-20')

WITH count_issued AS (
SELECT COUNT(*)
FROM #orders_issued
)
WITH count_exec AS (
SELECT COUNT(*)
FROM #orders_executed
)

SELECT ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM #orders_executed)/
			 (SELECT CAST(COUNT(*) AS FLOAT) FROM #orders_issued), 2) AS rate_of_execution;

-- 20. From the following table write an SQL query to display the records with four or more rows with consecutive match_no's, and the crowd attended more than or equal to 50000 for each match. 
--     Return match_no, match_date and audience. Order the result by visit_date, descending.
DROP TABLE IF EXISTS #match_crowd

CREATE TABLE #match_crowd (
	match_no INT,
	match_date DATE,
	audience INT,
	PRIMARY KEY (match_no)
)

INSERT INTO #match_crowd VALUES
(1,'2016-06-11',75113 ),(2,'2016-06-12',62343 ),(3,'2016-06-13',43035 ),(4,'2016-06-14',55408 ),
(5,'2016-06-15',38742 ),(6,'2016-06-16',63670 ),(7,'2016-06-17',73648 ),(8,'2016-06-18',52409 ),
(9,'2016-06-19',67291),(10,'2016-06-20',49752 ),(11,'2016-06-21',28840 ),(12,'2016-06-22',32836 ),
(13,'2016-06-23',  44268 )

WITH consec_range AS (
SELECT m1.match_no AS from_no, 
       m1.match_no + 2 AS to_no
FROM #match_crowd m1, #match_crowd m2, #match_crowd m3
WHERE m1.match_no+1 = m2.match_no
AND m2.match_no = m3.match_no - 1
AND m1.audience >= 50000
AND m2.audience >= 50000
AND m3.audience >= 50000
)

SELECT *
FROM #match_crowd 
WHERE match_no BETWEEN (SELECT MIN(from_no) FROM consec_range)
					    AND (SELECT MAX(to_no) FROM consec_range)
ORDER BY match_date DESC;

-- 21. From the following table write a SQL query to know the availability of the doctor for consecutive 2 or more days. Return visiting days.
DROP TABLE IF EXISTS #dr_clinic

CREATE TABLE #dr_clinic (
	visiting_date DATE,
	availability BIT
)

INSERT INTO #dr_clinic VALUES
('2016-06-11','1'),
('2016-06-12','1'),
('2016-06-13','0'),
('2016-06-14','1'),
('2016-06-15','0'),
('2016-06-16','0'),
('2016-06-17','1'),
('2016-06-18','1'),
('2016-06-19','1'),
('2016-06-20','1'),	   
('2016-06-21','1')

SELECT DISTINCT d1.visiting_date
FROM #dr_clinic d1
JOIN #dr_clinic d2 ON ABS(DATEDIFF(DAY, d1.visiting_date, d2.visiting_date)) = 1
WHERE d1.availability = 1 
      AND d2.availability = 1
ORDER BY d1.visiting_date;

-- 22. From the following tables find those customers who did not make any order to the supplier 'DCX LTD'. Return customers name.
DROP TABLE IF EXISTS #customers
DROP TABLE IF EXISTS #supplier
DROP TABLE IF EXISTS #orders

CREATE TABLE #customers (
	customer_id INT,
	customer_name VARCHAR(10),
	customer_city VARCHAR(10),
	avg_profit INT,
	PRIMARY KEY (customer_id)
)
CREATE TABLE #supplier (
	supplier_id INT,
	supplier_name VARCHAR(10),
	supplier_city VARCHAR(10),
	PRIMARY KEY (supplier_id)
)
CREATE TABLE #orders (
	order_id INT,
	customer_id INT,
	supplier_id INT,
	order_date DATE,
	order_amount INT,
	PRIMARY KEY(order_id)
)

INSERT INTO #customers VALUES
('101', 'Liam','New York',25000),
('102', 'Josh','Atlanta',22000),
('103', 'Sean','New York',27000),
('104', 'Evan','Toronto',15000),
('105', 'Toby','Dallas',20000)
INSERT INTO #supplier VALUES
('501', 'ABC INC','Dallas'),
('502', 'DCX LTD','Atlanta'),
('503', 'PUC ENT','New York'),
('504', 'JCR INC','Toronto')
INSERT INTO #orders VALUES
(401, 103,501,'2012-03-08','4500'),
(402, 101,503,'2012-09-15','3650'),
(403, 102,503,'2012-06-27','4800'),
(404, 104,502,'2012-06-17','5600'),
(405, 104,504,'2012-06-22','6000'),
(406, 105,502,'2012-06-25','5600')

WITH combine_table AS (
SELECT ord.*,
       sup.supplier_name,
	   sup.supplier_city
FROM #orders ord
LEFT JOIN #supplier sup ON ord.supplier_id = sup.supplier_id
)

SELECT customer_name
FROM #customers
WHERE customer_id NOT IN (SELECT customer_id
						  FROM combine_table
						  WHERE supplier_name = 'DCX LTD');

-- 23. Table students contain marks of mathematics for several students in a class. It may same marks for more than one student.
--     From the following table write a SQL table to find the highest unique marks a student achieved. Return the marks.
DROP TABLE IF EXISTS #students

CREATE TABLE #students (
	student_id INT,
	student_name VARCHAR(10),
	marks_achieved INT,
	PRIMARY KEY(student_id)
)

INSERT INTO #students VALUES
(1, 'Alex',87),
(2, 'Jhon',92),
(3, 'Pain',83),
(4, 'Danny',87),
(5, 'Paul',92),
(6, 'Rex',89),
(7, 'Philip',87),
(8, 'Josh',83),
(9, 'Evan',92),
(10, 'Larry',87)

WITH mark_count AS (
SELECT marks_achieved,
       COUNT(*) as mark_n
FROM #students
GROUP BY marks_achieved
)

SELECT TOP 1 marks_achieved 
FROM mark_count 
WHERE mark_n = 1
ORDER BY marks_achieved DESC;


-- 24. In a hostel, each room contains two beds. After every 6 months a student have to change their bed with his or her room-mate.
--     From the following tables write a SQL query to find the new beds of the students in the hostel. Return original_bed_id, student_name, bed_id and student_new.
DROP TABLE IF EXISTS #bed_info

CREATE TABLE #bed_info (
	bed_id INT,
	student_name VARCHAR(10),
	PRIMARY KEY(Bed_id)
)

INSERT INTO #bed_info VALUES 
(101, 'Alex'),
(102, 'Jhon'),
(103, 'Pain'),
(104, 'Danny'),
(105, 'Paul'),
(106, 'Rex'),
(107, 'Philip'),
(108, 'Josh'),
(109, 'Evan'),
(110, 'Green')

SELECT bed_id AS original_bed_id,
	   student_name,
       (CASE WHEN bed_id % 2 != 0 AND counts != bed_id THEN bed_id + 1
			 WHEN bed_id % 2 != 0 AND counts = bed_id THEN bed_id
			 ELSE bed_id - 1
		END) AS bed_id,
		student_name AS student_new
FROM #bed_info,
    (SELECT COUNT(*) AS counts
     FROM #bed_info) AS bed_counts
ORDER BY bed_id ASC;

-- 25. From the following table, write a SQL query to find the first login date for each customer. Return customer id, login date.
DROP TABLE IF EXISTS #bank_trans

CREATE TABLE #bank_trans (
	trans_id INT,
	customer_id INT,
	login_date DATE
)

INSERT INTO #bank_trans VALUES
(101, 3002, '2019-09-01'),
(101, 3002, '2019-08-01'),
(102, 3003, '2018-09-13'),
(102, 3002, '2018-07-24'),
(103, 3001, '2019-09-25'),
(102, 3004, '2017-09-05')

SELECT customer_id,
       MIN(login_date) AS earliest_login
FROM #bank_trans
GROUP BY customer_id;

-- 26.  From the following table, write a SQL query to find those salespersons whose commission is less than ten thousand. Return salesperson name, commission.
DROP TABLE IF EXISTS #salemast
DROP TABLE IF EXISTS #commission

CREATE TABLE #salemast (
	salesman_id INT,
	salesman_name VARCHAR(10),
	yearly_sale INT,
	PRIMARY KEY(salesman_id)
)
CREATE TABLE #commission (
	salesman_id INT,
	commission_amt INT
)

INSERT INTO #salemast VALUES
(101, 'Adam', 250000),
(103, 'Mark', 100000),
(104, 'Liam', 200000),
(102, 'Evan', 150000),
(105, 'Blake', 275000),
(106, 'Noah', 50000)
INSERT INTO #commission VALUES
(101, 10000),
(103, 4000),
(104, 8000),
(102, 6000),
(105, 11000)

SELECT sale.salesman_name,
	   com.commission_amt
FROM #salemast sale
JOIN #commission com ON sale.salesman_id = com.salesman_id
WHERE com.commission_amt < 10000

-- 27. From the following table write a SQL query to find those distributors who purchased all types of item from the company. Return distributors ids
DROP TABLE IF EXISTS #items
DROP TABLE IF EXISTS #orders

CREATE TABLE #items (
	item_code INT,
	item_name VARCHAR(10),
	PRIMARY KEY(item_code)
)
CREATE TABLE #orders (
	order_id INT,
	distributor_id INT,
	item_ordered INT,
	item_quantity INT,
	PRIMARY KEY(order_id)
)

INSERT INTO #items VALUES
(10091,'juice'),
(10092,'chocolate'),
(10093,'cookies'),
(10094,'cake')
INSERT INTO #orders VALUES
(1,501,10091,250),
(2,502,10093,100),
(3,503,10091,200),
(4,502,10091,150),
(5,502,10092,300),
(6,504,10094,200),
(7,503,10093,250),
(8,503,10092,250),
(9,501,10094,180),
(10,503,10094,350)

SELECT distributor_id
FROM #orders
GROUP BY distributor_id
HAVING COUNT(DISTINCT item_ordered) = (SELECT COUNT(*)
									   FROM #items)

-- 28. From the following tables write a SQL query to find those directors and actors who worked together at least three or more movies. Return the director and actor name.
DROP TABLE IF EXISTS #actor_test
DROP TABLE IF EXISTS #director_test
DROP TABLE IF EXISTS #movie_test
DROP TABLE IF EXISTS #mov_direction_test

CREATE TABLE #actor_test (
	act_id INT,
	act_name VARCHAR(20),
	PRIMARY KEY(act_id)
)
CREATE TABLE #director_test (
	dir_id INT,
	dir_name VARCHAR(20),
	PRIMARY KEY(dir_id)
)
CREATE TABLE #movie_test (
	mov_id INT,
	movie_name VARCHAR(20),
	PRIMARY KEY(mov_id)
)
CREATE TABLE #mov_direction_test (
	dir_id INT,
	mov_id INT,
	act_id INT,
	FOREIGN KEY(dir_id) REFERENCES #director_test(dir_id),
	FOREIGN KEY(mov_id) REFERENCES #movie_test(mov_id),
	FOREIGN KEY(act_id) REFERENCES #actor_test(act_id)
)

INSERT INTO #actor_test VALUES
(101,'James Stewart'),
(102,'Deborah Kerr'), 
(103,'Peter OToole'),  
(104,'Robert De Niro'),  
(105,'F. Murray Abraham'),  
(106,'Harrison Ford'),  
(107,'Bill Paxton'),  
(108,'Stephen Baldwin'),  
(109,'Jack Nicholson'),  
(110,'Mark Wahlberg')
INSERT INTO #director_test VALUES
(201,'Alfred Hitchcock '),
(202,'Jack Clayton'),
(203,'James Cameron'),
(204,'Michael Cimino'),
(205,'Milos Forman'),
(206,'Ridley Scott'),
(207,'Stanley Kubrick'),
(208,'Bryan Singer'),
(209,'Roman Polanski')
INSERT INTO #movie_test VALUES
(901,'Vertigo'),                     
(902,'Aliens'),                     
(903,'Lawrence of Arabia'),                    
(904,'The Deer Hunter'),                     
(905,'True Lies'),                     
(906,'Blade Runner'),                     
(907,'Eyes Wide Shut'),                     
(908,'Titanic'),                     
(909,'Chinatown'),                     
(910,'Ghosts of the Abyss')
INSERT INTO #mov_direction_test VALUES
(201,901,101),
(203,902,107),
(204,904,104),
(203,905,107),
(206,906,106),
(203,908,107),
(209,909,109),
(203,910,107)

SELECT dir.dir_name,
	   act.act_name
FROM #mov_direction_test md
JOIN #director_test dir ON md.dir_id = dir.dir_id
JOIN #actor_test act ON md.act_id = act.act_id
JOIN #movie_test mov ON md.mov_id = mov.mov_id
GROUP BY dir.dir_name,
	     act.act_name
HAVING COUNT(*) >= 3;

-- 29. From the following tables write a SQL query to find those students who achieved 100 percent in various subjects in every year. 
--     Return examination ID, subject name, examination year, number of students.
DROP TABLE IF EXISTS #exam_test
DROP TABLE IF EXISTS #subject_test

CREATE TABLE #exam_test (
	exam_id INT,
	subject_id INT,
	exam_year INT,
	no_of_student INT
)
CREATE TABLE #subject_test (
	subject_id INT,
	subject_name VARCHAR(20)
)

INSERT INTO #exam_test VALUES
(71,201,2017,5146),
(72,202,2017,3651),
(73,202,2018,4501),
(71,202,2018,5945),
(73,201,2018,2647),
(71,201,2018,3545),
(73,201,2019,2647),
(72,201,2018,3500),
(71,203,2017,2500),
(71,202,2019,2500)
INSERT INTO #subject_test VALUES
(201,'Mathematics'),
(202,'Physics'),
(203,'Chemistry')

SELECT exam.exam_id,	
       sub.subject_name,
	   exam.exam_year,
	   exam.no_of_student
FROM #exam_test exam
JOIN #subject_test sub ON exam.subject_id = sub.subject_id
ORDER BY 1, 2, 3

-- 30. From the following tables write a SQL query to find those students who achieved 100 percent marks in every subject for all the year.
--     Return subject ID, subject name, students for all year.
SELECT exam.subject_id,
       sub.subject_name,
	   SUM(exam.no_of_student) AS 'Students for all year'
FROM #exam_test exam
JOIN #subject_test sub ON exam.subject_id = sub.subject_id
GROUP BY exam.subject_id,
		 sub.subject_name;

-- 31. From the following tables write a SQL query that will generate a report which shows the total number of students achieved 100 percent for the first year of each examination of every subject. 
INSERT INTO #exam_test VALUES
(71, 202, 2017, 2701),
(73, 201, 2017, 1000)

SELECT *
FROM #exam_test
ORDER BY 1, 2, 3

SELECT exam.exam_id,
       sub.subject_name,
	   exam.exam_year AS 'First year', 
	   exam.no_of_student
FROM #exam_test exam
LEFT JOIN #subject_test sub ON exam.subject_id = sub.subject_id
WHERE exam.exam_year = (SELECT MIN(exam_year)
						FROM #exam_test)
ORDER BY 1;

-- 32. From the following tables write a SQL query to display those managers who have average experience for each scheme.
DROP TABLE IF EXISTS #managing_body
DROP TABLE IF EXISTS #scheme

CREATE TABLE #managing_body (
	manager_id INT,
	manager_name VARCHAR(10),
	running_years INT,
	PRIMARY KEY (manager_id)
)
CREATE TABLE #scheme (
	scheme_code INT,
	scheme_manager_id INT
)

INSERT INTO #managing_body VALUES
(51,'James',5),
(52,'Cork',3),
(53,'Paul',4),
(54,'Adam',3),
(55,'Hense',4),
(56,'Peter',2)
INSERT INTO #scheme VALUES
(1001,	51),
(1001,	53),
(1001,	54),
(1001,	56),
(1002,	51),
(1002,	55),
(1003,	51),
(1004,	52)

SELECT sch.scheme_code,
	   AVG(ROUND(CAST(man.running_years AS FLOAT), 2)) 'Average year of experience'
FROM #scheme sch
JOIN #managing_body man ON sch.scheme_manager_id = man.manager_id
GROUP BY sch.scheme_code;

-- 33. From the following tables write a SQL query to find those schemes which executed by minimum number of employees. Return scheme code.
WITH emp_scheme_n AS (
SELECT scheme_code,
       COUNT(*) AS count_n
FROM #scheme
GROUP BY scheme_code
)

SELECT scheme_code
FROM emp_scheme_n
WHERE count_n = (SELECT MIN(count_n)
				  FROM emp_scheme_n);

-- 34. From the following tables write a SQL query to find those experienced manager who execute the schemes. Return scheme code and scheme manager ID.
WITH max_exp_mang AS (
SELECT sch.scheme_code,
	   MAX(mang.running_years) AS max_year
FROM #scheme sch
JOIN #managing_body mang ON sch.scheme_manager_id = mang.manager_id
GROUP BY sch.scheme_code
)

SELECT sch.scheme_code,
	   sch.scheme_manager_id
FROM #scheme sch
JOIN #managing_body mang ON sch.scheme_manager_id = mang.manager_id
JOIN max_exp_mang maxexp ON sch.scheme_code = maxexp.scheme_code
WHERE mang.running_years = maxexp.max_year;

-- 35. From the following tables write an SQL query to find the best seller by total sales price. Return distributor ID , If there is a tie, report them all. 
DROP TABLE IF EXISTS #item
DROP TABLE IF EXISTS #sales_info

CREATE TABLE #item (
	item_code INT,
	item_desc VARCHAR(15),
	cost INT,
	PRIMARY KEY (item_code)
)
CREATE TABLE #sales_info (
	distributor_id INT,
	item_code INT,
	retailer_id INT,
	date_of_sell DATE,
	quantity INT,
	total_cost INT
)

INSERT INTO #item VALUES
(101,'mother board',2700),
(102,'RAM',800),
(103,'key board',300),
(104,'mouse',300)
INSERT INTO #sales_info VALUES
(5001,101,1001,'2020-02-12',3,8100),
(5001,103,1002,'2020-03-15',15,4500),
(5002,101,1001,'2019-06-24',2,5400),
(5001,104,1003,'2019-09-11',8,2400),
(5003,101,1003,'2020-10-21',5,13500),
(5003,104,1002,'2020-12-27',10,3000),
(5002,102,1001,'2019-05-18',12,9600),
(5002,103,1004,'2020-06-17',8,2400),
(5003,103,1001,'2020-04-12',3,900)

WITH item_total AS (
SELECT distributor_id,
       SUM(total_cost) AS total_sales
FROM #sales_info 
GROUP BY distributor_id
)

SELECT sales.distributor_id
FROM #sales_info sales
JOIN #item item ON sales.item_code = item.item_code
GROUP BY sales.distributor_id
HAVING SUM(total_cost) = (SELECT MAX(total_sales)
						  FROM item_total);

-- 36. From the following table write a SQL query to find those retailers who have bought 'key board' but not 'mouse'. Return retailer ID.
SELECT DISTINCT sales.retailer_id
FROM #sales_info sales
JOIN #item ON sales.item_code = #item.item_code
WHERE sales.retailer_id NOT IN (SELECT DISTINCT retailer_id
							    FROM #sales_info 
								WHERE item_code = (SELECT item_code
												   FROM #item
												   WHERE item_desc = 'mouse'))
	 AND #item.item_desc = 'key board';
      
-- 37. From the following table write a SQL query to display those items that were only sold in the 2nd quarter of a year, i.e. April 1st to June end for the year 2020. Return item code and item description.
SELECT DISTINCT sales.item_code,
       item.item_desc
FROM #sales_info sales
JOIN #item item ON sales.item_code = item.item_code
WHERE sales.date_of_sell BETWEEN '2020-04-01' AND '2020-06-30'
	  OR sales.date_of_sell BETWEEN '2019-04-01' AND '2019-06-30';

-- 38. From the following table write a SQL query to find the highest purchase with its corresponding item for each customer. In case of a same quantity purchase find the item code which is smallest.
--     The output must be sorted by increasing of customer_id. Return customer ID,lowest item code and purchase quantity.
DROP TABLE IF EXISTS #purchase

CREATE TABLE #purchase (
	customer_id INT,
	item_code INT,
	purch_qty INT,
)

INSERT INTO #purchase VALUES
(101,504,25),
(101,503,50),
(102,502,40),
(102,503,25),
(102,501,45),
(103,505,30),
(103,503,25),
(104,505,40),
(101,502,25),
(102,504,40),
(102,505,50),
(103,502,25),
(104,504,40),
(103,501,35)

WITH max_cust_price AS (
SELECT customer_id,
	   MAX(purch_qty) AS max_price
FROM #purchase
GROUP BY customer_id
)

SELECT purch.customer_id,
	   MIN(purch.item_code) AS 'lowest item code',
	   mcp.max_price
FROM #purchase purch
JOIN max_cust_price mcp ON purch.customer_id = mcp.customer_id
WHERE purch.purch_qty = mcp.max_price
GROUP BY purch.customer_id, mcp.max_price
ORDER BY 1;

-- 39. From the following table write a SQL query to find all the writers who rated at least one of their own topic. Sorted the result in ascending order by writer id. Return writer ID. 
DROP TABLE IF EXISTS #topics

CREATE TABLE #topics (
	topic_id INT,
	writer_id INT,
	rated_by INT,
	date_of_rating DATE
)

INSERT INTO #topics VALUES
(10001,504,507,'2020-07-17'),
(10003,502,503,'2020-09-22'), 
(10001,503,507,'2020-02-07'), 
(10002,501,507,'2020-05-13'), 
(10002,502,502,'2020-04-10'), 
(10002,504,502,'2020-11-16'), 
(10003,501,502,'2020-10-05'), 
(10001,507,507,'2020-12-23'),
(10004,503,501,'2020-08-28'),
(10003,505,504,'2020-12-21')  

SELECT DISTINCT t2.writer_id AS 'Author rated on own topic'
FROM #topics t1
JOIN #topics t2 ON t1.rated_by = t2.writer_id
WHERE t1.topic_id = t2.topic_id;

-- 40. From the following table write a SQL query to find all the writers who rated more than one topics on the same date, sorted in ascending order by their id. Return writr ID.
SELECT rated_by AS 'Topic rated by the writer'
FROM #topics
GROUP BY rated_by
HAVING COUNT(*) > 1
ORDER BY rated_by;

-- 41.  From the following table write a SQL query to make a report such that there is a product id column and a sale quantity column for each quarter. Return product ID and sale quantity of each quarter.
DROP TABLE IF EXISTS #sale

CREATE TABLE #sale (
	product_id INT,
	sale_qty INT,
	qtr_no VARCHAR(10)
)

INSERT INTO #sale VALUES
(3,20000,'qtr1'),
(2,12000,'qtr2'),
(3,23000,'qtr3'),
(1,10000,'qtr2'),
(3,15000,'qtr2'),
(1,15000,'qtr1'),
(4,25000,'qtr2'),
(2,20000,'qtr1'),
(4,18000,'qtr4'),
(3,22000,'qtr4')

WITH q1_sales AS (
SELECT product_id,
	   sale_qty
FROM #sale
WHERE qtr_no = 'qtr1'
), q2_sales AS (
SELECT product_id,
	   sale_qty
FROM #sale
WHERE qtr_no = 'qtr2'
), q3_sales AS (
SELECT product_id,
	   sale_qty
FROM #sale
WHERE qtr_no = 'qtr3'
), q4_sales AS (
SELECT product_id,
	   sale_qty
FROM #sale
WHERE qtr_no = 'qtr4'
)

SELECT DISTINCT sale.product_id,
       q1_sales.sale_qty AS 'qtr1_sale',
	   q2_sales.sale_qty AS 'qtr2_sale',
	   q3_sales.sale_qty AS 'qtr3_sale',
	   q4_sales.sale_qty AS 'qtr4_sale'
FROM #sale sale
LEFT JOIN q1_sales ON sale.product_id = q1_sales.product_id
LEFT JOIN q2_sales ON sale.product_id = q2_sales.product_id
LEFT JOIN q3_sales ON sale.product_id = q3_sales.product_id
LEFT JOIN q4_sales ON sale.product_id = q4_sales.product_id;

-- 42. From the following table write a SQL query to find for each month and company, the number of orders issued and their total quantity, the number of orders booked and their total order quantity. Return month, name of the company, number of orders issued, number of booked orders, total order quantity and total booked orders quantity. 
DROP TABLE IF EXISTS #order_stat

CREATE TABLE #order_stat (
	order_id INT,
	com_name VARCHAR(15),
	ord_qty INT,
	ord_stat VARCHAR(10),
	stat_date DATE
)

INSERT INTO #order_stat VALUES
(151, 'MMS INC'		,500,	'Booked',		'2020-08-15'),
(152, 'BCT LTD'		,300,	'Cancelled',	'2020-08-15'),
(153, 'MMS INC'		,400,	'Cancelled',	'2020-08-26'),
(154, 'XYZ COR'		,500,	'Booked',		'2020-08-15'),
(155, 'MMS INC'		,500,	'Cancelled',	'2020-10-11'),
(156, 'BWD PRO LTD'	,250,	'Cancelled',	'2020-11-15'),
(157, 'BCT LTD'		,600,	'Booked',		'2020-10-07'),
(158, 'MMS INC'		,300,	'Booked',		'2020-12-11'),
(159, 'XYZ COR'		,300,	'Booked',		'2020-08-26'),
(160, 'BCT LTD'		,400,	'Booked',		'2020-11-15')

SELECT
    FORMAT(stat_date, '%Y-%m') AS 'month year',
    com_name,
    SUM(CASE WHEN ord_stat = 'Booked' THEN 1
            WHEN ord_stat = 'Cancelled' THEN 1
            ELSE 0 END) AS no_of_orders,
    SUM(CASE WHEN ord_stat = 'Booked' THEN 1 ELSE 0 END) AS booked_orders,
    SUM(ord_qty) AS total_order_qty,
    SUM(CASE WHEN ord_stat = 'Booked' THEN ord_qty ELSE 0 END) AS no_of_booked_qty
FROM #order_stat
GROUP BY com_name, FORMAT(stat_date, '%Y-%m');