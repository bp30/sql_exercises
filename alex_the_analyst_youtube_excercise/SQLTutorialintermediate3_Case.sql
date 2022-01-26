/* 
CASE statement
https://www.youtube.com/watch?v=Twusw__OzA8&list=PLUaB-1hjhk8HTgPnBukmMq7QTe83ANirL&index=3
*/

SELECT FirstName, LastName, Age,
	CASE 
		WHEN Age > 30 THEN 'Old'
		ELSE 'Young'
	END AS OldYoung
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, Age,
	CASE 
		WHEN Age > 30 THEN 'Old'
		WHEN Age BETWEEN 27 AND 30 THEN 'Young'
		ELSE 'Baby'
	END AS OldYoung
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age;


SELECT FIrstName, LastName, JobTitle, Salary, 
	CASE
		WHEN Jobtitle = 'Salesman' THEN Salary * 1.1
		WHEN Jobtitle = 'Accountant' THEN Salary * 1.05
		WHEN Jobtitle = 'HR' THEN Salary *1.000001
		ELSE Salary * 1.03
	END AS Raises
FROM EmployeeDemographics x
JOIN EmployeeSalary y ON x.EmployeeID = y.EmployeeID
ORDER BY Salary DESC;