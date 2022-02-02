/*
w3resource SQL exercises

Filtering and sorting on HR database (38 exercises)
https://www.w3resource.com/sql-exercises/sorting-and-filtering-hr/index.php
*/

-- 1. From the following table, write a SQL query to find those employees whose salary is less than 6000. Return full name (first and last name), and salary.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       salary
FROM employees
WHERE salary < 6000;

-- 2. From the following table, write a SQL query to find those employees whose salary is higher than 8000. Return first name, last name and department number and salary.
SELECT first_name,
       last_name,
       department_id,
       salary
FROM employees
WHERE salary > 8000;

-- 3. From the following table, write a SQL query to find those employees whose last name is "McEwen". Return first name, last name and department ID. 
SELECT first_name,
       last_name,
       department_id
FROM employees
WHERE last_name = 'McEwen';

-- 4. From the following table, write a SQL query to find those employees who have no department number. Return employee_id, first_name, last_name, email,phone_number,hire_date, job_id, salary,commission_pct,manager_id and department_id.
SELECT *
FROM employees
WHERE department_id IS NULL;

-- 5. From the following table, write a SQL query to find the details of 'Marketing' department. Return all fields
SELECT *
FROM departments
WHERE department_name = 'Marketing';

-- 6. From the following table, write a SQL query to find those employees whose first name does not contain the letter ‘M’. Sort the result-set in ascending order by department ID. Return full name (first and last name together), hire_date, salary and department_id.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       hire_date,
       salary,
       department_id
FROM employees
WHERE first_name NOT LIKE '%M%' 
ORDER by department_id;

-- 7. From the following table, write a SQL query to find those employees whose salary is in the range of 8000, 12000 (Begin and end values are included.) and get some commission. 
--    These employees have joined before ‘1987-06-05’ and not included in the department number 40, 120 and 70. Return all fields.
SELECT *
FROM employees 
WHERE salary BETWEEN 8000 AND 12000 
      AND commission_pct IS NOT NULL
      OR hire_date < '1987-06-05'
      AND department_id NOT IN (40, 70, 120);

-- 8. From the following table, write a SQL query to find those employees who do not earn any commission.Return full name (first and last name), and salary
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       salary
FROM employees
WHERE commission_pct IS NULL;

-- 9.  From the following table, write a SQL query to find those employees whose salary is in the range 9000,17000 (Begin and end values are included). Return full name, contact details and salary.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       CONCAT(phone_number, ' - ', email) AS contact_details,
       salary AS remuneration       
FROM employees
WHERE salary between 9000 AND 17000;

-- 10. From the following table, write a SQL query to find those employees whose first name ends with the letter ‘m’. Return the first and last name, and salary.
SELECT first_name, 
       last_name,
       salary
FROM employees
WHERE first_name LIKE '%m';

-- 11. From the following table, write a SQL query to find those employees whose salary is not in the range 7000 and 15000 (Begin and end values are included). Sort the result-set in ascending order by the full name (first and last). Return full name and salary.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       salary
FROM employees 
WHERE salary NOT BETWEEN 7000 AND 15000
ORDER BY first_name, last_name;

-- 12. From the following table, write a SQL query to find those employees who were hired during November 5th, 2007 and July 5th, 2009. Return full name (first and last), job id and hire date.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       job_id,
       hire_date
FROM employees 
WHERE hire_date BETWEEN '2007-11-5' AND '2009-07-5';

-- 13. From the following table, write a SQL query to find those employees who works either in department 70 or 90. Return full name (first and last name), department id.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       department_id
FROM employees 
WHERE department_id IN (70, 90);

-- 14. From the following table, write a SQL query to find those employees who work under a manager. Return full name (first and last name), salary, and manager ID.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       salary,
       manager_id
FROM employees 
WHERE manager_id <> 0;

-- 15. From the following table, write a SQL query to find those employees who were hired before June 21st, 2002. Return all fields.
SELECT *
FROM employees
WHERE hire_date < '2002-06-21';

-- 16.  From the following table, write a SQL query to find those employees whose managers hold the ID 120 or 103 or 145. Return first name, last name, email, salary and manager ID.
SELECT first_name,
       last_name,
       email,
       salary,
       manager_id
FROM employees
WHERE manager_id IN (120, 103, 145);

-- 17. From the following table, write a SQL query to find those employees whose first name contains the letters D, S, or N. Sort the result-set in descending order by salary. Return all fields.
SELECT *
FROM employees
WHERE first_name LIKE '%D%'
      OR first_name LIKE '%S%'
      OR first_name LIKE '%N%'
ORDER BY salary DESC;

-- 18. From the following table, write a SQL query to find those employees who earn above 11000 or the seventh character in their phone number is 3. Sort the result-set in descending order by first name. 
--     Return full name (first name and last name), hire date, commission percentage, email, and telephone separated by '-', and salary. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       hire_date,
       commission_pct,
       CONCAT(phone_number, ' - ', email) AS contact_details,
       salary   
FROM employees 
WHERE salary > 11000
      OR SUBSTRING(phone_number, 7, 1) = '3'
ORDER BY first_name DESC;

-- 19. From the following table, write a SQL query to find those employees whose first name contains a character ‘s’ in 3rd position. Return first name, last name and department id.
SELECT first_name,
       last_name,
       department_id
FROM employees
WHERE first_name LIKE '__s%';

-- 20. From the following table, write a SQL query to find those employees who are working in the departments, which are not included in the department number 50 or 30 or 80. Return employee_id, first_name, job_id, department_id
SELECT employee_id,
       first_name,
       job_id,
       department_id
FROM employees
WHERE department_id NOT IN (30, 50, 80);

-- 21. From the following table, write a SQL query to find those employees whose department numbers are included in 30 or 40 or 90. Return employee id, first name, job id, department id.
SELECT employee_id,
       first_name,
       job_id,
       department_id
FROM employees
WHERE department_id IN (30, 40, 90);

-- 22. From the following table, write a SQL query to find those employees who worked more than two jobs in the past. Return employee id.
SELECT employee_id
FROM job_history
GROUP BY employee_id
HAVING COUNT(*) >= 2;

-- 23. From the following table, write a SQL query to count the number of employees, sum of all salary, and difference between the highest salary and lowest salary by each job id. Return job_id, count, sum, salary_difference.
SELECT job_id,
       COUNT(employee_id),
       SUM(salary),
       MAX(salary) - MIN(salary) AS salary_difference
FROM employees
GROUP BY job_id;

-- 24.  From the following table, write a SQL query to find each job ids where two or more employees worked for more than 300 days. Return job id.
SELECT job_id
FROM job_history
WHERE (end_date - start_date) > 300
GROUP BY job_id
HAVING COUNT(employee_id) >= 2;   

-- 25. From the following table, write a SQL query to count the number of cities in each country has. Return country ID and number of cities.
SELECT country_id,
       COUNT(city)
FROM locations
GROUP BY country_id;

-- 26. From the following table, write a SQL query to count the number of employees worked under each manager. Return manager ID and number of employees.
SELECT manager_id,
       COUNT(employee_id)
FROM employees
GROUP BY manager_id;

-- 27. From the following table, write a SQL query to find all jobs. Sort the result-set in descending order by job title. Return all fields.
SELECT *
FROM jobs
ORDER BY job_title DESC;

-- 28. From the following table, write a SQL query to find all those employees who are either Sales Representative or Salesman. Return first name, last name and hire date.
SELECT first_name, 
       last_name,
       hire_date
FROM employees
WHERE job_id IN ('SA_MAN', 'SA_REP');

-- 29. From the following table, write a SQL query to calculate average salary of those employees for each department who get a commission percentage. Return department id, average salary. 
SELECT department_id,
       AVG(salary)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;

-- 30. From the following table, write a SQL query to find those departments where a manager can manage four or more employees. Return department_id. 
SELECT DISTINCT department_id
FROM employees
GROUP BY department_id, manager_id
HAVING COUNT(employee_id) >= 4;

-- 31. From the following table, write a SQL query to find those departments where more than ten employees work, who got a commission percentage. Return department id.
SELECT department_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id
HAVING COUNT(employee_id) >= 10;

-- 32. From the following table, write a SQL query to find those employees who have completed their previous jobs. Return employee ID, end_date.
SELECT employee_id, 
       MAX(end_date)
FROM job_history
WHERE employee_id IN (SELECT employee_id
                      FROM job_history
                      GROUP BY 1
                      HAVING COUNT(employee_id) > 1)
GROUP BY 1;

-- 33. From the following table, write a SQL query to find those employees who have no commission percentage and salary within the range 7000, 12000 (Begin and end values are included.) and works in the department number 50. Return all the fields of employees.
SELECT * 
FROM employees
WHERE commission_pct IS NULL
      AND salary BETWEEN 7000 AND 12000
      AND department_id = 50;

-- 34. From the following table, write a SQL query to compute the average salary of each job ID. Exclude those records where average salary is higher than 8000. Return job ID, average salary.
SELECT job_id,
       AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 8000;

-- 35. From the following table, write a SQL query to find those job titles where the difference between minimum and maximum salaries is in the range the range 12000, 18000 (Begin and end values are included.). Return job_title, max_salary-min_salary.
SELECT job_title,
       (max_salary - min_salary) AS salary_differences
FROM jobs
WHERE (max_salary - min_salary) BETWEEN 12000 AND 18000;

-- 36. From the following table, write a SQL query to find those employees whose first name or last name starts with the letter ‘D’. Return first name, last name
SELECT first_name,
       last_name
FROM employees
WHERE first_name LIKE 'D%' 
      OR last_name LIKE 'D%';

-- 37. From the following table, write a SQL query to find details of those jobs where minimum salary exceeds 9000. Return all the fields of jobs.
SELECT *
FROM jobs
WHERE min_salary > 9000;

-- 38. From the following table, write a SQL query to find those employees who joined after 7th September 1987. Return all the fields.
SELECT *
FROM employees
WHERE hire_date > '1987-09-07';







       