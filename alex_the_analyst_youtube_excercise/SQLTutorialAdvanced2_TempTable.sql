/* 
Temp tables
*/

-- only difference between temp and regular tables is the inclusion of the # sign
CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

INSERT INTO #temp_Employee VALUES(
'1001', 'HR', '45000'
)

SELECT *
FROM #temp_Employee

-- we can directly insert values from another table to a temporary table
INSERT INTO #temp_Employee 
SELECT *
FROM EmployeeSalary


DROP TABLE IF EXIST #temp_employee2 -- use this if we need to run the script multiple time
CREATE TABLE #temp_employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #temp_employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal ON demo.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee2