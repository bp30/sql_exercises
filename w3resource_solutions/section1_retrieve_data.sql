/*
w3resource SQL exercises

Retrieve data from tables (33 exercises)
https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
*/

-- 1.  Write a SQL statement to display all the information of all salesmen
SELECT *
FROM salesman;

-- 2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".
SELECT "This is SQL Exercise, Practice and Solution";

-- 3. Write a query to display three numbers in three columns. 
SELECT 10, 20, 30;

-- 4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
SELECT 10 + 15;

-- 5. Write a query to display the result of an arithmetic expression. 
SELECT 10 * 10;

-- 6. Write a SQL statement to display specific columns like name and commission for all the salesmen.  
SELECT salesman_id,
       name,
       commission
FROM salesman;

-- 7. Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders. 
SELECT ord_date,
       salesman_id,
       ord_no,
       purch_amt
FROM orders;

-- 8.  From the following table, write a SQL query to find the unique salespeople ID. Return salesman_id.
SELECT DISTINCT salesman_id  
FROM orders;

-- 9. From the following table, write a SQL query to find the salespeople who lives in the City of 'Paris'. Return salesperson's name, city
SELECT name,
       city
FROM salesman
WHERE city = 'Paris';

-- 10. From the following table, write a SQL query to find those customers whose grade is 200. Return customer_id, cust_name, city, grade, salesman_id.
SELECT customer_id,
       cust_name,
       city, 
       grade, 
       salesman_id
FROM customer
WHERE grade = 200;

-- 11. From the following table, write a SQL query to find the orders, which are delivered by a salesperson of ID. 5001. Return ord_no, ord_date, purch_amt.
SELECT ord_no,
       ord_date,
       purch_amt
FROM orders
WHERE salesman_id = 5001;


-- 12.  From the following table, write a SQL query to find the Nobel Prize winner(s) in the year 1970. Return year, subject and winner.
SELECT year,
       subject,
       winner
FROM nobel_win
WHERE year = 1970;

-- 13. From the following table, write a SQL query to find the Nobel Prize winner in 'Literature' in the year 1971. Return winner. 
SELECT winner 
FROM nobel_win
WHERE subject = 'Literature' AND year = 1971;

-- 14. From the following table, write a SQL query to find the Nobel Prize winner 'Dennis Gabor'. Return year, subject.
SELECT year,
       subject
FROM nobel_win
WHERE WINNER = 'Dennis Gabor';

-- 15. From the following table, write a SQL query to find the Nobel Prize winners in 'Physics' since the year 1950. Return winner.
SELECT winner
FROM nobel_win
WHERE subject = 'Physics' AND year >= 1950;

-- 16. From the following table, write a SQL query to find the Nobel Prize winners in 'Chemistry' between the years 1965 to 1975. Begin and end values are included. Return year, subject, winner, and country
SELECT year,
       subject,
       winner,
       country
FROM nobel_win
WHERE subject = 'Chemistry' AND year BETWEEN 1965 AND 1975;

-- 17. Write a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin
SELECT *
FROM nobel_win
WHERE year > 1972
AND winner IN ('Menachem Begin', 'Yitzhak Rabin');


-- 18. From the following table, write a SQL query to find the details of the winners whose first name matches with the string 'Louis'. Return year, subject, winner, country, and category.
SELECT year,
       subject,
       winner,
       country,
       category
FROM nobel_win
WHERE winner LIKE 'Louis%';

-- 19. From the following table, write a SQL query to combine the winners in Physics, 1970 and in Economics, 1971. Return year, subject, winner, country, and category.
SELECT year,
       subject,
       winner,
       country, category
FROM nobel_win
WHERE (year = 1970 AND subject = 'Physics') 
      OR (year = 1971 AND subject = 'Economics');

-- 20. From the following table, write a SQL query to find the Nobel Prize winners in 1970 excluding the subjects Physiology and Economics. Return year, subject, winner, country, and category.
SELECT year,
       subject,
       winner,
       country,
       category
FROM nobel_win
WHERE year = 1970 
      AND subject NOT IN ('Physiology', 'Economics');

-- 21. From the following table, write a SQL query to combine the winners in 'Physiology' before 1971 and winners in 'Peace' on or after 1974. Return year, subject, winner, country, and category.
SELECT year,
       subject,
       winner,
       country,
       category
FROM nobel_win
WHERE (year < 1971 AND subject = 'Physiology')
      OR (year >= 1974 AND subject = 'Peace');

-- 22. From the following table, write a SQL query to find the details of the Nobel Prize winner 'Johannes Georg Bednorz'. Return year, subject, winner, country, and category.
SELECT year,
       subject,
       winner,
       country,
       category
FROM nobel_win
WHERE winner = 'Johannes Georg Bednorz';

-- 23. From the following table, write a SQL query to find the Nobel Prize winners for the subject not started with the letter 'P'. Return year, subject, winner, country, and category. Order the result by year, descending.
SELECT year,
       subject,
       winner, 
       country,
       category
FROM nobel_win
WHERE subject NOT LIKE 'P%' 
ORDER BY year DESC; 

-- 24. From the following table, write a SQL query to find the details of 1970 Nobel Prize winners. Order the result by subject, ascending except ‘Chemistry’ and ‘Economics’ which will come at the end of result set. Return year, subject, winner, country, and category. 
SELECT *
FROM nobel_win
WHERE year = 1970 
ORDER BY 
         CASE WHEN subject IN ('Economics', 'Chemistry') THEN 1
	      ELSE 0
         END ASC, 
         subject; 
         
-- 25. From the following table, write a SQL query to select a range of products whose price is in the range Rs.200 to Rs.600. Begin and end values are included. Return pro_id, pro_name, pro_price, and pro_com. 
SELECT *
FROM item_mast
WHERE pro_price BETWEEN 200 AND 600;

-- 26. From the following table, write a SQL query to calculate the average price for manufacturer code equal to 16. Return avg. 
SELECT AVG(pro_price) AS avg
FROM item_mast
WHERE pro_com = 16;

-- 27. From the following table, write a SQL query to display the pro_name as 'Item Name' and pro_priceas 'Price in Rs.'
SELECT pro_name AS "Item Name",
       pro_price AS "Price in Rs."
FROM item_mast;

-- 28. From the following table, write a SQL query to find the items whose prices are higher than or equal to $250. Order the result by product price in descending, then product name in ascending. Return pro_name and pro_price.
SELECT pro_name,
       pro_price
FROM item_mast
WHERE pro_price >= 250
ORDER BY pro_price DESC, pro_name;

-- 29. From the following table, write a SQL query to calculate average price of the items of each company. Return average price and company code
SELECT pro_com AS "Company Code",
       AVG(pro_price) AS "Average Product Price"
FROM item_mast
GROUP BY pro_com; 

-- 30. From the following table, write a SQL query to find the cheapest item(s). Return pro_name and, pro_price.
SELECT pro_name,
       pro_price
FROM item_mast
WHERE pro_price = (SELECT MIN(pro_price) FROM item_mast);

-- 31. From the following table, write a SQL query to find unique last name of all employees. Return emp_lname.
SELECT DISTINCT emp_lname
FROM emp_details;

-- 32. From the following table, write a SQL query to find the details of employees whose last name is 'Snares'. Return emp_idno, emp_fname, emp_lname, and emp_dept
SELECT *
FROM emp_details
WHERE emp_lname = 'Snares';

-- 33. From the following table, write a SQL query to find the details of the employees who work in the department 57. Return emp_idno, emp_fname, emp_lname and emp_dept.
SELECT *
FROM emp_details
WHERE emp_dept = 57;

      


