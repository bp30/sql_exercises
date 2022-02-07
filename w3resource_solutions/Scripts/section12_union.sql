/*
w3resource SQL exercises

SQL Union (9 exercises)
https://www.w3resource.com/sql-exercises/union/sql-union.php
*/

-- 1. From the following tables, write a SQL query to find all salespersons and customer who located in 'London' city.
SELECT salesman_id AS id,
       name, 
       'salesperson' AS type
FROM salesman
WHERE city = 'London'

UNION

SELECT customer_id AS id,
       cust_name AS name,
       'customer' AS type
FROM customer
WHERE city = 'London';

-- 2. From the following tables, write a SQL query to find distinct salesperson and their cities. Return salesperson ID and city.
SELECT salesman_id,
       city 
FROM customer

UNION

SELECT salesman_id,
       city
FROM salesman;

-- 3. From the following tables, write a SQL query to find all those salespersons and customers who involved in inventory management system. Return salesperson ID, customer ID.
SELECT salesman_id, 
       customer_id
FROM customer

UNION 

SELECT salesman_id, 
       customer_id
FROM orders;

-- 4. From the following table, write a SQL query to find those salespersons generated the largest and smallest orders on each date. Return salesperson ID, name, order no., highest on/ lowest on, order date.
SELECT sales.salesman_id,
       sales.name,
       'largest on',
       a.ord_date
FROM salesman sales 
INNER JOIN orders a USING(salesman_id)
WHERE a.purch_amt = (SELECT MAX(purch_amt)
		     FROM orders b
		     WHERE a.ord_date = b.ord_date)

UNION

SELECT sales.salesman_id,
       sales.name,
       'lowest on',
       a.ord_date
FROM salesman sales 
INNER JOIN orders a USING(salesman_id)
WHERE a.purch_amt = (SELECT MIN(purch_amt)
	             FROM orders b
	             WHERE a.ord_date = b.ord_date);
	            
-- 5. From the following tables, write a SQL query to find those salespersons who generated the largest and smallest orders on each date. Sort the result-set on 3rd field. 
--    Return salesperson ID, name, order no., highest on/lowest on, order date. 
SELECT sales.salesman_id,
       sales.name,
       a.ord_no,
       'largest on',
       a.ord_date
FROM salesman sales 
INNER JOIN orders a USING(salesman_id)
WHERE a.purch_amt = (SELECT MAX(purch_amt)
		     FROM orders b
		     WHERE a.ord_date = b.ord_date)

UNION

SELECT sales.salesman_id,
       sales.name,
       a.ord_no,
       'lowest on',
       a.ord_date
FROM salesman sales 
INNER JOIN orders a USING(salesman_id)
WHERE a.purch_amt = (SELECT MIN(purch_amt)
	             FROM orders b
	             WHERE a.ord_date = b.ord_date)
ORDER BY 3;


-- 6. From the following table, write a SQL query to find those salespersons who have same cities where customer lives as well as do not have customers in their cities and indicate it by ‘NO MATCH’. 
--    Sort the result set on 2nd column (i.e. name) in descending order. Return salesperson ID, name, customer name, commission. 
SELECT sales.salesman_id,
       sales.name,
       cust.cust_name,
       sales.commission
FROM salesman sales
INNER JOIN customer cust USING (city)

UNION

SELECT sales.salesman_id,
       sales.name,
       'No Match',
       sales.commission
FROM salesman sales
INNER JOIN customer cust USING (salesman_id)
WHERE sales.city NOT IN (SELECT city 
			 FROM customer)
ORDER BY 2 DESC;

-- 7. From the following tables, write a SQL query that appends strings to the selected fields, indicating whether a specified city of any salesperson was matched to the city of any customer. 
--    Return salesperson ID, name, city, MATCHED/NO MATCH.
SELECT salesman_id,
       name,
       city,
       'Matched'
FROM salesman
WHERE city IN (SELECT city 
	       FROM customer)

UNION

SELECT salesman_id,
       name,
       city,
       'No Match'
FROM salesman
WHERE city NOT IN (SELECT city 
	           FROM customer);



-- 8. From the following table, write a SQL query to create a union of two queries that shows the customer id, cities, and ratings of all customers. 
--    Those with a rating of 300 or greater will have the words 'High Rating', while the others will have the words 'Low Rating'.
SELECT customer_id,
       city,
       grade,
       'High Rating'
FROM customer
WHERE grade >= 300

UNION 

SELECT customer_id,
       city,
       grade,
       'Low Rating'
FROM customer
WHERE grade < 300

-- using case statement
SELECT customer_id,
       city,
       grade,
       CASE WHEN grade >= 300 THEN 'High Rating'
            ELSE 'Low Rating'
       END AS Ratings
FROM customer
WHERE grade IS NOT NULL;

-- 9. From the following table, write a SQL query to find those salesperson and customer where more than one order executed. Sort the result-set on 2nd field. Return ID, name.
SELECT customer_id AS id,
       cust_name AS name
FROM customer 
WHERE customer_id IN (SELECT customer_id
		      FROM orders
		      GROUP BY customer_id
		      HAVING COUNT(ord_no) > 1)

UNION

SELECT salesman_id AS id,
       name AS name
FROM salesman 
WHERE salesman_id IN (SELECT salesman_id
		      FROM orders
		      GROUP BY salesman_id
		      HAVING COUNT(ord_no) > 1)
ORDER BY 2;		     		      



	           	           