/*
Aliasing
https://www.youtube.com/watch?v=Dk7he_yEs4U&list=PLUaB-1hjhk8HTgPnBukmMq7QTe83ANirL&index=6
*/

SELECT FirstName + ' ' + LastName AS FullName
FROM EmployeeDemographics

SELECT Demo.EmployeeID, Sal.Salary
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID;

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.Jobtitle, WareDemo.Age
FROM EmployeeDemographics Demo
LEFT JOIN EmployeeSalary Sal ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics WareDemo ON Demo.EmployeeID = WareDemo.EmployeeID;

