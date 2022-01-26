/* 
Union Union All
*/

-- Create new table
--Create Table WareHouseEmployeeDemographics 
--(EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)

--Insert into WareHouseEmployeeDemographics VALUES
--(1013, 'Darryl', 'Philbin', NULL, 'Male'),
--(1050, 'Roy', 'Anderson', 31, 'Male'),
--(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
--(1052, 'Val', 'Johnson', 31, 'Female')

-- Using JOIN we cannot get the two table to match in column
SELECT *
FROM EmployeeDemographics x
FULL OUTER JOIN WareHouseEmployeeDemographics y ON y.EmployeeID = x.EmployeeID

-- to do this we need UNION, we see that the rows from Warehouse employees and combine with Employee demographics as new row
SELECT *
FROM EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics

-- UNION remove duplicates UNION ALL do not
SELECT *
FROM EmployeeDemographics
UNION ALL 
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY 'EmployeeID'

-- It would work when the two table have different columns (but only if have the same amount of columns and the matching columns have the same data type), but we see that Age 
-- and salary  as well as FirstName and Jobtitle columns are combined incorrectly, so need to check this. When using UNION we need to make sure that the data type are the same
SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary;
