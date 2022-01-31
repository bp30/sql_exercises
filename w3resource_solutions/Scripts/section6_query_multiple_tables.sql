/*
w3resource SQL exercises

Query on multiple tables (8 exercises)
https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
*/

-- 1. From the following tables, write a SQL query to find the salespersons and customers who live in same city. Return customer name, salesperson name and salesperson city. 
SELECT customer.cust_name,
       salesman.name AS salesperson, 
       salesman.city
FROM salesman, customer
WHERE salesman.city = customer.city;

-- 2. From the following tables, write a SQL query to find all the customers along with the salesperson who works for them. Return customer name, and salesperson name.
SELECT customer.cust_name,
       salesman.name AS salesperson
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 3. From the following tables, write a SQL query to find those sales people who generated orders for their customers but not located in the same city. Return ord_no, cust_name, customer_id (orders table), salesman_id (orders table).
SELECT orders.ord_no,
       customer.cust_name,
       orders.customer_id,
       orders.salesman_id
FROM orders
INNER JOIN customer ON customer.customer_id = orders.customer_id
INNER JOIN salesman ON salesman.salesman_id = customer.salesman_id
WHERE salesman.city <> customer.city;

-- 4. From the following tables, write a SQL query to find those orders made by customers. Return order number, customer name. 
SELECT orders.ord_no,
       customer.cust_name
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id;


-- 5. From the following tables, write a SQL query to find those customers where each customer has a grade and served by at least a salesperson who belongs to a city. Return cust_name as "Customer", grade as "Grade". 
SELECT customer.cust_name AS Customer,
       customer.grade AS Grade
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
INNER JOIN orders ON orders.customer_id = customer.customer_id
WHERE salesman.city IS NOT NULL
      AND customer.grade IS NOT NULL;

-- 6. From the following table, write a SQL query to find those customers who served by a salesperson and the salesperson works at the commission in the range 12% to 14% (Begin and end values are included.). Return cust_name AS "Customer", city AS "City". 
SELECT customer.cust_name AS Customer,
       salesman.city AS City,
       salesman.name AS Salesman,
       commission
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE salesman.commission BETWEEN 0.12 AND 0.14;


-- 7. From the following tables, write a SQL query to find those orders executed by the salesperson, ordered by the customer whose grade is greater than or equal to 200. Compute purch_amt*commission as "Commission". 
--    Return customer name, commission as "Commission%" and Commission. 
SELECT orders.ord_no, 
       customer.cust_name,
       salesman.commission AS "Commission%",
       orders.purch_amt * salesman.commission AS Commission
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE customer.grade >= 200;

-- 8. From the following table, write a SQL query to find those customers who made orders on October 5, 2012. Return customer_id, cust_name, city, grade, salesman_id, ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT customer.customer_id,
       customer.cust_name,
       customer.grade,
       salesman.salesman_id,
       orders.ord_no,
       orders.purch_amt,
       orders.ord_date,
       customer.customer_id,
       salesman.salesman_id
FROM customer
INNER JOIN salesman ON salesman.salesman_id = customer.salesman_id
INNER JOIN orders ON customer.customer_id = orders.customer_id
WHERE orders.ord_date = '2012-10-5';