/*
w3resource SQL exercises

Subqueries on HR database (55 exercises)
https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php
*/

-- 1. From the following table, write a SQL query to find those employees who get higher salary than the employee whose ID is 163. Return first name, last name.
SELECT first_name,
       last_name
FROM employees
WHERE salary > (SELECT salary 
		FROM employees
		WHERE employee_id = 163);

-- 2. From the following table, write a SQL query to find those employees whose designation is the same as the employee whose ID is 169. Return first name, last name, department ID and job ID.
SELECT first_name,
       last_name,
       salary,
       department_id,
       job_id
FROM employees
WHERE job_id = (SELECT job_id 
		FROM employees
		WHERE employee_id = 169);

-- 3. From the following table, write a SQL query to find those employees whose salary matches the smallest salary of any of the departments. Return first name, last name and department ID.
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary IN (SELECT MIN(salary)
                 FROM employees
                 GROUP BY department_id);
-- 4. From the following table, write a SQL query to find those employees who earn more than the average salary. Return employee ID, first name, last name.
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE salary > (SELECT AVG(salary)
                 FROM employees);

-- 5. From the following table, write a SQL query to find those employees who report that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.
SELECT first_name,
       last_name,
       employee_id,
       salary
FROM employees
WHERE manager_id = (SELECT employee_id
		    FROM employees
		    WHERE first_name = 'Payam');
-- using self join to complete previous exercise 		 
SELECT a.first_name,
       a.last_name,
       a.employee_id,
       a.salary
FROM employees a
INNER JOIN employees b ON a.manager_id = b.employee_id
WHERE b.first_name = 'Payam';

-- 6. From the following tables, write a SQL query to find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.  
SELECT emp.department_id,
       emp.first_name,
       emp.job_id,
       dep.department_name
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
WHERE dep.department_name = 'Finance';

-- 7. From the following table, write a SQL query to find the employee whose salary is 3000 and reporting person’s ID is 121. Return all fields.
SELECT *
FROM employees
WHERE salary = 3000 
      AND manager_id = 121;

-- 8. From the following table, write a SQL query to find those employees whose ID matches any of the number 134, 159 and 183. Return all the fields.
SELECT *
FROM employees
WHERE employee_id IN (134, 159, 183);

-- 9. From the following table, write a SQL query to find those employees whose salary is in the range 1000, and 3000 (Begin and end values have included.). Return all the fields.
SELECT *
FROM employees
WHERE salary BETWEEN 1000 AND 3000;

-- 10. From the following table and write a SQL query to find those employees whose salary is in the range of smallest salary, and 2500. Return all the fields. 
SELECT *
FROM employees
WHERE salary BETWEEN (SELECT MIN(salary) 
		      FROM employees) AND 2500;

-- 11. From the following tables, write a SQL query to find those employees who do not work in those departments where manager ids are in the range 100, 200 (Begin and end values are included.) Return all the fields of the employees. 
SELECT *
FROM employees 
WHERE department_id NOT IN (SELECT department_id
                            FROM departments
                            WHERE manager_id BETWEEN 100 AND 200);        
-- 12. From the following table, write a SQL query to find those employees who get second-highest salary. Return all the fields of the employees. 
SELECT *
FROM employees 
WHERE salary = (SELECT MAX(salary)
		FROM (SELECT salary
		      FROM employees
		      WHERE salary < (SELECT MAX(salary)
		                      FROM employees)) AS t);
-- 13. From the following tables, write a SQL query to find those employees who work in the same department where ‘Clara’ works. Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date.                        
SELECT first_name,
       last_name,
       hire_date
FROM employees
WHERE department_id IN (SELECT department_id 
                        FROM employees
                        WHERE first_name = 'Clara')
      AND first_name <> 'Clara';

-- 14. From the following tables, write a SQL query to find those employees who work in a department where the employee’s first name contains a letter 'T'. Return employee ID, first name and last name
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE department_id IN (SELECT department_id 
			FROM employees
			WHERE first_name LIKE '%T%');

