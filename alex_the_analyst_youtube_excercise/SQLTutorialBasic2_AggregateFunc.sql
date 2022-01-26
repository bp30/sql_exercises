/* 
SELECT statement 
*, Top, Distinct, Count, As, Max, Min, Avg
https://www.youtube.com/watch?v=PyYgERKq25I&list=PLUaB-1hjhk8GT6N5ne2qpf603sF26m2PW&index=2
*/


-- Select all
SELECT *
FROM EmployeeDemographics;

-- Select top 5 rows
SELECT TOP 5 *
FROM EmployeeDemographics;

--Select distinct
SELECT DISTINCT(gender)
FROM EmployeeDemographics;

-- Count
SELECT COUNT(*) AS number_of_workers
FROM EmployeeDemographics;


-- Max, min, avg
SELECT MAX(Salary) AS max_salary,
       MIN(Salary) AS min_salary,
	   AVG(Salary) AS average_salary
FROM [SQL Tutorial].dbo.EmployeeSalary;