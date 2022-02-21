/*
w3resource SQL exercises

Hospital database (39 exercises)
https://www.w3resource.com/sql-exercises/hospital-database-exercise/sql-exercise-on-hospital-database.php
*/

-- 1. From the following table, write a SQL query to find those nurses who are yet to be registered. Return all the fields of nurse table.
SELECT *
FROM nurse 
WHERE registered = 'f';

-- 2. From the following table, write a SQL query to find the nurse who is the head of their department. Return Nurse Name as "name", Position as "Position". 
SELECT name,
       position
FROM nurse
WHERE position = 'Head Nurse';

-- 3. From the following tables, write a SQL query to find those physicians who are the head of the department. Return Department name as "Department" and Physician name as "Physician".
SELECT dep.name AS Department, 
       phy.name AS Physician
FROM physician phy
JOIN department dep ON phy.employeeid = dep.head;


-- 4. From the following table, write a SQL query to count the number of patients who booked an appointment with at least one Physician. Return count as "Number of patients taken at least one appointment". 
SELECT COUNT(DISTINCT patient) AS "No. of patients taken at least one appointment"
FROM appointment;

-- 5. From the following table, write a SQL query to find the floor and block where the room number 212 belongs. Return block floor as "Floor" and block code as "Block".
SELECT blockfloor AS "Floor",
       blockcode AS "Block"
FROM room 
WHERE roomnumber = 212;

-- 6. From the following table, write a SQL query to count the number available rooms. Return count as "Number of available rooms".
SELECT COUNT(*) AS "Number of available rooms"
FROM room 
WHERE unavailable = 'f';

-- 7. From the following table, write a SQL query to count the number of unavailable rooms. Return count as "Number of unavailable rooms".
SELECT COUNT(*) AS "Number of unavailable rooms"
FROM room 
WHERE unavailable = 't';

-- 8. From the following tables, write a SQL query to find the physician and the departments they are affiliated with. Return Physician name as "Physician", and department name as "Department".
SELECT phy.name AS Physician,
       dep.name AS Department
FROM physician phy
JOIN affiliated_with aff ON phy.employeeid = aff.physician
JOIN department dep ON aff.department = dep.departmentid;

-- 9. From the following tables, write a SQL query to find those physicians who have trained for special treatment. Return Physician name as "Physician", treatment procedure name as "Treatment". 
SELECT phy.name AS Physician,
       pro.name AS Treatment
FROM physician phy
JOIN trained_in train ON phy.employeeid = train.physician
JOIN procedure pro ON train.treatment = pro.code;

-- 10. From the following tables, write a SQL query to find those physicians who are yet to be affiliated. Return Physician name as "Physician", Position, and department as "Department".
SELECT phy.name AS Physician,
       dep.name AS Department
FROM physician phy
JOIN affiliated_with aff ON phy.employeeid = aff.physician
JOIN department dep ON aff.department = dep.departmentid
WHERE primaryaffiliation = 'f';

-- 11. From the following tables, write a SQL query to find those physicians who are not a specialized physician. Return Physician name as "Physician", position as "Designation".
SELECT name AS Physician,
       position AS Designation
FROM physician phy
LEFT JOIN trained_in train ON phy.employeeid = train.physician
WHERE train.treatment IS NULL
ORDER BY employeeid;

-- 12. From the following tables, write a SQL query to find the patients with their physicians by whom they got their preliminary treatment. Return Patient name as "Patient", address as "Address" and Physician name as "Physician". 
SELECT pat.name AS Patient,
       pat.address AS Address,
       phy.name AS Physician
FROM patient pat
JOIN physician phy ON pat.pcp = phy.employeeid;

-- 13. From the following tables, write a SQL query to find the patients and the number of physicians they have taken appointment. Return Patient name as "Patient", number of Physicians as "Appointment for No. of Physicians".
SELECT pat.name AS Patient,
       COUNT(app.physician)
FROM appointment app
JOIN patient pat ON app.patient = pat.ssn
GROUP BY pat.name;

-- 14.  From the following table, write a SQL query to count number of unique patients who got an appointment for examination room ‘C’. Return unique patients as “No. of patients got appointment for room C”. 
SELECT COUNT(DISTINCT patient) AS "No. of patients got appointment for room C"
FROM appointment 
WHERE examinationroom = 'C';