-- 15. From the following tables, write a SQL query to find those employees who earn more than the average salary and work in a department with any employee whose first name contains a character a 'J'. Return employee ID, first name and salary.
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE department_id IN (SELECT department_id 
			FROM employees
			WHERE first_name LIKE '%J%')
      AND salary > (SELECT AVG(salary)
                    FROM employees);

-- 16. From the following table, write a SQL query to find those employees whose department located at 'Toronto'. Return first name, last name, employee ID, job ID.                       
SELECT emp.first_name,
       emp.last_name,
       emp.employee_id,
       emp.job_id
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
WHERE loc.city = 'Toronto';

-- 17. From the following table, write a SQL query to find those employees whose salary is lower than any salary of those employees whose job title is ‘MK_MAN’. Return employee ID, first name, last name, job ID.
SELECT employee_id,
       first_name,
       last_name,
       job_id
FROM employees
WHERE salary < (SELECT MIN(salary)
	        FROM employees
	        WHERE job_id = 'MK_MAN');

-- 18. From the following table, write a SQL query to find those employees whose salary is lower than any salary of those employees whose job title is 'MK_MAN'. Exclude employees of Job title ‘MK_MAN’. Return employee ID, first name, last name, job ID.  	       
SELECT employee_id,
       first_name,
       last_name,
       job_id
FROM employees
WHERE salary < (SELECT MIN(salary)
	        FROM employees
	        WHERE job_id = 'MK_MAN')
      AND job_id <> 'MK_MAN';

-- 19. From the following table, write a SQL query to find those employees whose salary is more than any salary of those employees whose job title is 'PU_MAN'. Exclude job title 'PU_MAN'. Return employee ID, first name, last name, job ID.     
SELECT employee_id,
       first_name,
       last_name,
       job_id
FROM employees
WHERE salary > (SELECT MIN(salary)
	        FROM employees
	        WHERE job_id = 'PU_MAN')
      AND job_id <> 'PU_MAN';

-- 20. From the following table, write a SQL query to find those employees whose salary is more than average salary of any department. Return employee ID, first name, last name, job ID.
SELECT employee_id,
       first_name,
       last_name,
       job_id
FROM employees
WHERE salary > ALL(SELECT AVG(salary)
	           FROM employees
	           GROUP BY department_id);

-- 21. From the following table, write a SQL query to find any existence of those employees whose salary exceeds 3700. Return first name, last name and department ID.
SELECT first_name,
       last_name,
       department_id
FROM employees
WHERE salary > 3700;	           
		   
-- 22. From the following table, write a SQL query to find total salary of those departments where at least one employee works. Return department ID, total salary.
SELECT dep.department_id,
       SUM(emp.salary)
FROM departments dep
LEFT JOIN employees emp ON dep.department_id = emp.department_id
GROUP BY dep.department_id
HAVING COUNT(emp.employee_id) >= 1
ORDER BY dep.department_id;

-- 23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG. 
SELECT employee_id,
       first_name,
       last_name,
       CASE job_id WHEN 'ST_MAN' THEN 'SALESMEN'
                   WHEN 'IT_PROG' THEN 'DEVELOPER'
                   ELSE job_id
              END AS designation, 
       salary
FROM employees;

-- 24. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT employee_id,
       first_name,
       last_name,
       salary,
       CASE WHEN salary > (SELECT AVG(salary) FROM employees) THEN 'High'
            WHEN salary < (SELECT AVG(salary) FROM employees) THEN 'Low'
            ELSE 'Average'
       END AS salary_status
 FROM employees;

-- 25. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT employee_id,
       first_name,
       last_name,
       salary AS SalaryDrawn,
       salary - (SELECT AVG(salary) FROM employees) AS AvgCompare,
       CASE WHEN salary > (SELECT AVG(salary) FROM employees) THEN 'High'
            WHEN salary < (SELECT AVG(salary) FROM employees) THEN 'Low'
            ELSE 'Average'
       END AS salary_status
FROM employees;

-- 26. From the following table, write a SQL query to find all those departments where at least one or more employees work.Return department name.
SELECT department_name
FROM departments
WHERE department_id IN (SELECT DISTINCT department_id 
                        FROM employees);

-- 27. From the following tables, write a SQL query to find those employees who work in departments located at 'United Kingdom'. Return first name. 
SELECT DISTINCT emp.first_name
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
INNER JOIN countries count ON loc.country_id = count.country_id
WHERE count.country_name = 'United Kingdom';

-- 28. From the following table, write a SQL query to find those employees who earn more than average salary and who work in any of the 'IT' departments. Return last name. 
SELECT last_name
FROM employees
WHERE salary > (SELECT AVG(salary)
		FROM employees)
      AND department_id = (SELECT department_id
			   FROM departments
			   WHERE department_name = 'IT');
			   
-- 29. From the following table, write a SQL query to find all those employees who earn more than an employee whose last name is 'Ozer'. Sort the result in ascending order by last name. Return first name, last name and salary. 
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (SELECT salary
	        FROM employees
	        WHERE last_name = 'Ozer')
ORDER BY last_name;

-- 30. From the following tables, write a SQL query to find those employees who work under a manager based in ‘US’. Return first name, last name.
SELECT first_name,
       last_name 
FROM employees 
WHERE manager_id IN (SELECT employee_id
		     FROM employees 
		     WHERE department_id IN 
		    (SELECT department_id 
		     FROM departments 
		     WHERE location_id IN 
		    (SELECT location_id 
		     FROM locations 
		     WHERE country_id = 'US')));
-- 31. From the following tables, write a SQL query to find those employees whose salary is greater than 50% of their department's total salary bill. Return first name, last name.  
SELECT *
FROM employees a
WHERE salary > (SELECT AVG(salary) * 0.5 
                FROM employees b
                WHERE a.department_id = b.department_id);


-- 32. From the following tables, write a SQL query to find those employees who are managers. Return all the fields of employees table.
SELECT *
FROM employees
WHERE employee_id IN (SELECT manager_id
		      FROM departments);

-- 33. From the following table, write a SQL query to find those employees who manage a department. Return all the fields of employees table. 
SELECT *
FROM employees
WHERE employee_id IN (SELECT manager_id
		      FROM departments);

-- 34. From the following table, write a SQL query to find those employees who get such a salary, which is the maximum of salaried employee, joining within January 1st, 2002 and December 31st, 2003. 
--     Return employee ID, first name, last name, salary, department name and city. 
SELECT emp.employee_id,
       emp.first_name,
       emp.last_name,
       emp.salary,
       dep.department_name,
       loc.city
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
WHERE emp.salary = (SELECT MAX(salary)
		    FROM employees)
      AND emp.hire_date BETWEEN '2002-01-01' AND '2003-12-31';

-- 35. From the following tables, write a SQL query to find those departments, located in the city ‘London’. Return department ID, department name. 
SELECT department_id,
       department_name
FROM departments
WHERE location_id = (SELECT location_id
		     FROM locations
		     WHERE city = 'London');

-- 36.	From the following table, write a SQL query to find those employees who earn more than the average salary. Sort the result-set in descending order by salary. Return first name, last name, salary, and department ID. 	     
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees)
ORDER BY salary DESC; 

-- 37. From the following table, write a SQL query to find those employees who earn more than the maximum salary of a department of ID 40. Return first name, last name and department ID.                		
SELECT first_name,
       last_name,
       department_id
FROM employees
WHERE salary > (SELECT MAX(salary)
                FROM employees
                WHERE department_id = 40); 

-- 38. From the following table, write a SQL query to find departments for a particular location. The location matches the location of the department of ID 30. Return department name and department ID. 
SELECT department_name,
       department_id
FROM departments
WHERE location_id = (SELECT location_id
		     FROM departments
		     WHERE department_id = 30);

-- 39. From the following table, write a SQL query to find those employees who work in that department where the employee works of ID 201. Return first name, last name, salary, and department ID.
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE department_id = (SELECT department_id
		       FROM employees
		       WHERE employee_id = 201);

-- 40. From the following table, write a SQL query to find those employees whose salary matches to the salary of the employee who works in that department of ID 40. Return first name, last name, salary, and department ID. 
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary = (SELECT salary
		FROM employees
		WHERE department_id = 40);

-- 41. From the following table, write a SQL query to find those employees who work in the department 'Marketing'. Return first name, last name and department ID. 
SELECT first_name,
       last_name,
       department_id
