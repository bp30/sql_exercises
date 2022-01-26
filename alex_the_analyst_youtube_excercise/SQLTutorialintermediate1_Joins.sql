/*
Inner joins, Full/left/right/Outer Join
*/
--INSERT INTO  SQLTutorial.dbo.EmployeeDemographics VALUES
--(1011, 'Ryan', 'Howard', 26, 'Male'),
--(NULL, 'Holly', 'Flax', NULL, NULL),
--(1013, 'Darryl', 'Philbin', NULL, 'Male')

--INSERT INTO  SQLTutorial.dbo.EmployeeSalary VALUES
--(1010, NULL, 47000),
--(NULL, 'Salesman', 43000)

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics;

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary;

--INNER JOIN
SELECT *
FROM EmployeeDemographics x
INNER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

-- FULL OUTER JOIN
SELECT *
FROM EmployeeDemographics x
FULL OUTER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

-- LEFT OUTER JOIN
SELECT *
FROM EmployeeDemographics x
LEFT OUTER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

-- LEFT JOIN (same as left outer join)
SELECT *
FROM EmployeeDemographics x
LEFT JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

-- RIGHT OUTER JOIN
SELECT *
FROM EmployeeDemographics x
RIGHT OUTER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

-- RIGHT JOIN (same as right outer join)
SELECT *
FROM EmployeeDemographics x
RIGHT JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

-- Select specific fields
SELECT x.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics x
INNER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID

SELECT x.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics x
LEFT JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID


-- Find highest paid person
SELECT x.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics x
FULL OUTER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC;

-- Find average salary of salesmen
SELECT Jobtitle, AVG(Salary)
FROM EmployeeDemographics x
INNER JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle;


