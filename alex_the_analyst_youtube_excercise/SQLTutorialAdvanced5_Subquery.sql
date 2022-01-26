/* 
Subqueries
*/

SELECT * 
FROM EmployeeSalary;

-- Subquery in Select
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AverageSalary
FROM EmployeeSalary;

-- How to do it with Partition by instead
SELECT EmployeeID, Salary, AVG(Salary) OVER() as AverageSalary
FROM EmployeeSalary;

-- Why Group by does not work
SELECT EmployeeID, Salary, AVG(Salary) AS AverageSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1, 2;

-- Subquery in From (should prefer temp table or CTE since subquery is more slow)
SELECT a.EmployeeID, AverageSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER() AS AverageSalary
      FROM EmployeeSalary) a;

-- Subquery in where
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeDemographics WHERE Age > 30);