/*
w3resource SQL exercises

SQL Joins (29 exercises)
https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
*/

-- 1. From the following tables write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.
SELECT salesman.name AS Salesman,
       customer.cust_name AS Customer,
       salesman.city
FROM salesman
INNER JOIN customer ON salesman.city = customer.city;

-- 2. From the following tables write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
SELECT orders.ord_no, 
       orders.purch_amt,
       customer.cust_name,
       customer.city
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
WHERE orders.purch_amt BETWEEN 500 AND 2000;

-- 3. From the following tables write a SQL query to find the salesperson(s) and the customer(s) he handle. Return Customer Name, city, Salesman, commission. 
SELECT customer.cust_name AS "Customer Name",
       customer.city,
       salesman.name AS Salesman,
       salesman.commission
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 4. From the following tables write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission.
SELECT customer.cust_name AS "Customer name",
       customer.city,
       salesman.name AS Salesman,
       salesman.commission
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE salesman.commission > 0.12;

-- 5. From the following tables write a SQL query to find those salespersons do not live in the same city where their customers live and received a commission from the company more than 12%. 
--    Return Customer Name, customer city, Salesman, salesman city, commission. 
SELECT customer.cust_name AS "Customer name",
       customer.city AS "Customer city",
       salesman.name AS Salesman,
       salesman.city AS "Salesman city",
       salesman.commission
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE salesman.commission > 0.12
      AND customer.city <> salesman.city;

-- 6.  From the following tables write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.
SELECT orders.ord_no,
       orders.ord_date,
       orders.purch_amt,
       customer.cust_name AS "Customer name",
       customer.grade,
       salesman.name AS Salesman,
       salesman.commission
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
SELECT * 
FROM orders
NATURAL JOIN customer
NATURAL JOIN salesman; 

-- 8. From the following tables write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id.
SELECT customer.cust_name,
       customer.city AS "Customer city",
       customer.grade,
       salesman.name AS Salesman,
       salesman.city AS "Salesman city"
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
ORDER BY customer.customer_id;

-- 9. From the following tables write a SQL query to find those customers whose grade less than 300. Return cust_name, customer city, grade, Salesman, saleman city. The result should be ordered by ascending customer_id. 
SELECT customer.cust_name,
       customer.city AS "Customer city",
       customer.grade,
       salesman.name AS Salesman,
       salesman.city AS "Salesman city"
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE customer.grade < 300
ORDER BY customer.customer_id;

-- 10.  Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
SELECT customer.cust_name,
       customer.city,
       orders.ord_no, 
       orders.ord_date,
       orders.purch_amt
FROM customer
LEFT JOIN orders ON customer.customer_id = orders.customer_id
ORDER BY orders.ord_date;

-- 11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
SELECT customer.cust_name,
       customer.city,
       orders.ord_no, 
       orders.ord_date,
       orders.purch_amt,
       salesman.name AS "salesman",
       salesman.commission
FROM customer
LEFT JOIN orders ON customer.customer_id = orders.customer_id
LEFT JOIN salesman ON orders.salesman_id = salesman.salesman_id;

-- 12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.
SELECT customer.cust_name,
       customer.city AS "customer city",
       customer.grade,
       salesman.name AS salesman,
       salesman.city AS "salesman city"
FROM salesman
LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
ORDER BY salesman.salesman_id;

-- 13. From the following tables write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.
SELECT salesman.name AS salesperson,
       customer.cust_name AS customer,
       customer.city,
       customer.grade,
       orders.ord_no, 
       orders.ord_date,
       orders.purch_amt
FROM salesman
LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
LEFT JOIN orders ON customer.customer_id = orders.customer_id;

-- 14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. 
---    The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
SELECT salesman.name AS salesperson,
       customer.cust_name AS customer,
       customer.city,
       customer.grade,
       orders.ord_no, 
       orders.ord_date,
       orders.purch_amt
FROM salesman
LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
LEFT JOIN orders ON customer.customer_id = orders.customer_id
WHERE customer.grade IS NOT NULL
      AND orders.purch_amt >= 2000;