-- 15. From the following tables, write a SQL query to find the name of the patients and the number of the room where they have to go for their treatment. Return patient name as “Patient”, examination room as "Room No.”, and starting date time as Date "Date and Time of appointment".
SELECT pat.name AS Patient,
       app.examinationroom AS "Room No.",
       app.start_dt_time AS "Date and Time of appointment"
FROM patient pat
JOIN appointment app ON pat.ssn = app.patient;

-- 16. From the following tables, write a SQL query to find the name of the nurses and the room scheduled, where they will assist the physicians. Return Nurse Name as “Name of the Nurse” and examination room as “Room No.”.
SELECT nurse.name AS "Name of the Nurse",
       app.examinationroom AS "Room No."
FROM nurse
JOIN appointment app ON nurse.employeeid = app.prepnurse;

-- 17. From the following tables, write a SQL query to find those patients who taken the appointment on the 25th of April at 10 am. 
--     Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as "Name of the physician", examination room as "Room No.", schedule date and approximate time to meet the physician.
SELECT pat.name AS "Patient name",
       phy.name AS "Name of the physician",
       nurse.name AS "Name of assisting nurse",
       app.examinationroom AS "Room No.",
       app.start_dt_time AS "Date and time"
FROM appointment app
LEFT JOIN patient pat ON app.patient = pat.ssn
LEFT JOIN nurse ON app.prepnurse = nurse.employeeid
LEFT JOIN physician phy ON app.physician = phy.employeeid
WHERE start_dt_time = '2008-04-25 10:00:00';

-- 18. From the following tables, write a SQL query to find those patients and their physicians who do not require any assistance of a nurse. Return Name of the patient as "Name of the patient", Name of the Physician as "Name of the physician" and examination room as "Room No.".
SELECT pat.name AS "Patient name",
       phy.name AS "Name of the physician",
       app.examinationroom AS "Room No."
FROM appointment app
LEFT JOIN patient pat ON app.patient = pat.ssn
LEFT JOIN nurse ON app.prepnurse = nurse.employeeid
LEFT JOIN physician phy ON app.physician = phy.employeeid
WHERE app.prepnurse IS NULL;

-- 19. From the following tables, write a SQL query to find the patients and their treating physicians and medication. Return Patient name as "Patient", Physician name as "Physician", Medication name as "Medication".
SELECT pat.name AS Patient,
       phy.name AS Physician,
       med.name AS Medication
FROM patient pat
JOIN prescribes pre ON pat.ssn = pre.patient
JOIN physician phy ON pre.physician = phy.employeeid
JOIN medication med ON pre.medication = med.code;


-- 20. From the following tables, write a SQL query to find those patients who have taken an advanced appointment. Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication". 
SELECT pat.name AS Patient,
       phy.name AS Physician,
       med.name AS Medication
FROM patient pat
JOIN prescribes pre ON pat.ssn = pre.patient
JOIN physician phy ON pre.physician = phy.employeeid
JOIN medication med ON pre.medication = med.code
WHERE pre.appointment IS NOT NULL;

-- 21. From the following tables, write a SQL query to find those patients who did not take any appointment. Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".
SELECT pat.name AS Patient,
       phy.name AS Physician,
       med.name AS Medication
FROM patient pat
JOIN prescribes pre ON pat.ssn = pre.patient
JOIN physician phy ON pre.physician = phy.employeeid
JOIN medication med ON pre.medication = med.code
WHERE pre.appointment IS NULL;

-- 22. From the following table, write a SQL query to count the number of available rooms in each block. Sort the result-set on ID of the block. Return ID of the block as "Block", count number of available rooms as "Number of available rooms". 
SELECT blockcode AS block,
       COUNT(*) AS "Number of available rooms"
FROM room
WHERE unavailable = 'f'
GROUP BY blockcode;

-- 23. From the following table, write a SQL query to count the number of available rooms in each floor. Sort the result-set on block floor. Return floor ID as "Floor" and count the number of available rooms as "Number of available rooms".
SELECT blockfloor AS floor,
       COUNT(*) AS "Number of available rooms"
FROM room
WHERE unavailable = 'f'
GROUP BY blockfloor;

-- 24. From the following table, write a SQL query to count the number of available rooms for each floor in each block. Sort the result-set on floor ID, ID of the block. Return the floor ID as "Floor", ID of the block as "Block", and number of available rooms as "Number of available rooms". 
SELECT blockfloor AS floor,
       blockcode AS block,
       COUNT(*) AS "Number of available rooms"
