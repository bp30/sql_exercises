/* 
String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

 -- Drop Table EmployeeErrors;
 DROP TABLE IF EXISTS EmployeeErrors
 CREATE TABLE EmployeeErrors (
 EmployeeID varchar(50),
 FirstName varchar(50),
 LastName varchar(50)
 )

 INSERT INTO EmployeeErrors VALUES
 ('1001  ', 'Jimbo', 'Halbert'),
 ('   1002', 'Pamela', 'Beasely'),
 ('1005', 'TOby', 'Flenderson - Fired')

 SELECT *
 FROM EmployeeErrors;

 -- Using Trim, LTRIM, RTRIM
 SELECT EmployeeID, TRIM(EmployeeID) AS ID
 FROM EmployeeErrors;

 SELECT EmployeeID, LTRIM(EmployeeID) AS ID
 FROM EmployeeErrors;

 SELECT EmployeeID, RTRIM(EmployeeID) AS ID
 FROM EmployeeErrors;


-- Using replace, replace - Fired with ''
SELECT LastName, REPLACE(LastName, '- Fired',  '') AS LastNameFixed
FROM EmployeeErrors;


-- Using substring - display first 3 letters of FirstName
SELECT SUBSTRING(err.FirstName, 1, 3)
FROM EmployeeErrors
-- fuzy matching - match rows according to similar character words using substring 
SELECT err.FirstName, SUBSTRING(err.FirstName, 1, 3), dem.FirstName, SUBSTRING(dem.FirstName, 1, 3);
FROM EmployeeErrors err
INNER JOIN EmployeeDemographics dem ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName, 1, 3);
-- fuzy match on Gender, LastName, Age and DOB will be pretty accurate on matching people


-- Using upper and lower
SELECT UPPER(FirstName), LOWER(FirstName)
FROM EmployeeErrors;