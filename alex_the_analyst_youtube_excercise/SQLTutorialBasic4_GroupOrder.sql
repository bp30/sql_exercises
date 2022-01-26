/* 
Group By, Order By
*/

SELECT DISTINCT(Gender), COUNT(*)
FROM EmployeeDemographics
GROUP BY Gender


SELECT DISTINCT(d.Gender), AVG(s.Salary) AS averaged_salary
FROM EmployeeDemographics d
INNER JOIN EmployeeSalary s 
ON d.EmployeeID = s.EmployeeID
GROUP BY Gender
ORDER BY Gender DESC;