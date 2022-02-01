﻿/*
w3resource SQL exercises

SQL subqueries (39 exercises)
https://www.w3resource.com/sql-exercises/subqueries/index.php
*/

-- 1. From the following tables, write a SQL query to find all the orders issued by the salesman 'Paul Adam'. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT orders.ord_no,
       orders.purch_amt,
       orders.ord_date,
       orders.customer_id,
       orders.salesman_id
FROM orders
INNER JOIN salesman ON orders.salesman_id = salesman.salesman_id
WHERE salesman.name = 'Paul Adam'; 

-- 2. From the following tables, write a SQL query to find all the orders, which are generated by those salespeople, who live in the city of London.Return ord_no, purch_amt, ord_date, customer_id, salesman_id.
SELECT *
FROM orders
WHERE salesman_id IN (SELECT salesman_id 
		      FROM salesman 
		      WHERE city = 'London');

-- 3. From the following tables, write a SQL query to find the orders generated by the salespeople who may work for customers whose id is 3007. Return ord_no, purch_amt, ord_date, customer_id, salesman_id. 
SELECT *
FROM orders
WHERE salesman_id IN (SELECT salesman_id 
		      FROM salesman 
		      WHERE customer_id = 3007);

-- 4. From the following tables, write a SQL query to find the order values greater than the average order value of 10th October 2012. Return ord_no, purch_amt, ord_date, customer_id, salesman_id. 
SELECT *
FROM orders
WHERE purch_amt > (SELECT AVG(purch_amt)
	           FROM orders
	           WHERE ord_date = '2012-10-10'
	           GROUP BY ord_date);

-- 5. From the following tables, write a SQL query to find all the orders generated in New York city. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.   
SELECT *
FROM orders 
WHERE salesman_id IN (SELECT salesman_id 
		      FROM salesman 
		      WHERE city = 'New York');

-- 6. From the following tables, write a SQL query to find the commission of the salespeople work in Paris City. Return commission. 
SELECT commission
FROM salesman 
WHERE salesman_id IN (SELECT salesman_id 
		      FROM customer 
		      WHERE city = 'Paris');

-- 7. Write a query to display all the customers whose id is 2001 below the salesman ID of Mc Lyon.
SELECT *
FROM customer
WHERE customer_id = (SELECT salesman_id - 2001
		     FROM salesman
		     WHERE name = 'Mc Lyon');

-- 8. From the following tables, write a SQL query to count number of customers with grades above the average grades of New York City. Return grade and count. 
SELECT grade,
       COUNT(*)
FROM customer
GROUP BY grade
HAVING grade > (SELECT AVG(grade)
	       FROM customer
	       WHERE city = 'New York');

-- 9. From the following tables, write a SQL query to find those salespeople who earned the maximum commission. Return ord_no, purch_amt, ord_date, and salesman_id.
SELECT ord_no,
       purch_amt,
       ord_date,
       salesman_id
FROM orders
WHERE salesman_id IN (SELECT salesman_id 
                      FROM salesman
                      WHERE commission = (SELECT MAX(commission) FROM salesman));

-- 10. From the following tables, write a SQL query to find the customers whose orders issued on 17th August, 2012. Return ord_no, purch_amt, ord_date, customer_id, salesman_id and cust_name. 
SELECT orders.*,
       customer.cust_name
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
WHERE ord_date = '2012-08-17';

-- 11. From the following tables, write a SQL query to find the salespeople who had more than one customer. Return salesman_id and name.
SELECT salesman_id,
       name
FROM salesman
WHERE salesman_id IN (SELECT salesman_id
		      FROM customer
		      GROUP BY salesman_id
		      HAVING COUNT(*) > 1);

-- 12. From the following tables, write a SQL query to find those orders, which are higher than average amount of the orders. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT *
FROM orders x
WHERE purch_amt > (SELECT AVG(purch_amt)
                   FROM orders y
                   WHERE x.customer_id = y.customer_id);

-- 13. From the following tables, write a SQL query to find those orders, which are equal or higher than average amount of the orders. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT *
FROM orders x
WHERE purch_amt >= (SELECT AVG(purch_amt)
                    FROM orders y
                    WHERE x.customer_id = y.customer_id);
                   
                   
-- 14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date. 
SELECT ord_date,
       SUM(purch_amt)
FROM orders 
GROUP BY ord_date
HAVING SUM(purch_amt) > 1000 + MAX(purch_amt);

-- 15. Write a query to extract all data from the customer table if and only if one or more of the customers in the customer table are located in London.
SELECT customer_id,
       cust_name, 
       city
FROM customer
WHERE EXISTS (SELECT *
              FROM customer 
              WHERE city='London');

-- 16. From the following tables, write a SQL query to find the salespeople who deal multiple customers. Return salesman_id, name, city and commission.
SELECT DISTINCT *
FROM salesman
WHERE salesman_id IN (SELECT salesman_id
                      FROM customer
                      GROUP BY salesman_id
                      HAVING COUNT(*) > 1);

-- 17. From the following tables, write a SQL query to find the salespeople who deal a single customer. Return salesman_id, name, city and commission.
SELECT DISTINCT *
FROM salesman
WHERE salesman_id IN (SELECT salesman_id
                      FROM customer
                      GROUP BY salesman_id
                      HAVING COUNT(*) = 1);

-- 18. From the following tables, write a SQL query to find the salespeople who deal the customers with more than one order. Return salesman_id, name, city and commission. 
SELECT DISTINCT *
FROM salesman
WHERE salesman_id IN (SELECT customer.salesman_id
                      FROM customer
                      INNER JOIN orders ON customer.customer_id = orders.customer_id
                      GROUP BY customer.customer_id
                      HAVING COUNT(ord_no) > 1);
                         
-- 19. From the following tables, write a SQL query to find the salespeople who deals those customers who live in the same city. Return salesman_id, name, city and commission
SELECT *
FROM salesman x
WHERE salesman_id IN (SELECT DISTINCT y.salesman_id
                      FROM salesman y
                      INNER JOIN customer ON y.salesman_id = customer.salesman_id
                      WHERE y.city = customer.city);

-- 20. From the following tables, write a SQL query to find the salespeople whose place of living (city) matches with any of the city where customers live. Return salesman_id, name, city and commission.
SELECT *
FROM salesman
WHERE city IN (SELECT city FROM customer);

-- 21. From the following tables, write a SQL query to find all those salespeople whose name exist alphabetically after the customer’s name. Return salesman_id, name, city, commission.
SELECT *
FROM salesman a
WHERE EXISTS (SELECT *
	      FROM CUSTOMER b
	      WHERE  a.name  < b.cust_name);

-- 22.From the following table, write a SQL query to find all those customers who have a greater grade than any customer who belongs to the alphabetically lower than the city of New York. Return customer_id, cust_name, city, grade, salesman_id
SELECT *
FROM customer
WHERE grade > ANY(SELECT grade
                  FROM customer
                  WHERE city < 'New York');

-- 23. From the following table, write a SQL query to find all those orders whose order amount greater than at least one of the orders of September 10th 2012. Return ord_no, purch_amt, ord_date, customer_id and salesman_id
SELECT *
FROM orders
WHERE purch_amt > ANY(SELECT purch_amt
                      FROM orders
                      WHERE ord_date = '2012-09-10');

-- 24. From the following tables, write a SQL query to find those orders where an order amount less than any order amount of a customer lives in London City. Return ord_no, purch_amt, ord_date, customer_id and salesman_id. 
SELECT *
FROM orders
WHERE purch_amt < ANY(SELECT purch_amt
		      FROM orders
		      INNER JOIN customer ON orders.customer_id = customer.customer_id
		      WHERE city = 'London');

-- 25. From the following tables, write a SQL query to find those orders where every order amount less than the maximum order amount of a customer lives in London City. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
SELECT *
FROM orders
WHERE purch_amt < (SELECT MAX(purch_amt)
		   FROM orders
		   INNER JOIN customer ON orders.customer_id = customer.customer_id
		   WHERE city = 'London'
		   GROUP BY city);

-- 26. From the following tables, write a SQL query to find those customers whose grade are higher than customers living in New York City. Return customer_id, cust_name, city, grade and salesman_id.
SELECT *
FROM customer
WHERE grade > ALL(SELECT grade
	          FROM customer
	          WHERE city = 'New York');
-- 27. From the following tables, write a SQL query to calculate the total order amount generated by a salesman. The salesman should belong to the cities where any of the customer living. Return salesman name, city and total order amount
SELECT salesman.name,
       salesman.city,
       SUM(orders.purch_amt)
