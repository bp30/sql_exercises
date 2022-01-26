/* 
Updating and deleting data
*/

SELECT *
FROM EmployeeDemographics

UPDATE EmployeeDemographics 
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax';

-- Should use Select data first to look at what will be deleted
DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1005