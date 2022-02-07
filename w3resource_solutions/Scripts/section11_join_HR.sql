/*
w3resource SQL exercises

JOIN on HR database (27 exercises)
https://www.w3resource.com/sql-exercises/joins-hr/index.php
*/

-- 1. From the following tables, write a SQL query to find the first name, last name, department number, and department name for each employee.
SELECT emp.first_name,
       emp.last_name,
       emp.department_id,
       dep.department_name
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id;

-- 2. From the following tables, write a SQL query to find the first name, last name, department, city, and state province for each employee.
SELECT emp.first_name,
       emp.last_name,
       dep.department_name,
       loc.city,
       loc.state_province
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id;

-- 3. From the following table, write a SQL query to find the first name, last name, salary, and job grade for all employees.
SELECT emp.first_name,
       emp.last_name,
       emp.salary,
       grade.grade_level
FROM employees emp
INNER JOIN job_grades grade ON emp.salary BETWEEN grade.lowest_sal AND grade.highest_sal
ORDER BY grade.grade_level; 

-- 4. From the following tables, write a SQL query to find all those employees who work in department ID 80 or 40. Return first name, last name, department number and department name.
SELECT emp.first_name,
       emp.last_name,
       emp.department_id,
       dep.department_name
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
WHERE emp.department_id IN (80, 40)
ORDER BY emp.last_name;

-- 5. From the following tables, write a SQL query to find those employees whose first name contains a letter ‘z’. Return first name, last name, department, city, and state province.
SELECT emp.first_name,
       emp.last_name,
       dep.department_name,
       loc.city,
       loc.state_province
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
WHERE first_name LIKE '%z%';

-- 6. From the following table, write a SQL query to find all departments including those without any employee. Return first name, last name, department ID, department name. 
SELECT emp.first_name,
       emp.last_name,
       dep.department_id,
       dep.department_name
FROM employees emp
RIGHT JOIN departments dep ON emp.department_id = dep.department_id;

-- 7. From the following table, write a SQL query to find those employees who earn less than the employee of ID 182. Return first name, last name and salary.
SELECT a.first_name, 
       a.last_name, 
       a.salary 
FROM employees a
INNER JOIN employees b ON a.salary < b.salary AND b.employee_id = 182;

-- 8. From the following table, write a SQL query to find the employees and their managers. Return the first name of the employee and manager.
SELECT a.first_name,
       b.first_name
FROM employees a
INNER JOIN employees b ON a.manager_id = b.employee_id;

-- 9. From the following tables, write a SQL query to display the department name, city, and state province for each department.
SELECT dep.department_name,
       loc.city,
       loc.state_province
FROM departments dep
INNER JOIN locations loc ON dep.location_id = loc.location_id;

-- 10. From the following tables, write a SQL query to find those employees who have or not any department. Return first name, last name, department ID, department name.
SELECT emp.first_name,
       emp.last_name,
       dep.department_id,
       dep.department_name
FROM employees emp
LEFT JOIN departments dep ON emp.department_id = dep.department_id;


-- 11. From the following table, write a SQL query to find the employees and their managers. These managers do not work under any manager. Return the first name of the employee and manager.
SELECT *
FROM employees a
LEFT JOIN employees b ON a.manager_id = b.employee_id;


-- 12. From the following tables, write a SQL query to find those employees who work in a department where the employee of last name 'Taylor' works. Return first name, last name and department ID. 
SELECT a.first_name,
       a.last_name,
       a.department_id
FROM employees a
INNER JOIN employees b ON a.department_id = b.department_id
WHERE b.last_name = 'Taylor';

-- 13. From the following tables, write a SQL query to find those employees who joined on 1st January 1993 and leave on or before 31 August 1997. Return job title, department name, employee name, and joining date of the job.
SELECT job.job_title,
       dep.department_name,
       CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
       jobh.start_date
FROM job_history jobh
INNER JOIN employees emp ON jobh.employee_id = emp.employee_id
INNER JOIN jobs job ON emp.job_id = job.job_id
INNER JOIN departments dep ON emp.department_id = dep.department_id
WHERE jobh.start_date BETWEEN '1993-01-01' AND '1997-08-31';

-- 14. From the following tables, write a SQL query to find the difference between maximum salary of the job and salary of the employees. Return job title, employee name, and salary difference. 
SELECT job.job_title,
       CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
       (job.max_salary - emp.salary) AS salary_difference
FROM jobs job
INNER JOIN employees emp USING (job_id);

-- 15. From the following table, write a SQL query to compute the average salary, number of employees received commission in that department. Return department name, average salary and number of employees.
SELECT dep.department_name,
       AVG(emp.salary),
       COUNT(emp.employee_id)