FROM room
WHERE unavailable = 'f'
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode;

-- 25. From the following tables, write a SQL query to count the number of unavailable rooms for each block in each floor. Sort the result-set on block floor, block code. Return the floor ID as "Floor", block ID as "Block", and number of unavailable as "Number of unavailable rooms".
SELECT blockfloor AS floor,
       blockcode AS block,
       COUNT(*) AS "Number of unavailable rooms"
FROM room
WHERE unavailable = 't'
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode;

-- 26. From the following table, write a SQL query to find the floor where the maximum numbers of rooms are available. Return floor ID as "Floor", count "Number of available rooms".
WITH floor_room AS (
SELECT blockfloor,
       COUNT(*) AS avail_rooms
FROM room
WHERE unavailable = 'f'
GROUP BY blockfloor
)

SELECT *
FROM floor_room
WHERE avail_rooms = (SELECT MAX(avail_rooms)
		     FROM floor_room);

-- 27. From the following table, write a SQL query to find the floor where the minimum numbers of rooms are available. Return floor ID as “Floor”, Number of available rooms.
WITH floor_room AS (
SELECT blockfloor,
       COUNT(*) AS avail_rooms
FROM room
WHERE unavailable = 'f'
GROUP BY blockfloor
)

SELECT *
FROM floor_room
WHERE avail_rooms = (SELECT MIN(avail_rooms)
		     FROM floor_room);

-- 28. From the following tables, write a SQL query to find the name of the patients, their block, floor, and room number where they admitted.
SELECT pat.name AS Patient,
       blockcode AS Block,
       blockfloor AS Floor,
       stay.room 
FROM stay
JOIN patient pat ON stay.patient = pat.ssn
JOIN room ON stay.room = room.roomnumber;

-- 29. From the following tables, write a SQL query to find the nurses and the block where they are booked for attending the patients on call. Return Nurse Name as “Nurse”, Block code as "Block". 
SELECT nurse.name AS Nurse,
       blockcode AS Block
FROM nurse
JOIN on_call ON nurse.employeeid = on_call.nurse;

-- 30. From the following tables, write a SQL query to get
--      a) name of the patient,
--	b) name of the physician who is treating him or her,
--	c) name of the nurse who is attending him or her,
--	d) which treatement is going on to the patient,
--	e) the date of release,
--	f) in which room the patient has admitted and which floor and block the room belongs to respectively.  
SELECT pat.name AS Patient,
       phy.name AS Physician,
       nurse.name AS Nurse,
       pro.name AS Treatment,
       stay.end_time,
       room.roomnumber,
       room.blockcode AS Block,
       room.blockfloor AS Floor
FROM undergoes go
LEFT JOIN patient pat ON go.patient = pat.ssn
LEFT JOIN physician phy ON go.physician = phy.employeeid
LEFT JOIN nurse ON go.assistingnurse = nurse.employeeid
LEFT JOIN stay ON go.stay = stay.stayid
LEFT JOIN room ON stay.room = room.roomnumber
LEFT JOIN procedure pro ON go.procedure = pro.code;

-- 31. From the following tables, write a SQL query to find all those physicians who performed a medical procedure, but they are not certified to perform. Return Physician name as “Physician”. 
WITH phy_go AS (
SELECT go.physician
FROM undergoes go
LEFT JOIN trained_in trained ON go.physician = trained.physician
				AND go.procedure = trained.treatment
WHERE trained.treatment IS NULL
)

SELECT name AS Physician
FROM physician
WHERE employeeid = (SELECT physician
		    FROM phy_go);

-- 32. From the following tables, write a SQL query to find all the physicians, their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not certified for that procedure. 
--     Return Physician Name as "Physician", Procedure Name as "Procedure", date, and Patient. Name as "Patient". 
WITH phy_go AS (
SELECT go.physician,
       go.procedure
FROM undergoes go
LEFT JOIN trained_in trained ON go.physician = trained.physician
				AND go.procedure = trained.treatment
WHERE trained.treatment IS NULL
)

SELECT phy.name AS Physician,
       pro.name AS Procedure,
       go.date,
       pat.name AS Patient
