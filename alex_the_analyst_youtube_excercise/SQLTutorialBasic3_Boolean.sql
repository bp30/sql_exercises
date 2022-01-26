/* 
Where Statement
=, <>, <,>, AND, OR, LIKE, NULL, NOT NULL, IN
https://www.youtube.com/watch?v=A9TOuDZTPDU&list=PLUaB-1hjhk8GT6N5ne2qpf603sF26m2PW&index=3
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