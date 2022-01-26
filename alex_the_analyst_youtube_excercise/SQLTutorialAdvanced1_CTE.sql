/*
CTE - a common table expression (temporary result set created to help manipulate complex subqueries)
https://www.youtube.com/watch?v=K1WeoKxLZ5o&list=PLUaB-1hjhk8EBZNL4nx4Otoa5Wb--rEpU
*/

-- Create a CTE 
WITH CTE_Employee AS (
SELECT FirstName, LastName, Gender, Salary,
	   COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
	   AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal ON demo.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)

-- we can query of this CTE, CTE is not saved so we need to run each CTE query along with the CTE, it will only work if select statement is directly after the CTE
SELECT *
FROM CTE_Employee