FROM salesman
INNER JOIN orders ON salesman.salesman_id = orders.salesman_id
WHERE salesman.city IN (SELECT city 
			FROM customer)
GROUP BY salesman.name, salesman.city;
	         
-- 28. From the following tables, write a SQL query to find those customers whose grade doesn't same of those customers live in London City. Return customer_id, cust_name, city, grade and salesman_id.
SELECT *
FROM customer
WHERE grade NOT IN (SELECT grade 
		    FROM customer 
		    WHERE city = 'London'
		          AND grade IS NOT NULL);

-- 29. From the following tables, write a SQL query to find those customers whose grade are not same of those customers living in Paris. Return customer_id, cust_name, city, grade and salesman_id.
SELECT *
FROM customer
WHERE grade NOT IN (SELECT grade 
		    FROM customer 
		    WHERE city = 'Paris'
		          AND grade IS NOT NULL);		          

-- 30. From the following tables, write a SQL query to find all those customers who have different grade than any customer lives in Dallas City. Return customer_id, cust_name,city, grade and salesman_id.
SELECT *
FROM customer
WHERE grade NOT IN (SELECT grade 
		    FROM customer 
		    WHERE city = 'Dallas City'
		          AND grade IS NOT NULL);

-- 31. From the following tables, write a SQL query to find the average price of each manufacturer's product along with their name. Return Average Price and Company.
SELECT com.com_name,
       AVG(pro_price)
FROM company_mast com
INNER JOIN item_mast item ON com.com_id = item.pro_com
GROUP BY com.com_name;

-- 32. From the following tables, write a SQL query to calculate the average price of the products and find price which are more than or equal to 350. Return Average Price and Company.
SELECT com.com_name,
       AVG(item.pro_price)
FROM company_mast com
INNER JOIN item_mast item ON com.com_id = item.pro_com
GROUP BY com.com_name
HAVING AVG(item.pro_price) > 350;

-- 33. From the following tables, write a SQL query to find the most expensive product of each company. Return Product Name, Price and Company.
SELECT item.pro_name,
       item.pro_price,
       com.com_name
FROM item_mast item
INNER JOIN company_mast com ON item.pro_com = com.com_id 
           AND item.pro_price = (SELECT MAX(pro_price) 
                                 FROM item_mast 
                                 WHERE item_mast.pro_com = com.com_id);

-- 34. From the following tables, write a SQL query to find those employees whose last name is 'Gabriel' or 'Dosio'. Return emp_idno, emp_fname, emp_lname and emp_dept.
SELECT emp_idno,
       emp_fname,
       emp_lname,
       emp_dept
FROM emp_details
WHERE emp_lname IN ('Gabriel', 'Dosio');

-- 35. From the following tables, write a SQL query to find the employees who work in department 89 or 63. Return emp_idno, emp_fname, emp_lname and emp_dept.
SELECT *
FROM emp_details
WHERE emp_dept IN (89, 63);

-- 36. From the following tables, write a SQL query to find those employees who work for the department where the department allotment amount is more than Rs. 50000. Return emp_fname and emp_lname.
SELECT emp_fname,
       emp_lname
FROM emp_details det
INNER JOIN emp_department dep ON det.emp_dept = dep.dpt_code
WHERE dpt_allotment > 50000;

-- 37. From the following tables, write a SQL query to find the departments where the sanction amount is higher than the average sanction amount of all the departments. Return dpt_code, dpt_name and dpt_allotment.
SELECT *
FROM emp_department
WHERE dpt_allotment > (SELECT AVG(dpt_allotment) FROM emp_department);

-- 38. From the following tables, write a SQL query to find the departments where more than two employees work. Return dpt_name.
SELECT dpt_name
FROM emp_department 
WHERE dpt_code IN (SELECT emp_dept 
                   FROM emp_details
                   GROUP BY emp_dept
                   HAVING COUNT(emp_idno) > 2);

-- 39. From the following tables, write a SQL query to find the departments where the sanction amount is second lowest. Return emp_fname and emp_lname.
SELECT emp_fname,
       emp_lname
FROM emp_details det
INNER JOIN emp_department dep ON det.emp_dept = dep.dpt_code
WHERE dpt_allotment = (SELECT MIN(dpt_allotment) 
		       FROM (SELECT dpt_allotment 
		             FROM emp_department 
		             WHERE dpt_allotment > (SELECT MIN(dpt_allotment) FROM emp_department)
		             ) t

		      );

















