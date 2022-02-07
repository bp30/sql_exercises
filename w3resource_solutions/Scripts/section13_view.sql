/*
w3resource SQL exercises

SQL View (16 exercises)
https://www.w3resource.com/sql-exercises/view/sql-view.php
*/

-- 1. From the following table, create a view for those salespersons belong to the city 'New York'. 
CREATE VIEW salesman_loc AS
SELECT *
FROM salesman
WHERE city = 'New York';

SELECT *
FROM salesman_loc

-- 2. From the following table, create a view for all salespersons. Return salesperson ID, name, and city. 
CREATE VIEW salesperson AS
SELECT salesman_id,
       name,
       city
FROM salesman;

SELECT * 
FROM salesperson;

-- 3. From the following table, create a view to find the salespersons of the city 'New York'.
DROP VIEW IF EXISTS salesperson;
CREATE VIEW salesperson AS
SELECT *
FROM salesman
WHERE city = 'New York';

SELECT * 
FROM salesperson;

-- 4. From the following table, create a view to count the number of customers in each grade
DROP VIEW IF EXISTS cust_grade;
CREATE VIEW cust_grade AS
SELECT grade,
       COUNT(*) AS number
FROM customer
GROUP BY grade;

SELECT *
FROM cust_grade

-- 5. From the following table, create a view to count the number of unique customer, compute average and total purchase amount of customer orders by each date.
DROP VIEW IF EXISTS cust_ord;
CREATE VIEW cust_ord AS
SELECT ord_date,
       COUNT(DISTINCT customer_id),
       AVG(purch_amt),
       SUM(purch_amt)
FROM orders
GROUP BY ord_date;

SELECT *
FROM cust_ord
ORDER BY ord_date;

-- 6. From the following tables, create a view to get the salesperson and customer by name. Return order name, purchase amount, salesperson ID, name, customer name.
CREATE VIEW sales_cust AS
SELECT orders.ord_no,
       orders.purch_amt,
       sales.salesman_id,
       sales.name,
       cust.cust_name
FROM orders
INNER JOIN customer cust ON orders.customer_id = cust.customer_id
INNER JOIN salesman sales ON orders.salesman_id = sales.salesman_id;

SELECT *
FROM sales_cust
WHERE name = 'Mc Lyon';


-- 7. From the following tables, create a view to find the salesperson who handles a customer who makes the highest order of a day. Return order date, salesperson ID, name.
CREATE VIEW elitsalesman AS
SELECT ord.ord_date,
       sales.salesman_id,
       sales.name
FROM salesman sales
INNER JOIN orders ord USING (salesman_id)
WHERE purch_amt = (SELECT MAX(purch_amt)
		   FROM orders b
		   WHERE ord.ord_date = b.ord_date);
		   
SELECT * 
FROM elitsalesman;   

-- 8. From the following tables, create a view to find the salesperson who handles the customer with the highest order, at least 3 times on a day. Return salesperson ID and name. 
CREATE VIEW incentive AS
SELECT DISTINCT salesman_id,
       name
FROM elitsalesman
WHERE salesman_id IN (SELECT salesman_id
	              FROM elitsalesman
	              GROUP BY salesman_id
	              HAVING COUNT(*) >= 3);
	          

SELECT * 
FROM incentive

-- 9. From the following table, create a view to find all the customers who have the highest grade. Return all the fields of customer.
CREATE VIEW highgrade AS
SELECT *
FROM customer
WHERE grade = (SELECT MAX(grade)
	       FROM customer);

SELECT *
FROM highgrade	       

-- 10. From the following table, create a view to count number of the salesperson in each city. Return city, number of salespersons.
CREATE VIEW citynum AS
SELECT city,
       COUNT(*)
FROM salesman
GROUP BY city;

SELECT * 
FROM citynum;

-- 11.  From the following table, create a view to compute average purchase amount and total purchase amount for each salesperson. Return name, average purchase and total purchase amount. (Assume all names are unique).
CREATE VIEW norder AS
SELECT sales.name,
       AVG(ord.purch_amt),
       SUM(ord.purch_amt)
FROM salesman sales
INNER JOIN orders ord USING(salesman_id)
GROUP BY sales.name;

SELECT * 
FROM norder;

-- 12. From the following tables, create a view to find those salespeople who handle more than one customer. Return all the fields of salesperson.
CREATE VIEW mcustomer AS
SELECT * 
FROM salesman
WHERE salesman_id IN (SELECT salesman_id
		      FROM customer
		      GROUP BY salesman_id
		      HAVING COUNT(customer_id) > 1);

SELECT *
FROM mcustomer;

-- 13. From the following tables, create a view that shows all matches of customers with salesperson such that at least one customer in the city of customer served by a salesperson in the city of the salesperson.
DROP VIEW IF EXISTS citymatch;
CREATE VIEW citymatch AS
SELECT DISTINCT cust.city AS custcity,
       sales.city AS salescity
FROM customer cust
INNER JOIN salesman sales USING (salesman_id);

SELECT *
FROM citymatch;

-- 14. From the following table, create a view to get number of orders in each day. Return order date and number of orders.
CREATE VIEW dateord AS
SELECT ord_date,
       COUNT(*) as odcount
FROM orders
GROUP BY ord_date;

-- 15. From the following tables, create a view to find the salespersons who issued orders on October 10th, 2012. Return all the fields of salesperson.
CREATE VIEW salesmanonoct AS
SELECT sales.*
FROM salesman sales
INNER JOIN orders USING(salesman_id)
WHERE orders.ord_date = '2012-10-10';

SELECT *
FROM salesmanonoct;

-- 16. From the following table, create a view to find the salespersons who issued orders on either August 17th, 2012 or October 10th, 2012. Return salesperson ID, order number and customer ID. 
CREATE VIEW sorder AS
SELECT salesman_id,
       ord_no,
       customer_id
FROM orders
WHERE ord_date IN ('2012-08-17', '2012-10-10');

SELECT *
FROM sorder;
            