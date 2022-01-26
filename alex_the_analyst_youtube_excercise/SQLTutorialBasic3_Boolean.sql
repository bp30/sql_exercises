/* 
Where Statement
=, <>, <,>, AND, OR, LIKE, NULL, NOT NULL, IN
*/

SELECT *
FROM EmployeeDemographics
WHERE AGE > 30 AND Gender = 'Male';

SELECT *
FROM EmployeeDemographics
WHERE LastName  LIKE 'S%';

SELECT *
FROM EmployeeDemographics
WHERE LastName IS NOT NULL;

SELECT *
FROM EmployeeDemographics
WHERE LastName IN ('Scott', 'Palmer');