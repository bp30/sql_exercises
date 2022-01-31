/*
w3resource SQL exercises

Wildcard and Special Operations (22 exercises)
https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
*/

-- 1. From the following table, write a SQL query to find the details of those salespeople who come from the 'Paris' City or 'Rome' City. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE city IN ('Paris', 'Rome');

-- 2. From the following table, write a SQL query to find the details of those salespeople who come from any of the City 'Paris' or 'Rome'. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE city IN ('Paris', 'Rome');

-- 3. From the following table, write a SQL query to find the details of those salespeople who live in cities apart from 'Paris' and 'Rome'. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE city NOT IN ('Paris', 'Rome');

-- 4. From the following table, write a SQL query to find the details of the customers whose ID belongs to any of the values 3007, 3008 and 3009. Return customer_id, cust_name, city, grade, and salesman_id.
SELECT *
FROM customer
WHERE customer_id BETWEEN 3007 AND 3009;

-- 5. From the following table, write a SQL query to find the details of salespeople who get the commission in the range from 0.12 to 0.14 (begin and end values are included). Return salesman_id, name, city, and commission.
SELECT *
FROM salesman
WHERE commission BETWEEN 0.12 AND 0.14;

-- 6. From the following table, write a SQL query to select orders value within a range 500, 4000 (begin and end values are included). Exclude orders amount 948.50 and 1983.43. Return ord_no, purch_amt, ord_date, customer_id, and salesman_id. 
SELECT *
FROM orders
WHERE (purch_amt BETWEEN 500 AND 4000) 
       AND purch_amt NOT IN (948.5, 1983.43);

-- 7. From the following table, write a SQL query to find the details of those salespeople whose name starts with any letter within 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE name > 'A' 
      AND name < 'L';


--- 8. From the following table, write a SQL query to find the details of all salespeople except whose name starts with any letter within 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE name NOT BETWEEN 'A' AND 'L';

-- 9. From the following table, write a SQL query to find the details of the customers whose name begins with the letter 'B'. Return customer_id, cust_name, city, grade, salesman_id.
SELECT *
FROM customer
WHERE cust_name LIKE 'B%';

-- 10. From the following table, write a SQL query to find the details of the customers whose names end with the letter 'n'. Return customer_id, cust_name, city, grade, salesman_id
SELECT *
FROM customer
WHERE cust_name LIKE '%n';

-- 11. From the following table, write a SQL query to find the details of those salespeople whose name starts with ‘N’ and the fourth character is 'l'. Rests may be any character. Return salesman_id, name, city, commission.
SELECT * 
FROM salesman
WHERE name LIKE 'N__l%';

-- 12. From the following table, write a SQL query to find those rows where col1 contains the escape character underscore ( _ ). Return col1.
SELECT col1
FROM testtable
WHERE col1 LIKE '%/_%' ESCAPE '/';

-- 13. From the following table, write a SQL query to find those rows where col1 does not contain the escape character underscore ( _ ). Return col1.  
SELECT col1
FROM testtable
WHERE col1 NOT LIKE '%/_%' ESCAPE '/';

-- 14. From the following table, write a SQL query to find those rows where col1 contains the forward slash character ( / ). Return col1.
SELECT *
FROM testtable
WHERE col1 LIKE '%//%' ESCAPE '/';

-- 15. From the following table, write a SQL query to find those rows where col1 does not contain the forward slash character ( / ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE '%//%' ESCAPE '/';

-- 16. From the following table, write a SQL query to find those rows where col1 contains the string ( _/ ). Return col1.
SELECT *
FROM testtable
WHERE col1 LIKE '%/_//%' ESCAPE '/';

-- 17. From the following table, write a SQL query to find those rows where col1 does not contain the string ( _/ ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE '%/_//%' ESCAPE '/';

-- 18. From the following table, write a SQL query to find those rows where col1 contains the character percent ( % ). Return col1. 
SELECT *
FROM testtable
WHERE col1 LIKE '%/%%' ESCAPE'/';

-- 19. From the following table, write a SQL query to find those rows where col1 does not contain the character percent ( % ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE '%/%%' ESCAPE'/';

-- 20. From the following table, write a SQL query to find all those customers who does not have any grade. Return customer_id, cust_name, city, grade, salesman_id.
SELECT * 
FROM customer
WHERE grade IS NULL;

-- 21. From the following table, write a SQL query to find all those customers whose grade value exists. Return customer_id, cust_name, city, grade, salesman_id.  
SELECT * 
FROM customer
WHERE grade IS NOT NULL;

-- 22. From the following table, write a SQL query to find the employees whose last name begins with the character 'D'. Return emp_idno, emp_fname, emp_lname and emp_dept.
SELECT * 
FROM emp_details
WHERE emp_lname LIKE 'D%';





