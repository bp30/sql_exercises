/* 
Group By, Order By
https://www.youtube.com/watch?v=LXwfzIRD-Ds&list=PLUaB-1hjhk8GT6N5ne2qpf603sF26m2PW&index=4
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