-- 15. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
SELECT customer.cust_name,
       customer.city,
       orders.ord_no,
       orders.ord_date,
       orders.purch_amt
FROM customer
RIGHT JOIN orders ON customer.customer_id = orders.customer_id;

-- 16.  Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list nor have a grade.
SELECT customer.cust_name,
       customer.city,
       orders.ord_no,
       orders.ord_date,
       orders.purch_amt
FROM customer
RIGHT JOIN orders ON customer.customer_id = orders.customer_id
WHERE customer.grade IS NOT NULL;

-- 17. Write a SQL query to combine each row of salesman table with each row of customer table.
SELECT *
FROM salesman
CROSS JOIN customer;

-- 18. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that salesman who belongs to a city.
SELECT *
FROM salesman
CROSS JOIN customer
WHERE salesman.city IS NOT NULL;

-- 19. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade. 
SELECT *
FROM salesman
CROSS JOIN customer
WHERE salesman.city IS NOT NULL
      AND customer.grade IS NOT NULL;

-- 20. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade.
SELECT *
FROM salesman
CROSS JOIN customer
WHERE salesman.city IS NOT NULL
      AND salesman.city <> customer.city
      AND customer.grade IS NOT NULL;

-- 21. From the following tables write a SQL query to select all rows from both participating tables as long as there is a match between pro_com and com_id.
SELECT * 
FROM company_mast com
INNER JOIN item_mast item ON com.com_id = item.pro_com;

-- 22. Write a SQL query to display the item name, price, and company name of all the products.
SELECT item.pro_name,
       item.pro_price,
       com.com_name
FROM company_mast com
INNER JOIN item_mast item ON com.com_id = item.pro_com;

-- 23. From the following tables write a SQL query to calculate the average price of items of each company. Return average value and company name.
SELECT com.com_name,
       AVG(pro_price) AS average_price
FROM company_mast com
INNER JOIN item_mast item ON com.com_id = item.pro_com
GROUP BY com.com_name;

-- 24. From the following tables write a SQL query to calculate and find the average price of items of each company higher than or equal to Rs. 350. Return average value and company name.
SELECT com.com_name,
       AVG(pro_price) AS average_price
FROM company_mast com
INNER JOIN item_mast item ON com.com_id = item.pro_com
GROUP BY com.com_name
HAVING AVG(pro_price) >= 350;

-- 25. From the following tables write a SQL query to find the most expensive product of each company. Return pro_name, pro_price and com_name.
SELECT item.pro_name,
       item.pro_price,
       com.com_name
FROM item_mast item
INNER JOIN company_mast com ON item.pro_com = com.com_id 
           AND item.pro_price = (SELECT MAX(pro_price) 
                                 FROM item_mast 
                                 WHERE item_mast.pro_com = com.com_id);

-- 26. From the following tables write a SQL query to display all the data of employees including their department.
SELECT *
FROM emp_details det
INNER JOIN emp_department dep ON det.emp_dept = dep.dpt_code;  

-- 27. From the following tables write a SQL to display the first name and last name of each employee, along with the name and sanction amount for their department
SELECT det.emp_fname AS "First name",
       det.emp_lname AS "Last name",
       dep.dpt_name AS Department,
       dep.dpt_allotment AS "Sanction amount"
FROM emp_details det
INNER JOIN emp_department dep ON det.emp_dept = dep.dpt_code;

-- 28. From the following tables write a SQL query to find the departments with a budget more than Rs. 50000 and display the first name and last name of employees. 
SELECT det.emp_fname AS "First name",
       det.emp_lname AS "Last name"
FROM emp_details det
INNER JOIN emp_department dep ON det.emp_dept = dep.dpt_code
WHERE dep.dpt_allotment > 50000;

-- 29. From the following tables write a SQL query to find the names of departments where more than two employees are working. Return dpt_name.
SELECT dep.dpt_name
FROM emp_department dep 
INNER JOIN emp_details det ON dep.dpt_code = det.emp_dept
GROUP BY dep.dpt_name
HAVING COUNT(det.emp_idno) > 2;