FROM physician phy
JOIN undergoes go ON phy.employeeid = go.physician
JOIN procedure pro ON go.procedure = pro.code
JOIN patient pat ON go.patient = pat.ssn
WHERE phy.employeeid = (SELECT physician
			FROM phy_go)  
      AND go.procedure = (SELECT procedure
			  FROM phy_go);

-- 33. From the following table, write a SQL query to find all those physicians who completed a medical procedure with certification after the date of expiration of their certificate. Return Physician Name as "Physician", Position as "Position". 
SELECT phy.name AS Physician,
       phy.position AS Position
FROM physician phy
JOIN undergoes go ON phy.employeeid = go.physician
JOIN trained_in trained ON go.physician = trained.physician
			   AND go.procedure = trained.treatment
WHERE go.date > trained.certificationexpires;

-- 34. From the following table, write a SQL query to find all those physicians who completed a medical procedure with certification after the date of expiration of their certificate. 
--     Return Physician Name as “Physician”, Position as "Position", Procedure Name as “Procedure”, Date of Procedure as “Date of Procedure”, Patient Name as “Patient”, and expiry date of certification as “Expiry Date of Certificate”. 
SELECT phy.name AS Physician,
       phy.position AS Position,
       pro.name AS Procedure,
       go.date AS "Date of Procedure",
       pat.name AS Patient,
       trained.certificationexpires AS "Expiry Date of Certificate"
FROM physician phy
JOIN undergoes go ON phy.employeeid = go.physician
JOIN trained_in trained ON go.physician = trained.physician
			   AND go.procedure = trained.treatment
JOIN procedure pro ON go.procedure = pro.code
JOIN patient pat ON go.patient = pat.ssn
WHERE go.date > trained.certificationexpires;

-- 35. From the following table, write a SQL query to find those nurses who have ever been on call for room 122. Return name of the nurses
SELECT nurse.name 
FROM nurse
JOIN on_call ON nurse.employeeid = on_call.nurse
JOIN room ON on_call.blockcode = room.blockcode
	     AND on_call.blockfloor = room.blockfloor
WHERE room.roomnumber = 122;
	     
-- 36. From the following table, write a SQL query to find those patients who have been prescribed by some medication by his/her physician who has carried out primary care. Return Patient name as “Patient”, and Physician Name as “Physician”.
SELECT DISTINCT pat.name AS Patient,
       phy.name AS Physician
FROM patient pat
JOIN prescribes pre ON pat.ssn = pre.patient
		       AND pat.pcp = pre.physician
JOIN physician phy ON pat.pcp = phy.employeeid;

-- 37. From the following table, write a SQL query to find those patients who have been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care. 
--     Return name of the patient as “Patient”, name of the physician as “Primary Physician”, and cost for the procedure as “Procedure Cost”. 
SELECT pat.name AS Patient,
       phy.name AS "Primary Physician",
       pro.cost AS "Procedure Cost"
FROM undergoes go
JOIN patient pat ON go.patient = pat.ssn
JOIN physician phy ON pat.pcp = phy.employeeid
JOIN procedure pro ON go.procedure = pro.code
WHERE pro.cost > 5000;

-- 38. From the following table, write a SQL query to find those patients who had at least two appointments where the nurse who prepped the appointment was a registered nurse and the physician who has carried out primary care. 
--     Return Patient name as “Patient”, Physician name as “Primary Physician”, and Nurse Name as “Nurse”.  
WITH pat_apptn AS (
SELECT patient,
       COUNT(*) AS appt_n
FROM appointment 
GROUP BY patient
HAVING COUNT(*) > 1
)

SELECT pat.name AS Patient,
       phy.name AS Physician,
       nurse.name AS Nurse
FROM appointment app
JOIN patient pat ON app.patient = pat.ssn
JOIN nurse ON app.prepnurse = nurse.employeeid
JOIN physician phy ON pat.pcp = phy.employeeid
WHERE pat.ssn IN (SELECT patient
	          FROM pat_apptn)
      AND nurse.registered = 't';

-- 39. From the following table, write a SQL query to find those patients whose primary care a physician who is not the head of any department takes. Return Patient name as “Patient”, Physician Name as “Primary care Physician”.
SELECT pat.name AS Patient,
       phy.name AS Physician
FROM patient pat
JOIN physician phy ON pat.pcp = phy.employeeid 
WHERE pat.pcp NOT IN (SELECT head
		      FROM department);