FROM departments dep
INNER JOIN employees emp USING (department_id)
WHERE emp.commission_pct IS NOT NULL
GROUP BY dep.department_id;

-- 16. From the following tables, write a SQL query to compute the difference between maximum salary and salary of all the employees who works the department of ID 80. Return job title, employee name and salary difference
SELECT jobs.job_title,
       CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
       (jobs.max_salary - emp.salary) AS salary_difference
FROM jobs
INNER JOIN employees emp USING (job_id)
WHERE emp.department_id = 80;

-- 17. From the following table, write a SQL query to find the name of the country, city, and departments, which are running there.
SELECT count.country_name,
       loc.city,
       dep.department_name
FROM countries count
INNER JOIN locations loc ON count.country_id = loc.country_id
INNER JOIN departments dep ON loc.location_id = dep.location_id;

-- 18. From the following tables, write a SQL query to find the department name and the full name (first and last name) of the manager.
SELECT dep.department_name,
       CONCAT(emp.first_name, ' ', emp.last_name) AS manager_name
FROM departments dep
INNER JOIN employees emp ON dep.manager_id = emp.employee_id;

-- 19. From the following table, write a SQL query to compute the average salary of employees for each job title
SELECT jobs.job_title,
       AVG(emp.salary)
FROM jobs 
INNER JOIN employees emp ON jobs.job_id = emp.job_id
GROUP BY jobs.job_title;

-- 20. From the following table, write a SQL query to find those employees who earn $12000 and above. Return employee ID, starting date, end date, job ID and department ID.
SELECT emp.employee_id,
       hist.start_date,
       hist.end_date,
       hist.job_id,
       hist.department_id
FROM employees emp
INNER JOIN job_history hist ON emp.employee_id = hist.employee_id
WHERE emp.salary > 12000;

-- 21. From the following tables, write a SQL query to find those departments where at least 2 employees work. Group the result set on country name and city. Return country name, city, and number of departments.
SELECT count.country_name,
       loc.city,
       COUNT(emp.employee_id)
FROM countries count
INNER JOIN locations loc USING(country_id)
INNER JOIN departments dep USING(location_id)
INNER JOIN employees emp USING(department_id)
GROUP BY count.country_name, loc.city
HAVING COUNT(emp.employee_id) >= 2;

-- 22. From the following tables, write a SQL query to find the department name, full name (first and last name) of the manager and their city.
SELECT dep.department_name,
       CONCAT(emp.first_name, ' ', emp.last_name) AS manager_name,
       loc.city
FROM departments dep
INNER JOIN employees emp ON dep.manager_id = emp.employee_id
INNER JOIN locations loc USING (location_id);

-- 23. From the following tables, write a SQL query to compute the number of days worked by employees in a department of ID 80. Return employee ID, job title, number of days worked.
SELECT hist.employee_id,
       jobs.job_title,
       (hist.end_date - hist.start_date) AS day_worked
FROM job_history hist
INNER JOIN jobs USING(job_id)
WHERE hist.department_id = 80;

-- 24. From the following tables, write a SQL query to find full name (first and last name), and salary of those employees who work in any department located in 'London' city. 
SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS full_name,
       emp.salary
FROM employees emp
INNER JOIN departments USING (department_id)
INNER JOIN locations loc USING (location_id)
WHERE loc.city = 'London';

-- 25. From the following tables, write a SQL query to find full name (first and last name), job title, starting and ending date of last jobs of employees who worked without a commission percentage. 
SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS full_name,
       jobs.job_title,
       hist.max_start_date,
       hist.max_end_date
FROM employees emp
INNER JOIN (SELECT MAX(start_date) AS max_start_date,
		   MAX(end_date) AS max_end_date,
		   employee_id 
            FROM job_history 
            GROUP BY employee_id) hist ON emp.employee_id = hist.employee_id
INNER JOIN jobs ON emp.job_id = jobs.job_id
WHERE emp.commission_pct = 0;

-- 26. From the following tables, write a SQL query to find the department name, department ID, and number of employees in each department
SELECT dep.department_name,
       dep.department_id,
       COUNT(emp.employee_id)
FROM departments dep
INNER JOIN employees emp USING (department_id)
GROUP BY dep.department_name, dep.department_id
ORDER BY dep.department_id;

-- 27. From the following tables, write a SQL query to find the full name (first and last name) of the employee with ID and name of the country presently where he/she is working.
SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS full_name,
       emp.employee_id,
       count.country_name
FROM countries count
INNER JOIN locations loc USING(country_id)
INNER JOIN departments dep USING(location_id)
INNER JOIN employees emp USING(department_id);