FROM employees
WHERE department_id = (SELECT department_id
		       FROM departments
		       WHERE department_name = 'Marketing');
		       
-- 42. From the following table, write a SQL query to find those employees who earn more than the minimum salary of a department of ID 40. Return first name, last name, salary, and department ID.
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary > (SELECT MIN(salary)
		FROM employees
		WHERE department_id = 40);
		
-- 43. From the following table, write a SQL query to find those employees who joined after the employee whose ID is 165. Return first name, last name and hire date
SELECT first_name,
       last_name,
       hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
		   FROM employees
		   WHERE employee_id = 165);
		   
-- 44. From the following table, write a SQL query to find those employees who earn less than the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary < (SELECT MIN(salary)
		FROM employees
		WHERE department_id =70);

-- 45. From the following table, write a SQL query to find those employees who earn less than the average salary, and work at the department where the employee 'Laura' (first name) works.
--     Return first name, last name, salary, and department ID.
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary < (SELECT AVG(salary)
		FROM employees)
      AND department_id IN (SELECT department_id
			    FROM employees
			    WHERE first_name = 'Laura');
       
-- 46. From the following tables, write a SQL query to find those employees whose department is located in the city 'London'. Return first name, last name, salary, and department ID. 
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE department_id IN (SELECT dep.department_id
		        FROM departments dep
		        INNER JOIN locations loc ON dep.location_id = loc.location_id
		        WHERE loc.city = 'London');
 -- 47. From the following tables, write a SQL query to find the city of the employee of ID 134. Return city.
SELECT loc.city
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
WHERE employee_id = 134;

-- 48. From the following tables, write a SQL query to find those departments where maximum salary is 7000 and above. The employees worked in those departments have already completed one or more jobs. 
--     Return all the fields of the departments. 
SELECT *
FROM departments
WHERE department_id IN (SELECT department_id
			FROM employees
		        WHERE employee_id IN (SELECT employee_id
					      FROM job_history
					      GROUP BY employee_id
					      HAVING COUNT(employee_id) > 1)
GROUP BY department_id
HAVING MAX(salary) > 7000);  


-- 49. From the following tables, write a SQL query to find those departments where starting salary is at least 8000. Return all the fields of departments.
SELECT *
FROM departments
WHERE department_id IN (SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING MIN(salary) >= 8000);
                       
-- 50. From the following table, write a SQL query to find those managers who supervise four or more employees. Return manager name, department ID.
SELECT CONCAT(first_name, ' ', last_name) AS manager_name,
       department_id
FROM employees
WHERE employee_id IN (SELECT manager_id
		      FROM employees
	              GROUP BY manager_id
		      HAVING COUNT(employee_id) >= 4);


-- 51. From the following table, write a SQL query to find those employees who worked as a 'Sales Representative' in the past. Return all the fields of jobs.
SELECT DISTINCT jobs.*
FROM jobs
INNER JOIN employees emp ON jobs.job_id = emp.job_id
WHERE jobs.job_title = 'Sales Representative';

-- 52. From the following table, write a SQL query to find those employees who earn second-lowest salary of all the employees. Return all the fields of employees. 
SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM (SELECT salary
                      FROM employees
                      WHERE salary <> (SELECT MIN(salary)
                                       FROM employees)) AS t);
                                       
-- 53. From the following table, write a SQL query to find those departments managed by ‘Susan’. Return all the fields of departments.
SELECT * 
FROM departments 
WHERE manager_id IN (SELECT employee_id
		     FROM employees 
		     WHERE first_name = 'Susan')

-- 54. From the following table, write a SQL query to find those employees who earn highest salary in a department. Return department ID, employee name, and salary. 
SELECT department_id,
       CONCAT(first_name, ' ', last_name) AS employee_name,
       salary
FROM employees a
WHERE salary = (SELECT MAX(salary)
		FROM employees b
		WHERE a.department_id = b.department_id);

-- 55. From the following table, write a SQL query to find those employees who did not have any job in the past. Return all the fields of employees
SELECT *
FROM employees
WHERE employee_id NOT IN (SELECT employee_id
			  FROM job_history);
