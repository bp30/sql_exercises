/* 
Partition by
*/
SELECT *
FROM EmployeeDemographics;
SELECT * 
FROM EmployeeSalary;

-- GROUP BY will reduce the  number of rows whereas PARTITION BY we can isolate one column we want to do our aggregate function on, 
-- only do one column for aggregate
SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER(PARTITION BY Gender) AS TotalGender
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal ON demo.EmployeeID = sal.EmployeeID;

--  Compare to GROUP BY see we do not get the same ouput as previous syntax
SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) AS TotalGender
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal ON demo.EmployeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary;