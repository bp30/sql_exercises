/*
Having Clause
https://www.youtube.com/watch?v=tYBOMw7Ob8E&list=PLUaB-1hjhk8HTgPnBukmMq7QTe83ANirL&index=4
*/

-- HAVING is used when an aggregate function is used, cannot use aggregate functions with WHERE clause, WHERE comes before GROUP BY but HAVING comes after
SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics x
JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1;

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics x
JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary);