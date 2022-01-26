/*
Store Procedures
https://www.youtube.com/watch?v=NrBJmtD0kEw&list=PLUaB-1hjhk8EBZNL4nx4Otoa5Wb--rEpU&index=4
*/

-- Create a procedure called TEST 
CREATE PROCEDURE TEST
AS 
SELECT * 
FROM EmployeeDemographics

-- Execute stored procedure
EXEC TEST


CREATE PROCEDURE Temp_Employee
AS 
CREATE TABLE #temp_employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal ON demo.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee2;

-- we can include parameters by modifying the store procedure by right clicking the stored procedure in the object explorer (on the left)
EXEC Temp_Employee @Jobtitle = 'Salesman'


